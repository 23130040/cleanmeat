package cleanmeat.cleanmeat.cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/cart-remove")
public class CartRemove extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int weight = request.getParameter("weight") != null ? Integer.parseInt(request.getParameter("weight")) : 250;
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart != null) {
            cart.removeCartItem(id, weight);
        }
        response.setStatus(200);
    }
}