package model;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "orders") // Tên bảng nên là chữ thường
public class Order implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    // --- PHẦN SỬA LỖI QUAN TRỌNG ---
    @ManyToOne(fetch = FetchType.LAZY) // Đánh dấu mối quan hệ nhiều-một
    @JoinColumn(name = "user_id")      // Chỉ định tên cột khóa ngoại trong bảng "orders"
    private User user;
    // ---------------------------------

    @Temporal(TemporalType.TIMESTAMP) // Giúp map kiểu Date sang TIMESTAMP trong DB
    private Date dateOrder;

    private int status;
    private String shippingAddress;
    private String paymentMethod;

    // Một Order có thể có nhiều OrderItem
    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL)
    private List<OrderItem> orderItems;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getDateOrder() {
        return dateOrder;
    }

    public void setDateOrder(Date dateOrder) {
        this.dateOrder = dateOrder;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    @Transient
    public double getTotalPrice() {
        double total = 0.0;
        if (orderItems != null) {
            for (OrderItem item : orderItems) {
                total += item.getSubtotal();
            }
        }
        return total;
    }

    // ====== FORMAT HIỂN THỊ TỔNG TIỀN (nếu cần trên JSP) ======
    @Transient
    public String getFormattedTotal() {
        return String.format("%,.0f", getTotalPrice());
    }

    //moi them
    @Column(name = "subtotal")
    private Double subtotal; // Tổng tiền gốc của đơn hàng

    @Column(name = "coupon_code", nullable = true)
    private String couponCode; // Mã coupon đã áp dụng

    @Column(name = "discount_amount")
    private Double discountAmount; // Số tiền đã được giảm

    @Column(name = "final_amount")
    private Double finalAmount; // Tổng tiền cuối cùng khách phải trả

    // === GETTERS AND SETTERS CHO CÁC TRƯỜNG MỚI ===
    public Double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(Double subtotal) {
        this.subtotal = subtotal;
    }

    public String getCouponCode() {
        return couponCode;
    }

    public void setCouponCode(String couponCode) {
        this.couponCode = couponCode;
    }

    public Double getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(Double discountAmount) {
        this.discountAmount = discountAmount;
    }

    public Double getFinalAmount() {
        return finalAmount;
    }

    public void setFinalAmount(Double finalAmount) {
        this.finalAmount = finalAmount;
    }

}
