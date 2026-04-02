package cleanmeat.cleanmeat.cart;

import cleanmeat.cleanmeat.model.Item;
import cleanmeat.cleanmeat.dao.ItemDAO;
import cleanmeat.cleanmeat.dao.ItemDAOImpl;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "add-to-cart", value = "/add-to-cart")
public class AddToCart extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        
        String itemIdParam = request.getParameter("itemId");
        String quantityParam = request.getParameter("quantity");
        String weightParam = request.getParameter("weight");
        
        if (itemIdParam != null) {
            int itemId = Integer.parseInt(itemIdParam);
            int quantity = (quantityParam != null) ? Integer.parseInt(quantityParam) : 1;
            int weight = (weightParam != null) ? Integer.parseInt(weightParam) : 250;
            
            ItemDAO itemDAO = new ItemDAOImpl();
            Item item = itemDAO.findById(itemId);
            
            if (item != null) {
                cart.addCartItem(new CartItem(itemId, item, quantity, weight));
            }

            response.sendRedirect(request.getContextPath() + "/product-detail?id=" + itemId);
        }
    }
}