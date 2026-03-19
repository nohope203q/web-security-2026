package model;

import jakarta.persistence.*;
import java.io.File;
import java.util.Calendar;
import java.util.Date;

@Entity
@Table(name = "invoice")
public class Invoice {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Temporal(TemporalType.TIMESTAMP)
    private Date issueDate;

    @Temporal(TemporalType.TIMESTAMP)
    private Date dueDate;

    private double amount;
    private double tax;

    @OneToOne
    @JoinColumn(name = "order_id", referencedColumnName = "id")
    private Order order;

    public Invoice() {
    }

    public static Invoice generateFromOrder(Order order) {
        Invoice invoice = new Invoice();
        invoice.setOrder(order);

        Date now = new Date();
        invoice.setIssueDate(now);

        Calendar cal = Calendar.getInstance();
        cal.setTime(now);
        cal.add(Calendar.DATE, 30);
        invoice.setDueDate(cal.getTime());

        double finalAmount = order.getFinalAmount();

        double taxRate = 0.10;
        double amountBeforeTax = finalAmount / (1 + taxRate);
        double taxAmount = finalAmount - amountBeforeTax;

        invoice.setAmount(amountBeforeTax);
        invoice.setTax(taxAmount);

        return invoice;
    }

    public double calculateTotal() {
        return this.amount + this.tax;
    }

    public String getInvoiceDetails() {
        return "Invoice #" + id + " for Order #" + order.getId() + " - Total: " + calculateTotal();
    }

    public File exportPDF() {
        System.out.println("Logic xuất PDF sẽ được cài đặt ở đây.");

        return null;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public double getTax() {
        return tax;
    }

    public void setTax(double tax) {
        this.tax = tax;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }
}
