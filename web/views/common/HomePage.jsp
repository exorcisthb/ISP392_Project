<%-- 
    Document   : index
    Created on : May 28, 2025, 7:54:00 PM
    Author     : Grok
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nha Khoa PDC</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #F5F5F5; /* Nền xám nhạt */
        }
        /* Header */
        header {
            background: #8B4513; /* Nâu đậm */
            position: sticky;
            top: 0;
            z-index: 50;
            padding: 10px 0;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            color: black;
        }
        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .logo {
            display: flex;
            align-items: center;
        }
        .logo h1 {
            color: #FFF5E1; /* Trắng kem */
            font-size: 24px;
            margin: 0;
        }
        .logo span {
            color: #FFF5E1; /* Trắng kem */
            margin-left: 10px;
        }
        nav a {
            color: #FFF5E1; /* Trắng kem */
            text-decoration: none;
            margin: 0 15px;
            font-size: 16px;
        }
        nav a:hover {
            color: #D2B48C; /* Nâu nhạt */
        }
        .nav-buttons .btn {
            padding: 8px 20px;
            margin-left: 10px;
            border: 1px solid #FFF5E1; /* Viền trắng kem */
            border-radius: 20px;
            background: transparent;
            color: #FFF5E1; /* Trắng kem */
            cursor: pointer;
            font-size: 16px;
        }
        .nav-buttons .btn:hover {
            background: #D2B48C; /* Nâu nhạt */
            color: #8B4513; /* Nâu đậm */
        }
        /* Banner */
        .banner {
            background-image: url('https://via.placeholder.com/1920x400?text=Banner+Image'); /* Placeholder cho hình banner */
            background-size: cover;
            background-position: center;
            padding: 60px 0;
            text-align: center;
            color: #FFF5E1; /* Trắng kem */
            background-color: #D2B48C; /* Nâu nhạt làm nền nếu hình không tải */
        }
        .banner p {
            font-size: 18px;
            margin: 0 0 20px;
        }
        .banner .slogan {
            font-size: 24px;
            font-weight: bold;
        }
        .banner a {
            display: inline-block;
            background: #8B4513; /* Nâu đậm */
            color: #FFF5E1; /* Trắng kem */
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            margin-top: 20px;
        }
        .banner a:hover {
            background: #A0522D; /* Nâu đậm hơn khi hover */
        }
        /* Dịch vụ */
        .services {
            padding: 60px 0;
            text-align: center;
            background: #FFF5E1; /* Trắng kem */
        }
        .services h2 {
            font-size: 32px;
            color: #8B4513; /* Nâu đậm */
            margin-bottom: 20px;
        }
        .services p {
            font-size: 18px;
            color: #666666; /* Xám nhạt */
            margin-bottom: 40px;
        }
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }
        .service-card {
            background: #FFFFFF; /* Trắng */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
        }
        .service-card:hover {
            transform: translateY(-5px); /* Hiệu ứng nâng lên khi hover */
        }
        .service-card svg {
            width: 48px;
            height: 48px;
            margin-bottom: 20px;
            color: #8B4513; /* Nâu đậm */
        }
        .service-card h3 {
            font-size: 20px;
            color: #8B4513; /* Nâu đậm */
            margin-bottom: 10px;
        }
        .service-card p {
            font-size: 16px;
            color: #666666; /* Xám nhạt */
        }
        /* Footer */
        footer {
            background: #8B4513; /* Nâu đậm */
            color: #FFF5E1; /* Trắng kem */
            text-align: center;
            padding: 20px 0;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <div class="container header-content">
            <!-- Logo -->
            <div class="logo">
                <h1>PDC</h1>
                <span>Nha Khoa PDC</span>
            </div>
            <!-- Navigation -->
            <nav>
                <a href="#">Home</a>
                <a href="#">Blog</a>
                <a href="#">Service</a>
                <a href="#">About</a>
            </nav>
            <!-- Sign In/Sign Up Buttons -->
            <div class="nav-buttons">
                <button class="btn" onclick="window.location.href='${pageContext.request.contextPath}/views/common/login.jsp?form=login'">Sign In</button>
                <button class="btn" onclick="window.location.href='${pageContext.request.contextPath}/views/common/login.jsp?form=register'">Sign Up</button>
            </div>
        </div>
    </header>

    <!-- Banner -->
    <section class="banner">
        <div class="container">
            <p>PDC là công ty bệnh nha khoa được nhiều người tin tưởng trong lĩnh vực chăm sóc sức khỏe răng miệng.</p>
            <p class="slogan">"Giải pháp tối ưu, cân thiện tối thiểu" – đó chính là slogan và mục tiêu mà Nha Khoa PDC đang, và sẽ thực hiện trong suốt thời gian hoạt động.</p>
            <a href="#">Tìm hiểu về PDC</a>
        </div>
    </section>

    <!-- Dịch vụ nha khoa -->
    <section class="services">
        <div class="container">
            <h2>Dịch vụ nha khoa</h2>
            <p>Chúng tôi cung cấp dịch vụ hàng đầu với triết lý “Giải pháp tối ưu, cân thiện tối thiểu”.</p>
            <div class="grid">
                <!-- Cấy ghép Implant -->
                <div class="service-card">
                    <svg class="text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 11c0-1.1-.9-2-2-2s-2 .9-2 2v2c0 1.1.9 2 2 2s2-.9 2-2v-2zm0 0c0-1.1-.9-2-2-2s-2 .9-2 2v2c0 1.1.9 2 2 2s2-.9 2-2v-2zm0 0c0-1.1-.9-2-2-2s-2 .9-2 2v2c0 1.1.9 2 2 2s2-.9 2-2v-2z"></path>
                    </svg>
                    <h3>Cấy ghép Implant</h3>
                    <p>Giải pháp phục hồi răng mất, đảm bảo thẩm mỹ và chức năng nhai tốt nhất cho người dùng.</p>
                </div>
                <!-- Chỉnh nha mắc cài -->
                <div class="service-card">
                    <svg class="text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 11c0-1.1-.9-2-2-2s-2 .9-2 2v2c0 1.1.9 2 2 2s2-.9 2-2v-2zm0 0c0-1.1-.9-2-2-2s-2 .9-2 2v2c0 1.1.9 2 2 2s2-.9 2-2v-2zm0 0c0-1.1-.9-2-2-2s-2 .9-2 2v2c0 1.1.9 2 2 2s2-.9 2-2v-2z"></path>
                    </svg>
                    <h3>Chỉnh nha mắc cài</h3>
                    <p>Nắn chỉnh răng mọc lệch, giúp bạn có một nụ cười khỏe mạnh và tự tin.</p>
                </div>
                <!-- Nha khoa trẻ em -->
                <div class="service-card">
                    <svg class="text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 11c0-1.1-.9-2-2-2s-2 .9-2 2v2c0 1.1.9 2 2 2s2-.9 2-2v-2zm0 0c0-1.1-.9-2-2-2s-2 .9-2 2v2c0 1.1.9 2 2 2s2-.9 2-2v-2zm0 0c0-1.1-.9-2-2-2s-2 .9-2 2v2c0 1.1.9 2 2 2s2-.9 2-2v-2z"></path>
                    </svg>
                    <h3>Nha khoa trẻ em</h3>
                    <p>Mang đến nụ cười khỏe mạnh cho trẻ, giúp trẻ tự tin và có hàm răng đều đẹp.</p>
                </div>
                <!-- Phẫu thuật chỉnh hình xương hàm -->
                <div class="service-card">
                    <svg class="text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 11c0-1.1-.9-2-2-2s-2 .9-2 2v2c0 1.1.9 2 2 2s2-.9 2-2v-2zm0 0c0-1.1-.9-2-2-2s-2 .9-2 2v2c0 1.1.9 2 2 2s2-.9 2-2v-2zm0 0c0-1.1-.9-2-2-2s-2 .9-2 2v2c0 1.1.9 2 2 2s2-.9 2-2v-2z"></path>
                    </svg>
                    <h3>Phẫu thuật chỉnh hình xương hàm</h3>
                    <p>Giải quyết các vấn đề chỉnh nắn thẩm mỹ và chức năng hàm, nâng cao chất lượng cuộc sống.</p>
                </div>
                <!-- Nha khoa thẩm mỹ -->
                <div class="service-card">
                    <svg class="text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 11c0-1.1-.9-2-2-2s-2 .9-2 2v2c0 1.1.9 2 2 2s2-.9 2-2v-2zm0 0c0-1.1-.9-2-2-2s-2 .9-2 2v2c0 1.1.9 2 2 2s2-.9 2-2v-2zm0 0c0-1.1-.9-2-2-2s-2 .9-2 2v2c0 1.1.9 2 2 2s2-.9 2-2v-2z"></path>
                    </svg>
                    <h3>Nha khoa thẩm mỹ</h3>
                    <p>Mang đến nụ cười tự nhiên, giúp bạn tự tin với nụ cười trắng sáng và hoàn hảo.</p>
                </div>
                <!-- Nhổ răng khôn -->
                <div class="service-card">
                    <svg class="text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 11c0-1.1-.9-2-2-2s-2 .9-2 2v2c0 1.1.9 2 2 2s2-.9 2-2v-2zm0 0c0-1.1-.9-2-2-2s-2 .9-2 2v2c0 1.1.9 2 2 2s2-.9 2-2v-2zm0 0c0-1.1-.9-2-2-2s-2 .9-2 2v2c0 1.1.9 2 2 2s2-.9 2-2v-2z"></path>
                    </svg>
                    <h3>Nhổ răng khôn</h3>
                    <p>Tiến hành an toàn, nhẹ nhàng với công nghệ hiện đại, đảm bảo không đau và nhanh chóng.</p>
                </div>
            </div>
        </div>
    </section>

</body>
</html>