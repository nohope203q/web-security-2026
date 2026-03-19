/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package model;

import jakarta.persistence.*;

@Entity
@DiscriminatorValue("ADMIN")

public class Admin extends Account {

    @Override
    public boolean isAdmin() {
        return true;
    }

    public void createUser(User user) {
        System.out.println("Admin creating user: " + user.getEmail());
    }

    public void deleteUser(long userId) {
        System.out.println("Admin deleting user with ID: " + userId);
    }

    public void manageProduct(Object product) {
        System.out.println("Admin managing product: " + product);
    }

    public Object viewReports() {
        System.out.println("Admin viewing reports.");
        return null;
    }
}
