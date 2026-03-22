# 🛒 E-Commerce Web Application (Jakarta EE)

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-00000f?style=for-the-badge&logo=mysql&logoColor=white)
![Hibernate](https://img.shields.io/badge/Hibernate-59666C?style=for-the-badge&logo=Hibernate&logoColor=white)

Một ứng dụng thương mại điện tử hoàn chỉnh được xây dựng trên nền tảng **Java Servlet** và **Jakarta EE**, tích hợp **Hibernate ORM** để quản lý dữ liệu bền vững. Hệ thống cung cấp đầy đủ quy trình từ mua sắm phía khách hàng đến quản trị chuyên sâu cho Admin.

---

## 🧰 Nền tảng công nghệ

| Thành phần | Công nghệ sử dụng |
| :--- | :--- |
| **Ngôn ngữ** | Java (JDK 17+) |
| **Backend** | Java Servlet, JSP, JSTL (Jakarta EE 10) |
| **ORM** | Hibernate ORM 6.4.4 |
| **Database** | MySQL 8.x |
| **Build Tool** | Apache Maven |
| **Server** | Apache Tomcat 10 (Embedded) |

---

## 🚀 Hướng dẫn triển khai

### Phương án A: Chạy nhanh (Dành cho User)
Không cần cài đặt môi trường lập trình, chỉ cần có JRE/JDK 17.

1. Tải file `project-web-1.0-SNAPSHOT.jar` từ mục **Releases**.
2. Thiết lập Database (Xem Bước 2 ở dưới).
3. Chạy lệnh:
   ```bash
   java -jar project-web-1.0-SNAPSHOT.jar
````

### Phương án B: Môi trường phát triển (Dành cho Dev)

**Yêu cầu:** JDK 17+, MySQL 8.x, Maven 3.8+.

#### Bước 1: Clone dự án

```bash
git clone [https://github.com/Khangdz296/E-Commerce.git](https://github.com/Khangdz296/E-Commerce.git)
cd E-Commerce
```

#### Bước 2: Thiết lập Cơ sở dữ liệu

1.  Tạo schema trong MySQL:
    ```sql
    CREATE DATABASE ecommerce;
    ```
2.  Import dữ liệu: Sử dụng MySQL Workbench, chọn **Data Import**, trỏ đến file `Dump20260315.sql` trong thư mục gốc.
3.  Cấu hình kết nối: Mở file `src/main/resources/META-INF/persistence.xml` và cập nhật:
    ```xml
    <property name="jakarta.persistence.jdbc.user" value="TÊN_DÙNG_CỦA_MÀY"/>
    <property name="jakarta.persistence.jdbc.password" value="MẬT_KHẨU_CỦA_MÀY"/>
    ```

#### Bước 3: Build và Khởi chạy

Dự án sử dụng **Embedded Tomcat**, mầy không cần cài thêm server ngoài.

```bash
mvn clean package
java -jar target/project-web-1.0-SNAPSHOT.jar
```

#### Bước 4: Truy cập

Mở trình duyệt và truy cập: [http://localhost:8080/home](https://www.google.com/search?q=http://localhost:8080/home)

-----

## ✨ Tính năng trọng tâm

### 👤 Cho Khách hàng

  * **Mua sắm:** Duyệt sản phẩm theo danh mục, thương hiệu, tìm kiếm thông minh.
  * **Giỏ hàng:** Thêm/sửa/xóa, áp dụng mã giảm giá trực tiếp.
  * **Tài khoản:** Quản lý profile, địa chỉ giao hàng và theo dõi lịch sử đơn hàng.

### 🛠️ Cho Quản trị viên (Admin)

  * **Dashboard:** Biểu đồ doanh thu và thống kê thời gian thực.
  * **Catalog:** Quản lý toàn bộ vòng đời sản phẩm và danh mục.
  * **Vận hành:** Xử lý đơn hàng, quản lý tài khoản người dùng và kiểm duyệt đánh giá.
  * **Marketing:** Cấu hình mã khuyến mãi và gửi thông báo hệ thống.

-----

## 🖥️ Giao diện ứng dụng

### Trang chủ (Khách hàng)

### Quản lý sản phẩm (Admin)

### Thống kê & Dashboard

-----

## 👥 Nhóm phát triển


<!-- end list -->

```

---

Tao đã thêm mấy cái **Badge** (huy hiệu) ở đầu cho nó chuyên nghiệp và định dạng lại bảng biểu cho dễ nhìn. Mầy có muốn tao viết thêm phần mô tả chi tiết về cấu trúc thư mục (Folder Structure) để người khác nhìn vào dễ hiểu code hơn không?
```
