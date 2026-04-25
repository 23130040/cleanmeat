package cleanmeat.cleanmeat.controller;

import cleanmeat.cleanmeat.dao.*;
import cleanmeat.cleanmeat.model.Category;
import cleanmeat.cleanmeat.model.Item;
import cleanmeat.cleanmeat.model.ItemImages;
import cleanmeat.cleanmeat.model.Origin;
import cleanmeat.cleanmeat.model.Unit;
import cleanmeat.cleanmeat.model.User;
import cleanmeat.cleanmeat.service.ItemService;
import cleanmeat.cleanmeat.service.ItemService;
import cleanmeat.cleanmeat.utils.R2Util;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.Collection;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializer;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "products-admin", value = "/products-admin")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class ProductsAdmin extends HttpServlet {
    private final CategoryDAO categoryDAO = new CategoryDAOImpl();
    private final OriginDAO originDAO = new OriginDAOImpl();
    private final UnitDAO unitDAO = new UnitDAOImpl();
    private final ItemService itemService = new ItemService();
    private final Gson gson = new GsonBuilder()
            .registerTypeAdapter(LocalDateTime.class, (JsonSerializer<LocalDateTime>) (src, typeOfSrc, context) -> 
                new JsonPrimitive(src.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))))
            .create();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("getDetail".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Item item = itemService.findById(id);
                if (item != null) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(gson.toJson(item));
                    return;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean deleted = itemService.delete(id);
                if (deleted) {
                    response.sendRedirect(request.getContextPath() + "/products-admin?success=product_deleted");
                } else {
                    response.sendRedirect(request.getContextPath() + "/products-admin?error=delete_failed");
                }
                return;
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/products-admin?error=delete_failed");
                return;
            }
        }

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        int page = 1;
        int limit = 10;
        
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int categoryId = 0;
        String categoryParam = request.getParameter("categoryId");
        if (categoryParam != null && !categoryParam.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryParam);
            } catch (NumberFormatException e) {
                categoryId = 0;
            }
        }

        String keyword = request.getParameter("keyword");

        int totalItems = itemService.countAllItems(categoryId, keyword);
        int totalPages = (int) Math.ceil((double) totalItems / limit);
        
        if (page > totalPages && totalPages > 0) {
            page = totalPages;
        } else if (page < 1) {
            page = 1;
        }
        
        int offset = (page - 1) * limit;

        List<Item> items = itemService.getItemsByPage(limit, offset, categoryId, keyword);
        
        List<Category> categories = categoryDAO.findAll();
        List<Origin> origins = originDAO.findAll();
        List<Unit> units = unitDAO.findAll();

        request.setAttribute("categories", categories);
        request.setAttribute("origins", origins);
        request.setAttribute("units", units);
        request.setAttribute("selectedCategoryId", categoryId);
        request.setAttribute("keyword", keyword);
        
        request.setAttribute("items", items);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalItems", totalItems);
        request.setAttribute("limit", limit);
        request.setAttribute("offset", offset);
        
        request.setAttribute("adminTitle", "Quản lý sản phẩm");
        request.setAttribute("active", "products-admin");
        request.setAttribute("user", currentUser);
        request.setAttribute("pageContent", "/view/admin/productsAdmin.jsp");
        request.setAttribute("pageCss", "productsAdmin.css");
        request.setAttribute("pageJs", "productsAdmin.js");
        
        request.getRequestDispatcher("/view/admin/baseAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        boolean success = false;

        if ("add".equals(action) || "edit".equals(action)) {
            try {
                String name = request.getParameter("name");
                String shortDescription = request.getParameter("short_description");
                String longDescription = request.getParameter("long_description");
                int categoryId = Integer.parseInt(request.getParameter("category_id"));
                int originId = Integer.parseInt(request.getParameter("origin_id"));
                String unitName = request.getParameter("unit_name");
                double price = Double.parseDouble(request.getParameter("price"));
                double discount = Double.parseDouble(request.getParameter("discount"));
                int currentStock = Integer.parseInt(request.getParameter("current_stock"));
                int minStock = Integer.parseInt(request.getParameter("min_stock"));
                String packaging = request.getParameter("packaging");

                Unit unit = unitDAO.findByName(unitName);
                int unitId;
                if (unit != null) {
                    unitId = unit.getId();
                } else {
                    Unit newUnit = new Unit();
                    newUnit.setName(unitName);
                    newUnit.setAmount(1.0);
                    unitId = unitDAO.insert(newUnit);
                }

                Item item = new Item();
                if ("edit".equals(action)) {
                    int id = Integer.parseInt(request.getParameter("id"));
                    item = itemService.findById(id);
                }
                
                item.setName(name);
                item.setShort_description(shortDescription);
                item.setLong_description(longDescription);
                item.setCategory_id(categoryId);
                item.setOrigin_id(originId);
                item.setUnit_id(unitId);
                item.setPrice(price);
                item.setDiscount(discount);
                item.setCurrent_stock(currentStock);
                item.setMin_stock(minStock);
                item.setPackaging(packaging);

                int itemId;
                if ("edit".equals(action)) {
                    success = itemService.update(item);
                    itemId = item.getId();
                } else {
                    itemId = itemService.insert(item);
                    success = itemId > 0;
                }

                if (success) {
                    int primaryIndex = 0;
                    String primaryParam = request.getParameter("primaryImageIndex");
                    if (primaryParam != null) {
                        try { primaryIndex = Integer.parseInt(primaryParam); } catch (Exception ignored) {}
                    }
                    
                    Collection<Part> imageParts = request.getParts();
                    R2Util r2Util = new R2Util();
                    ItemImagesDAO itemImagesDAO = new ItemImagesDAOImpl();
                    int currentIdx = 0;
                    
                    for (Part part : imageParts) {
                        if (part.getName().equals("productImages") && part.getSize() > 0) {
                            String fileName = "item_" + itemId + "_" + System.currentTimeMillis() + "_" + part.getSubmittedFileName();
                            String imageUrl = r2Util.uploadFile(fileName, part.getInputStream(), part.getSize(), part.getContentType());
                            
                            ItemImages image = new ItemImages();
                            image.setItem_id(itemId);
                            image.setUrl(imageUrl);
                            image.setIs_primary(currentIdx == primaryIndex);
                            itemImagesDAO.insert(image);
                            
                            currentIdx++;
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (success) {
            String msg = "add".equals(action) ? "product_added" : "product_updated";
            response.sendRedirect(request.getContextPath() + "/products-admin?success=" + msg);
        } else {
            response.sendRedirect(request.getContextPath() + "/products-admin?error=action_failed");
        }
    }
}
