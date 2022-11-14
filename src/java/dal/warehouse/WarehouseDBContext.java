/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal.warehouse;

import dal.DBContext;
import dal.order.CustomerDBContext;
import dal.order.OrderDBContext;
import dal.order.OrderDetailDBContext;
import dal.product.CategoryDBContext;
import dal.product.ImageDBContext;
import dal.product.ProductDBContext;
import dal.product.StateDBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.auth.User;
import model.order.Customer;
import model.order.Order;
import model.order.OrderDetail;
import model.order.OrderState;
import model.product.Category;
import model.product.Group;
import model.product.Image;
import model.product.Product;
import model.product.State;
import model.warehouse.Warehouse;

/**
 *
 * @author genni
 */
public class WarehouseDBContext extends DBContext<Warehouse> {

    public ArrayList<Warehouse> getOrders(int pageIndex, int pageSize,String search) {
        ArrayList<Warehouse> warehouse = new ArrayList<>();
        // CustomerDBContext customerDB = new CustomerDBContext();
        String sql = "SELECT * FROM (SELECT [import].[importID]\n"
                + "						,[import].[userID]                \n"
                + "                     ,[import].[state]\n"
                + "                      ,[import].[created_at]\n"
                + "					  ,[import].[updated_at]\n"
                + "                     ,[import].[quantity]\n"
                + "                      ,[import].[supplier]\n"
                + "                      ,[import].[productId]\n"
                + "                      ,[product].[name]\n"
                + "                     ,[user].[first_name]                                   \n"
                + "                     ,[user].[last_name]                                   	\n"
                + "                      ,ROW_NUMBER() OVER \n"
                + "					  (ORDER BY [import].[importID] DESC) as row_index FROM [import]\n"
                + "                  INNER JOIN [product] ON [product].[id] = [import].[productId]\n"
                + "				  \n"
                + "                 INNER JOIN [user] ON [user].[id] = [import].[userID]) [import]\n"
                + "              WHERE row_index >= (? - 1) * ? + 1 AND row_index <= ? * ? and Upper([import].[name]) like ? ";
        PreparedStatement statement = null;
        try {
            statement = connection.prepareStatement(sql);
            statement.setInt(1, pageIndex);
            statement.setInt(2, pageSize);
            statement.setInt(3, pageIndex);
            statement.setInt(4, pageSize);
            statement.setString(5,"%" + search + "%");
            ResultSet result = statement.executeQuery();
            while (result.next()) {
                Warehouse warehouses = new Warehouse();
                warehouses.setId(result.getInt("importID"));
                warehouses.setUserId(result.getInt("userId"));
                warehouses.setState((byte) result.getInt("state"));
                warehouses.setCreated_at(result.getTimestamp("created_at"));
                warehouses.setUpdated_at(result.getTimestamp("updated_at"));
                warehouses.setProductQuantity(result.getInt("quantity"));
                warehouses.setSupplier(result.getString("supplier"));
                warehouses.setProductId(result.getInt("productId"));

                User user = new User();
                user.setId(result.getInt("userId"));
                user.setFirst_name(result.getString("first_name"));
                user.setLast_name(result.getString("last_name"));
                warehouses.setUser(user);

                Product product = new Product();
                product.setId(result.getInt("productId"));
                product.setName(result.getString("name"));
                product.setQuantity(result.getInt("quantity"));
                warehouses.setProduct(product);

                warehouses.setUser(user);
                warehouse.add(warehouses);
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return warehouse;
    }

    @Override
    public ArrayList<Warehouse> list() {

        return null;
    }

    @Override
    public Warehouse get(int id) {
        String sql = "  select * from [import] where  [importID] = " + id;
        PreparedStatement statement = null;
        try {
            statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Warehouse w = new Warehouse();
                w.setId(rs.getInt("importID"));
                w.setPrice(rs.getDouble("price"));
                w.setUserId(rs.getInt("userID"));
                w.setProductId(rs.getInt("productID"));
                w.setProductQuantity(rs.getInt("quantity"));
                w.setSupplier(rs.getString("supplier"));
                w.setState(rs.getByte("state"));
                return w;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public int getSize() {
        String sql = "SELECT COUNT([warehouse].[id]) as 'size' FROM [warehouse]";
        PreparedStatement statement = null;
        try {
            statement = connection.prepareStatement(sql);
            ResultSet result = statement.executeQuery();
            while (result.next()) {
                int size = result.getInt("size");
                return size;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public void addWarehouse(String quantity, String price, String supplier, String productID, int uid) {
        String sql = "  insert into [import] ([quantity],[price],[created_at],[state] ,[supplier],[productID] ,[userID])\n"
                + "  values (?,?,getdate(), 1, ?, ?,?)";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, quantity);
            statement.setString(2, price);
            statement.setString(3, supplier);
            statement.setString(4, productID);
            statement.setInt(5, uid);
            statement.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }


    public  void  editWarehouse(String quantity, String price, String state, String supplier, String productID, String uid, String importID) {
        String sql = "  update [import] set [quantity]=?,[price]=?,[updated_at]=getdate(),[state]=? ,[supplier]=?,[productID] =?,[userID] = ?\n"
                + "  where [importID] = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, quantity);
            statement.setString(2, price);
            statement.setString(3, state);
            statement.setString(4, supplier);
            statement.setString(5, productID);
            statement.setString(6, uid);
            statement.setString(7, importID);
            statement.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    @Override
    public Warehouse insert(Warehouse model) {
        String sql = "INSERT INTO [dbo].[import]\n"
                + "           ([quantity]\n"
                + "           ,[price]\n"
                + "           ,[created_at]\n"
                + "           ,[updated_at]\n"
                + "           ,[state]\n"
                + "           ,[supplier]\n"
                + "           ,[productID]\n"
                + "           ,[userID])\n"
                + "           VALUES\n"
                + "           (?,?,?,?,?,?,?,?)";
        PreparedStatement statement = null;
        try {
            statement = connection.prepareStatement(sql);
            statement.setInt(1, model.getProductQuantity());
            statement.setDouble(2, model.getPrice());
            statement.setTimestamp(3, model.getCreated_at());
            statement.setTimestamp(4, model.getUpdated_at());
            statement.setInt(5, model.getState());
            statement.setString(6, model.getSupplier());
            statement.setInt(7, model.getProductId());
            statement.setInt(8, model.getUserId());
            statement.executeUpdate();
            return null;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        return null;
    }

    @Override
    public void update(Warehouse model) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void delete(int id) {
        WarehouseDBContext w = new  WarehouseDBContext();
        String sql = "DELETE FROM [import]\n"
                    + "WHERE [importID] = ?";
        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            statement.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
