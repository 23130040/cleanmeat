package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.cart.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Collection;

@WebServlet(name = "cart", value = "/cart")
@jakarta.servlet.annotation.MultipartConfig
public class Cart extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        cleanmeat.cleanmeat.cart.Cart cart = (cleanmeat.cleanmeat.cart.Cart) session.getAttribute("cart");

        if (cart != null) {
            Collection<CartItem> cartItems = cart.getList();
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("subtotal", cart.getTotal());
            request.setAttribute("total", cart.getTotal());

            session.setAttribute("cartTotalQuantity", cart.getTotalQuantity());
        } else {
            request.setAttribute("cartItems", null);
            request.setAttribute("subtotal", 0.0);
            request.setAttribute("total", 0.0);
            session.setAttribute("cartTotalQuantity", 0);
        }

        request.setAttribute("pageTitle", "Giỏ hàng");
        request.setAttribute("pageContent", "/view/customer/cart.jsp");
        request.setAttribute("pageCss", "cart.css");
        request.setAttribute("pageJs", "cart.js");
        request.setAttribute("active", "cart");
        request.getRequestDispatcher("/view/customer/base.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        cleanmeat.cleanmeat.cart.Cart cart = (cleanmeat.cleanmeat.cart.Cart) session.getAttribute("cart");

        if (cart == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        String action = request.getParameter("action");
        if (action == null) return;

        switch (action) {
            case "update":
                try {
                    String itemIdStr = request.getParameter("itemId");
                    String quantityStr = request.getParameter("quantity");
                    String weightStr = request.getParameter("weight");
                    if (itemIdStr != null && quantityStr != null && weightStr != null) {
                        int updateId = Integer.parseInt(itemIdStr);
                        int quantity = Integer.parseInt(quantityStr);
                        int weight = Integer.parseInt(weightStr);
                        cart.updateQuantity(updateId, weight, quantity);
                    }
                } catch (NumberFormatException e) {
                    System.err.println("Cart update error: " + e.getMessage());
                }
                break;
            case "updateWeight":
                try {
                    String itemIdStr = request.getParameter("itemId");
                    String oldWeightStr = request.getParameter("oldWeight");
                    String newWeightStr = request.getParameter("newWeight");
                    if (itemIdStr != null && oldWeightStr != null && newWeightStr != null) {
                        int itemId = Integer.parseInt(itemIdStr);
                        int oldWeight = Integer.parseInt(oldWeightStr);
                        int newWeight = Integer.parseInt(newWeightStr);
                        cart.updateWeight(itemId, oldWeight, newWeight);
                    }
                } catch (NumberFormatException e) {
                    System.err.println("Cart updateWeight error: " + e.getMessage());
                }
                break;
            case "remove":
                try {
                    String itemIdStr = request.getParameter("itemId");
                    String weightStr = request.getParameter("weight");
                    if (itemIdStr != null && weightStr != null) {
                        int removeId = Integer.parseInt(itemIdStr);
                        int weight = Integer.parseInt(weightStr);
                        cart.removeCartItem(removeId, weight);
                    }
                } catch (NumberFormatException e) {
                    System.err.println("Cart remove error: " + e.getMessage());
                }
                break;
            case "clear":
                cart.clear();
                break;
        }

        session.setAttribute("cartTotalQuantity", cart.getTotalQuantity());

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(String.format(
                "{\"success\": true, \"cartCount\": %d, \"total\": %.0f, \"subtotal\": %.0f}",
                cart.getTotalQuantity(),
                cart.getTotal(),
                cart.getTotal()
        ));
    }
}