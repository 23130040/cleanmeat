package cleanmeat.cleanmeat.cart;

import cleanmeat.cleanmeat.model.Item;
import cleanmeat.cleanmeat.service.ItemService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/add-to-cart")
public class AddToCart extends HttpServlet {
    ItemService itemService = new ItemService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        int itemId = Integer.parseInt(request.getParameter("itemId"));
        Item item = itemService.findById(itemId);
        int quantity = 1;
        String q = request.getParameter("quantity");
        if (q != null) quantity = Integer.parseInt(q);
        cart.addCartItem(new CartItem(item.getId(), item, quantity));
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        response.getWriter().write("""
                    {
                        "success": true,
                        "totalQuantity": %d
                    }
                """.formatted(cart.getTotalQuantity()));
    }
}