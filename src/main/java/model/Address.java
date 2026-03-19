package model;

import jakarta.persistence.*;

@Entity
@Table(name = "address")
public class Address {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String street;
    private String city;
    @Column(name = "postal_code")
    private String postalCode;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    // Constructors (optional, but good practice)
    public Address() {
    }

    public Address(String street, String city, String postalCode) {
        this.street = street;
        this.city = city;
        this.postalCode = postalCode;
    }

    // Getters and Setters for attributes
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    // Operations as per diagram
    public void updateAddress(String street, String city, String postalCode) {
        this.street = street;
        this.city = city;
        this.postalCode = postalCode;
        // In a real application, this would also trigger a DAO update.
    }

    public String getFullAddress() {
        return street + ", " + city + " " + postalCode;
    }

    public boolean validate() {
        return street != null && !street.isEmpty()
                && city != null && !city.isEmpty()
                && postalCode != null && !postalCode.isEmpty();
    }

    @Override
    public String toString() {
        // Phương thức này sẽ chỉ ghép các phần địa chỉ có giá trị (không null).
        // Nó sẽ tự động bỏ qua các phần bị rỗng và thêm dấu phẩy đúng chỗ.

        // 1. Tạo một danh sách để chứa các phần của địa chỉ
        java.util.List<String> parts = new java.util.ArrayList<>();

        // 2. Thêm từng phần vào danh sách NẾU nó không rỗng
        if (getStreet() != null && !getStreet().trim().isEmpty()) {
            parts.add(getStreet());
        }

        if (getCity() != null && !getCity().trim().isEmpty()) {
            parts.add(getCity());
        }

        // 3. Dùng String.join để nối các phần lại với nhau bằng dấu phẩy và dấu cách
        return String.join(", ", parts);
    }
}
