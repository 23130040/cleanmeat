package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.cart.Cart;
import cleanmeat.cleanmeat.dao.AddressDAO;
import cleanmeat.cleanmeat.dao.AddressDAOImpl;
import cleanmeat.cleanmeat.dao.TransportDAO;
import cleanmeat.cleanmeat.dao.TransportDAOImpl;
import cleanmeat.cleanmeat.dao.PaymentDAO;
import cleanmeat.cleanmeat.dao.PaymentDAOImpl;
import cleanmeat.cleanmeat.dao.OrdersDAO;
import cleanmeat.cleanmeat.dao.OrdersDAOImpl;
import cleanmeat.cleanmeat.dao.OrdersItemDAO;
import cleanmeat.cleanmeat.dao.OrdersItemDAOImpl;
import cleanmeat.cleanmeat.model.Address;
import cleanmeat.cleanmeat.model.Transport;
import cleanmeat.cleanmeat.model.Payment;
import cleanmeat.cleanmeat.model.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "checkout", value = "/checkout")
public class Checkout extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Cart cart = (Cart) session.getAttribute("cart");

        if (user != null) {
            AddressDAO addressDAO = new AddressDAOImpl();
            List<Address> addresses = addressDAO.findByUserId(user.getId());
            request.setAttribute("addresses", addresses);

            TransportDAO transportDAO = new TransportDAOImpl();
            List<Transport> transports = transportDAO.findAll().stream()
                    .filter(Transport::isStatus)
                    .toList();
            request.setAttribute("transports", transports);

            PaymentDAO paymentDAO = new PaymentDAOImpl();
            List<Payment> payments = paymentDAO.findByStatus(true);
            request.setAttribute("payments", payments);
        }

        if (cart != null) {
            double subtotal = cart.getTotal();
            double shipping = 0;

            @SuppressWarnings("unchecked")
            List<Transport> transports = (List<Transport>) request.getAttribute("transports");
            if (transports != null && !transports.isEmpty()) {
                Transport firstTransport = transports.get(0);
                if (subtotal >= firstTransport.getFree_ship()) {
                    shipping = 0;
                } else {
                    shipping = firstTransport.getBase_fee();
                }
            }

            double total = subtotal + shipping;

            request.setAttribute("cartItems", cart.getList());
            request.setAttribute("subtotal", subtotal);
            request.setAttribute("shipping", shipping);
            request.setAttribute("total", total);
        }

        request.setAttribute("pageTitle", "Tiến hành đặt hàng");
        request.setAttribute("pageContent", "/view/checkout.jsp");
        request.setAttribute("pageCss", "checkout.css");
        request.setAttribute("pageJs", "checkout.js");
        request.getRequestDispatcher("/view/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Cart cart = (Cart) session.getAttribute("cart");

        if (user == null || cart == null || cart.getList().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            int transportId = Integer.parseInt(request.getParameter("transportId"));
            int paymentId = Integer.parseInt(request.getParameter("paymentId"));

            String addressParam = request.getParameter("addressId");

            int addressId;

            if ("new".equals(addressParam)) {
                String newAddress = request.getParameter("address");
                AddressDAO addressDAO = new AddressDAOImpl();
                Address addr = new Address();
                addr.setUser_id(user.getId());
                addr.setAddress(newAddress);
                addr.setIs_Default(false);
                addressId = addressDAO.insert(addr);
            } else {
                addressId = Integer.parseInt(addressParam);
            }

            if (addressId <= 0) {
                System.out.println("[Checkout] Failed to get valid address ID.");
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"message\": \"Không thể xác định địa chỉ giao hàng.\"}");
                return;
            }

            TransportDAO transportDAO = new TransportDAOImpl();
            Transport transport = transportDAO.findById(transportId);

            double subtotal = cart.getTotal();
            double shippingFee = (subtotal >= transport.getFree_ship()) ? 0 : transport.getBase_fee();
            double total = subtotal + shippingFee;

            OrdersDAO ordersDAO = new OrdersDAOImpl();
            cleanmeat.cleanmeat.model.Orders order = new cleanmeat.cleanmeat.model.Orders();
            order.setUser_id(user.getId());
            order.setTotal_price(total);
            order.setStatus("Chờ xác nhận");
            order.setAddress_id(addressId);
            order.setTransport_id(transportId);
            order.setPayment_id(paymentId);

            int orderId = ordersDAO.insert(order);

            if (orderId > 0) {
                OrdersItemDAO oiDAO = new OrdersItemDAOImpl();
                for (cleanmeat.cleanmeat.cart.CartItem ci : cart.getList()) {
                    cleanmeat.cleanmeat.model.OrdersItem oi = new cleanmeat.cleanmeat.model.OrdersItem();
                    oi.setOrder_id(orderId);
                    oi.setItem_id(ci.getId());
                    oi.setPrice(ci.getUnitPrice());
                    oi.setWeight(ci.getWeight());
                    oi.setQuantity(ci.getQuantity());
                    oiDAO.insert(oi);
                }

                PaymentDAO paymentDAO = new PaymentDAOImpl();
                String paymentMethod = paymentDAO.findById(paymentId).getName();

                if (paymentMethod.toLowerCase().contains("cod") || paymentMethod.toLowerCase().contains("nhận hàng")) {
                    session.removeAttribute("cart");
                }

                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                String qrUrl = "";
                String payUrl = "";

                if (paymentMethod.toLowerCase().contains("momo")) {
                    qrUrl = "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=MOMO_" + orderId;
                } else if (paymentMethod.toLowerCase().contains("vnpay")) {
                    qrUrl = "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=VNPAY_" + orderId;
                }

                response.getWriter().write(String.format(
                        "{\"success\": true, \"orderId\": %d, \"paymentMethod\": \"%s\", \"qrUrl\": \"%s\", \"payUrl\": \"%s\"}",
                        orderId, paymentMethod, qrUrl, payUrl
                ));
            } else {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": false}");
        }
    }
}
