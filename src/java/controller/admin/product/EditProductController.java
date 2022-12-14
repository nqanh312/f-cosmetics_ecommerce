/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.admin.product;

import com.google.gson.Gson;
import controller.admin.auth.BaseAuthAdminController;
import controller.admin.group.EditGroupController;
import dal.auth.UserDBContext;
import dal.product.CategoryDBContext;
import dal.product.GroupDBContext;
import dal.product.ImageDBContext;
import dal.product.ProductDBContext;
import dal.product.StateDBContext;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.auth.User;
import model.product.Category;
import model.product.Group;
import model.product.Image;
import model.product.Product;
import model.product.State;
import utils.FileManage;
import utils.Validate;

/**
 *
 * @author LENOVO
 */
@MultipartConfig
public class EditProductController extends BaseAuthAdminController {

    private final Validate validate = new Validate();

    @Override
    protected boolean isPermissionGet(HttpServletRequest request) {
        UserDBContext userDB = new UserDBContext();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("admin");
        int numEdit = userDB.getNumberOfPermission(user.getId(), "PRODUCT", "EDIT");
        return numEdit >= 1;
    }

    @Override
    protected boolean isPermissionPost(HttpServletRequest request) {
        UserDBContext userDB = new UserDBContext();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("admin");
        int numEdit = userDB.getNumberOfPermission(user.getId(), "PRODUCT", "EDIT");
        return numEdit >= 1;
    }

    @Override
    protected void processGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Validate validate = new Validate();
        try {
            String idString = validate.getField(request, "id", true);
            int id = validate.fieldInt(idString, "Error get field id");
            GroupDBContext groupDB = new GroupDBContext();
            ArrayList<Group> groups = groupDB.list();
            CategoryDBContext categoryDB = new CategoryDBContext();
            ArrayList<Category> listCategory = categoryDB.list();
            StateDBContext stateDB = new StateDBContext();
            ArrayList<State> states = stateDB.list();
            ProductDBContext productDB = new ProductDBContext();
            Product product = productDB.get(id);
            request.setAttribute("product", product);
            request.setAttribute("listCategory", listCategory);
            request.setAttribute("states", states);
            request.setAttribute("groups", groups);
            request.getRequestDispatcher("/views/admin/product/editProduct.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(EditGroupController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void processPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idString = validate.getField(request, "id", true);
            String name = validate.getField(request, "name", true);
            String brand = validate.getField(request, "brand", true);
            String priceString = validate.getField(request, "price", true);
            String quantityString = validate.getField(request, "quantity", true);
            String discountString = validate.getField(request, "discount", true);
            String state = validate.getField(request, "state", true);
            String isSaleString = validate.getField(request, "isSale", false);
            String isDeleteString = validate.getField(request, "isDelete", false);
            String description = validate.getField(request, "description", true);
            String category = validate.getField(request, "category", true);
            String content = validate.getField(request, "content", true);

            UserDBContext db = new UserDBContext();
            try {
                Timestamp updated_at = new Timestamp(System.currentTimeMillis());
                int id = validate.fieldInt(idString, "Error get field id");
                Boolean isSale = validate.fieldBoolean(isSaleString, "Error get field is sale");
                Boolean isDelete = validate.fieldBoolean(isDeleteString, "Error get field is delete");
                int stateId = validate.fieldInt(state, "Error get field state");
                int categoryId = validate.fieldInt(category, "Error get field state");
                double price = validate.fieldDouble(priceString, "Error get field price");
                int quantity = validate.fieldInt(quantityString, "Error get field quantity");
                int discount = validate.fieldInt(discountString, "Error get field discount");
                ProductDBContext productDB = new ProductDBContext();
                Product product = productDB.get(id);
                product.setName(name);
                product.setBrand(brand);
                product.setPrice(price);
                product.setQuantity(quantity);
                product.setDiscount(discount);
                product.setIsSale(isSale);
                product.setIsDelete(isDelete);
                product.setDescription(description);
                product.setCategoryId(categoryId);
                product.setStateId(stateId);
                product.setContent(content);
                product.setUpdated_at(updated_at);

                CategoryDBContext categoryDB = new CategoryDBContext();
                Category categoryObject = categoryDB.get(categoryId);
                product.setCategory(categoryObject);

                StateDBContext stateDB = new StateDBContext();
                State stateObject = stateDB.get(stateId);
                product.setState(stateObject);

                productDB.update(product);

                FileManage fileManage = new FileManage();
                List<String> listFiles = fileManage.uploadFiles("/assets/images/products", request);
                if (listFiles.size() > 0) {
                    for (String file : listFiles) {
                        ImageDBContext imageDB = new ImageDBContext();
                        Image image = new Image();
                        image.setImage("/assets/images/products/" + file.toString());
                        image.setProductId(product.getId());
                        imageDB.insert(image);
                    }
                }
                String json = new Gson().toJson(product);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(json);
            } catch (Exception e) {
                String json = new Gson().toJson(new Error(e.getMessage()));
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(json);
            }
        } catch (Exception e) {
            String json = new Gson().toJson(new Error(e.getMessage()));
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
