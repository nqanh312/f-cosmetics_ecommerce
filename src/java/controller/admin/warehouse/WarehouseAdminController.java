/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.admin.warehouse;

import com.google.gson.Gson;
import controller.admin.auth.BaseAuthAdminController;
import controller.admin.group.EditGroupController;
import controller.admin.order.OrderAdminController;
import dal.auth.UserDBContext;
import dal.order.OrderDBContext;
import dal.order.OrderStateDBContext;
import dal.product.GroupDBContext;
import dal.warehouse.WarehouseDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.auth.User;
import model.common.Pagination;
import model.order.Order;
import model.order.OrderState;
import model.product.Group;
import model.warehouse.Warehouse;
import utils.Validate;

/**
 *
 * @author genni
 */

public class WarehouseAdminController extends BaseAuthAdminController {

    @Override
    protected boolean isPermissionGet(HttpServletRequest request) {
        UserDBContext userDB = new UserDBContext();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("admin");
        int numRead = userDB.getNumberOfPermission(user.getId(), "ORDER", "READ");
        return numRead >= 1;
    }

    @Override
    protected boolean isPermissionPost(HttpServletRequest request) {
        UserDBContext userDB = new UserDBContext();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("admin");
        int numRead = userDB.getNumberOfPermission(user.getId(), "ORDER", "READ");
        return numRead >= 1;
    }
    
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */

    @Override
    protected void processGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Validate validate = new Validate();
        try {
            int pageSize = 12;
            String page = validate.getField(request, "page", false);
            if (page == null || page.trim().length() == 0) {
                page = "1";
            }
            int pageIndex = 0;
            try {
                pageIndex = validate.fieldInt(page, "Something error!");
                if (pageIndex <= 0) {
                    pageIndex = 1;
                }
            } catch (Exception e) {
                pageIndex = 1;
            }
            String search = request.getParameter("search")==null?"": request.getParameter("search");
             HttpSession session = request.getSession();
            ArrayList<Warehouse> warehouse = new ArrayList<>();
            WarehouseDBContext whDB = new WarehouseDBContext();
            warehouse = whDB.getOrders(pageIndex, pageSize,search.toUpperCase());
            Pagination pagination = new Pagination(pageIndex, pageSize, whDB.getOrders(1, 999999,"").size());
            request.setAttribute("orders", warehouse);         
            request.setAttribute("pagination", pagination);
            request.getRequestDispatcher("/views/admin/warehouse/warehouse.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(OrderAdminController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void processPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
                throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
