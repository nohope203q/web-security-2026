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
    private Date issueDate; // Ngày phát hành hoá đơn

    @Temporal(TemporalType.TIMESTAMP)
    private Date dueDate; // Ngày hết hạn thanh toán

    private double amount; // Số tiền trước thuế (chính là finalAmount của Order)
    private double tax; // Tiền thuế (ví dụ: 10% VAT)

    @OneToOne
    @JoinColumn(name = "order_id", referencedColumnName = "id")
    private Order order;

    public Invoice() {
    }

    // --- CÁC PHƯƠNG THỨC ĐƯỢC HOÀN THIỆN ---
    /**
     * Phương thức tĩnh để tạo một đối tượng Invoice từ một Order.
     *
     * @param order Đối tượng Order đã được lưu.
     * @return một đối tượng Invoice mới.
     */
    public static Invoice generateFromOrder(Order order) {
        Invoice invoice = new Invoice();
        invoice.setOrder(order);

        // Ngày phát hành là ngày hiện tại
        Date now = new Date();
        invoice.setIssueDate(now);

        // Giả sử ngày hết hạn thanh toán là 30 ngày sau
        Calendar cal = Calendar.getInstance();
        cal.setTime(now);
        cal.add(Calendar.DATE, 30);
        invoice.setDueDate(cal.getTime());

        // Số tiền là tổng tiền cuối cùng của đơn hàng
        double finalAmount = order.getFinalAmount();

        // Giả sử thuế VAT là 10% (bạn có thể thay đổi logic này)
        // amount là giá trị trước thuế
        // tax là tiền thuế
        // finalAmount = amount + tax
        double taxRate = 0.10;
        double amountBeforeTax = finalAmount / (1 + taxRate);
        double taxAmount = finalAmount - amountBeforeTax;

        invoice.setAmount(amountBeforeTax);
        invoice.setTax(taxAmount);

        return invoice;
    }

    /**
     * Tính tổng số tiền trên hoá đơn (tiền hàng + thuế).
     *
     * @return Tổng số tiền.
     */
    public double calculateTotal() {
        return this.amount + this.tax;
    }

    /**
     * Lấy chi tiết hoá đơn dưới dạng chuỗi.
     *
     * @return Chuỗi thông tin.
     */
    public String getInvoiceDetails() {
        return "Invoice #" + id + " for Order #" + order.getId() + " - Total: " + calculateTotal();
    }

    /**
     * (Nâng cao) Xuất hoá đơn ra file PDF. Cần dùng thư viện bên ngoài như
     * iText hoặc OpenPDF để thực hiện.
     *
     * @return File PDF.
     */
    public File exportPDF() {
        System.out.println("Logic xuất PDF sẽ được cài đặt ở đây.");
        // Đây là một chức năng phức tạp, tạm thời trả về null.
        return null;
    }

    // --- Getters and Setters (Giữ nguyên) ---
    // ...
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
