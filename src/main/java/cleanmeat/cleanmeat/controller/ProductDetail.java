package cleanmeat.cleanmeat.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import cleanmeat.cleanmeat.dao.ItemDAO;
import cleanmeat.cleanmeat.dao.ItemDAOImpl;
import cleanmeat.cleanmeat.dao.FeedbackDAO;
import cleanmeat.cleanmeat.dao.FeedbackDAOImpl;
import cleanmeat.cleanmeat.model.Item;
import cleanmeat.cleanmeat.model.Feedback;

import cleanmeat.cleanmeat.dao.ItemImagesDAO;
import cleanmeat.cleanmeat.dao.ItemImagesDAOImpl;
import cleanmeat.cleanmeat.model.ItemImages;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "product-detail", value = "/product-detail")
public class ProductDetail extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        int id = Integer.parseInt(request.getParameter("id"));

        ItemDAO itemDAO = new ItemDAOImpl();
        Item item = itemDAO.findById(id);

        ItemImagesDAO itemImagesDAO = new ItemImagesDAOImpl();
        List<ItemImages> itemImages = itemImagesDAO.findByItemId(id);
        request.setAttribute("itemImages", itemImages);

        FeedbackDAO feedbackDAO = new FeedbackDAOImpl();
        List<Feedback> feedbacks = feedbackDAO.findByItemId(id);

        double avgRating = 0;
        if (!feedbacks.isEmpty()) {
            int sum = 0;
            for (Feedback f : feedbacks) {
                sum += f.getRating();
            }
            avgRating = (double) sum / feedbacks.size();
        }
        request.setAttribute("item", item);
        request.setAttribute("feedbacks", feedbacks);
        request.setAttribute("avgRating", Math.round(avgRating));
        request.setAttribute("totalFeedback", feedbacks.size());

        request.setAttribute("pageTitle", "Chi tiết sản phẩm");
        request.setAttribute("pageContent", "/view/productdetail.jsp");
        request.setAttribute("pageCss", "productdetail.css");
        request.setAttribute("active", "product");
        request.setAttribute("pageJs", "productdetail.js");

        request.getRequestDispatcher("/view/customer/base.jsp").forward(request, response);
    }
}