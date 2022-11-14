/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.warehouse;

import java.util.ArrayList;
import model.BaseModel;
import model.auth.User;
import model.order.OrderState;
import model.product.Product;

/**
 *
 * @author genni
 */
public class Warehouse extends BaseModel{
  
    private int userId;
    private byte state;
    private User user;
    private int productId;
    private int productQuantity;
    private double price;
    private String supplier;
    private Product product;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getProductQuantity() {
        return productQuantity;
    }

    public void setProductQuantity(int productQuantity) {
        this.productQuantity = productQuantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getSupplier() {
        return supplier;
    }

    public void setSupplier(String supplier) {
        this.supplier = supplier;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public byte getState() {
        return state;
    }

    public void setState(byte state) {
        this.state = state;
    }



   
    
}
