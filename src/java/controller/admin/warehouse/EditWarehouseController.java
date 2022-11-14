/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.admin.warehouse;

import dal.auth.UserDBContext;
import dal.product.ProductDBContext;
import dal.warehouse.WarehouseDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.auth.User;
import model.common.Pagination;
import model.product.Product;
import model.warehouse.Warehouse;

/**
 *
 * @author DUCHIEUPC.COM
 */
public class EditWarehouseController extends HttpServlet {

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String importId = request.getParameter("id");
        ProductDBContext productDB = new ProductDBContext();
        WarehouseDBContext whDB = new WarehouseDBContext();
        Warehouse w = whDB.get(Integer.valueOf(importId));
        ArrayList<Product> products = productDB.getProducts("", -1, -1, 1, 99999);

        UserDBContext userDB = new UserDBContext();
        ArrayList<User> users = new ArrayList<User>();
        users = userDB.getUsersAdmin(1, 99999);
        request.setAttribute("w", w);
        request.setAttribute("users", users);
        request.setAttribute("products", products);
        request.getRequestDispatcher("/views/admin/warehouse/editWarehouse.jsp").forward(request, response);

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        WarehouseDBContext whDB = new WarehouseDBContext();
        String quantity = request.getParameter("quantity");
        String price = request.getParameter("price");
        String supplier = request.getParameter("supplier");
        String productID = request.getParameter("productID");
        String[] splitid = productID.split("-");
        String pid = splitid[0].trim();
        String uid = request.getParameter("uid");
        String importID = request.getParameter("importID");
        String state = request.getParameter("state");
        whDB.editWarehouse(quantity, price, state, supplier, pid, uid, importID);
        response.sendRedirect("/admin/warehouse");

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
