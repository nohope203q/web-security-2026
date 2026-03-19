<%-- File: header.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>TechStore</title>

        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/7.3.0/mdb.min.css" rel="stylesheet" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

        <style>
            body {
                background-color: #f0f2f5; /* Màu nền sáng cho nội dung chính */
            }
            .user-avatar {
                width: 35px;
                height: 35px;
                border-radius: 50%;
                object-fit: cover;
                border: 2px solid #fff;
                margin-left: 20px;
            }
            .logout-link {
                /* Đẩy link ra xa avatar 10 pixel */
                margin-left: 20px;
            }
            .site-header {
                background-color: #212529; /* Màu nền Dark Mode cho toàn bộ header */
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            }

            /* 3. Tinh chỉnh Navbar */
            .navbar .btn-primary {
                background-color: #0d6efd; /* Giữ màu xanh dương nổi bật cho nút chính */
            }
            .navbar .btn-link {
                color: #f8f9fa; /* Màu trắng cho nút "Đăng nhập" */
                text-decoration: none;
                font-weight: 500;
            }
            .navbar .btn-link:hover {
                color: #0d6efd;
            }

        </style>
    </head>
    <body>

        <header class="site-header fixed-top">
            <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #212529;">
                <div class="container">
                    <a class="navbar-brand" href="home">
                        <i class="fas fa-desktop me-2"></i><strong>TechStore</strong>
                    </a>

                    <div class="w-50 mx-auto d-none d-lg-block" style="position: relative;">
                        <form action="${pageContext.request.contextPath}/client/search" method="get" class="input-group">
                            <input type="text" name="txt" value="${searchKeyword}" class="form-control" placeholder="Search products...">
                            <button class="btn btn-outline-light" type="submit" data-mdb-ripple-init>
                                <i class="fas fa-search"></i>
                            </button>

                        </form>

                    </div>
                    <a href="${pageContext.request.contextPath}/client/search" 
                       class="btn btn-outline-primary btn-sm" 
                       style="margin-right: 100px;" role="button">
                        <i class="fas fa-filter me-1"></i> Lọc
                    </a>




                    <div class="d-flex align-items-center">
                        <a class="nav-link me-3" href="${pageContext.request.contextPath}/cart">
                            <i class="fas fa-shopping-cart"></i>
                            <span class="badge rounded-pill badge-notification bg-danger">
                                ${fn:length(sessionScope.cart)}
                            </span>
                        </a>

                        <c:choose>
                            <c:when test="${sessionScope.account != null}">
                                <a href="${pageContext.request.contextPath}/client/order-tracking" class="logout-link">Đơn hàng</a>
                                <a href="${pageContext.request.contextPath}/client/profile">
                                    <img src="https://img.pikbest.com/illustration/20250214/anime-kitten--22meow-22-font-white--26-black-fur-pink-tiny-paws-vibrant-yellow-bg_11525404.jpg!w700wp"   class="user-avatar" alt="User Avatar" loading="lazy"/>
                                </a>
                                <a href="${pageContext.request.contextPath}/client/logout" class="logout-link">Logout</a>

                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/client/login" class="btn btn-link px-3 me-2">Đăng nhập</a>
                                <a href="${pageContext.request.contextPath}/client/register" class="btn btn-primary" data-mdb-ripple-init>Đăng ký</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </nav> 
        </header>

        <div id="carouselExampleCaptions" class="carousel slide carousel-fade" data-mdb-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="client/images/banner-1.webp" class="d-block w-100" alt="Gaming PCs"/>
                    <div class="mask" style="background-color: rgba(0, 0, 0, 0.4)"></div>
                    <div class="carousel-caption d-none d-sm-block mb-5">
                        <h1 class="mb-4"><strong>Build Your Dream Gaming PC</strong></h1>
                        <p><strong>High-performance components for gamers and creators</strong></p>

                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-mdb-target="#carouselExampleCaptions" data-mdb-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-mdb-target="#carouselExampleCaptions" data-mdb-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>



