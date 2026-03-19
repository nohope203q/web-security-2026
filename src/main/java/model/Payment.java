package model;

import java.util.Date;
import jakarta.persistence.*;

@Entity
@Table(name = "payment")
public class Payment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String paymentMethod;

    @Temporal(TemporalType.TIMESTAMP)
    private Date dateOrder;
    private int status;

    @OneToOne
    @JoinColumn(name = "order_id", referencedColumnName = "id")
    private Order order;

    public int getid() {
        return id;
    }

    public void setid() {
        this.id = id;
    }

    public String getpaymentMethod() {
        return paymentMethod;
    }

    public void setpaymentMethod() {
        this.paymentMethod = paymentMethod;
    }

    public int getstatus() {
        return status;
    }

    public void setstatus() {
        this.status = status;
    }

}
