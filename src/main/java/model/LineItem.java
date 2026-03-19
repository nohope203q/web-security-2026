package model;

import jakarta.persistence.*;

@Entity
@Table(name = "line_item")
public class LineItem {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int quantity;
    private double price;

    // Mỗi LineItem thuộc 1 Product
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product;

    // Mỗi LineItem thuộc 1 Cart
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cart_id")
    private Cart cart;

    // Mỗi LineItem thuộc 1 User (bổ sung)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    public LineItem() {
    }

    public LineItem(Product product, int quantity, Cart cart, User user) {
        this.product = product;
        this.quantity = quantity;
        this.price = product.getPrice();
        this.cart = cart;
        this.user = user;
    }

    public double getTotal() {
        // Make sure product and price are not null
        if (product != null) {
            this.price = product.getPrice(); // Always get the latest price
        }
        return this.price * this.quantity;
    }

    // Getter/Setter
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public LineItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
        this.price = product.getPrice(); // Lấy giá từ sản phẩm
    }
}
