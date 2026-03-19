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

    public void updateAddress(String street, String city, String postalCode) {
        this.street = street;
        this.city = city;
        this.postalCode = postalCode;

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
        java.util.List<String> parts = new java.util.ArrayList<>();

        if (getStreet() != null && !getStreet().trim().isEmpty()) {
            parts.add(getStreet());
        }

        if (getCity() != null && !getCity().trim().isEmpty()) {
            parts.add(getCity());
        }

        return String.join(", ", parts);
    }
}
