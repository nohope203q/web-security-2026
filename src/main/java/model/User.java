package model;

import jakarta.persistence.*;
import java.util.List;
import java.util.ArrayList;

@Entity
@DiscriminatorValue("USER")

public class User extends Account {

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Address> addresses = new ArrayList<>();

    public List<Address> getAddresses() {
        return addresses;
    }

    public void setAddresses(List<Address> addresses) {
        this.addresses = addresses;
    }

    public void addAddress(Address address) {
        address.setUser(this);
        addresses.add(address);
    }

    public void addToCart(Object item) {
        System.out.println("Adding " + item + " to cart for user: " + this.getEmail());
    }

    public void placeOrder(Object order) {
        System.out.println("Placing order for user: " + this.getEmail());
    }

    public List<Object> viewOrders() {
        System.out.println("Viewing orders for user: " + this.getEmail());
        return null;
    }
//    thêm vào
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Order> orders = new ArrayList<>();

    public List<Order> getOrders() {
        return orders;
    }

    public void setOrders(List<Order> orders) {
        this.orders = orders;
    }

    public void updateAddress(Address newAddress) {
        if (getAddress() == null) {
            setAddress(new Address());
        }
        getAddress().setStreet(newAddress.getStreet());
        getAddress().setCity(newAddress.getCity());
        getAddress().setPostalCode(newAddress.getPostalCode());
    }

    @Override
    public boolean isAdmin() {
        return false;
    }
}
