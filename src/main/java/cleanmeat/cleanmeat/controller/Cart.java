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
        request.setAttribute("pageContent", "/view/cart.jsp");
        request.setAttribute("pageCss", "cart.css");
        request.setAttribute("active", "cart");
        request.getRequestDispatcher("/view/base.jsp").forward(request, response);
    }
}