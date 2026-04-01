package cleanmeat.cleanmeat.controller;
import cleanmeat.cleanmeat.cart.Cart;
import cleanmeat.cleanmeat.dao.AddressDAO;
import cleanmeat.cleanmeat.dao.AddressDAOImpl;
import cleanmeat.cleanmeat.dao.TransportDAO;
import cleanmeat.cleanmeat.dao.TransportDAOImpl;
import cleanmeat.cleanmeat.dao.PaymentDAO;
import cleanmeat.cleanmeat.dao.PaymentDAOImpl;
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
        request.getRequestDispatcher( "/view/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
