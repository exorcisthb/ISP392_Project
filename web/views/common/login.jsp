<%-- 
    Document   : login
    Created on : Feb 27, 2025, 2:28:51 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Liên kết CSS -->
<!--        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">-->
        <!-- Font Awesome (nếu cần icon) -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/LoginCSS/LoginCSS.css">
        <title>Hệ thống quản lí phòng khám đa khoa</title>
      </head>
    <body>
        <div class="wrapper">
            <nav class="nav">
                <div class="nav-logo">
                    <p>Group 1</p>
                </div>
                <div class="nav-menu">
                    <ul>
                        <li><a href="views/common/login.jsp" class="link active">Home</a></li>
                        <li><a href="interface/Blog.jsp" class="link">Blog</a></li>
                        <li><a href="interface/Service.jsp" class="link">Services</a></li>
                        <li><a href="interface/About.jsp" class="link">About</a></li>
                    </ul>
                </div>
                <div class="nav-button">
                    <button class="btn" id="loginBtn">Sign In</button>
                    <button class="btn" id="registerBtn">Sign Up</button>
                </div>
            </nav>

            <div class="form-box" id="login" style="display: flex;">
                <div class="top">
                    <span>Không có tài khoản? <a href="#" onclick="register()">Sign Up</a></span>
                    <header>Đăng Nhập</header>
                </div>
                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="input-box">
                        <input type="text" class="input-field" name="emailOrUsername" placeholder="Email hoặc Username" required>
                        <i class="bx bx-user"></i>
                    </div>
                    <div class="input-box">
                        <input type="password" class="input-field" name="password" placeholder="Mật khẩu" required>
                        <i class="bx bx-lock-alt"></i>
                    </div>
                    <div class="input-box">
                        <input type="submit" class="submit" value="Đăng Nhập">
                    </div>
                    <div class="two-col">
                        <div class="one">
                            <input type="checkbox" id="login-check" name="rememberMe">
                            <label for="login-check">Ghi nhớ</label>
                        </div>
                        <div class="two">
                            <label><a href="#">Quên mật khẩu?</a></label>
                        </div>
                    </div>
                    <c:if test="${not empty error}">
                        <div class="error" style="color: red;">${error}</div>
                    </c:if>
                    <c:if test="${not empty successMessage}">
                        <div class="success" style="color: green;">${successMessage}</div>
                    </c:if>
                </form>
            </div>

            <!-- registration form -->
            <div class="form-box" id="register" style="display: none;">
                <div class="top">
                    <span>Có tài khoản? <a href="#" onclick="login()">Login</a></span>
                    <header>Sign Up</header>
                </div>
                <form action="${pageContext.request.contextPath}/RegistrationServlet" method="post">
                    <div class="input-box">
                        <input type="text" class="input-field" name="username" placeholder="Username" required>
                        <i class="bx bx-user"></i>
                    </div>
                    <div class="input-box">
                        <input type="email" class="input-field" name="email" placeholder="Email" required>
                        <i class="bx bx-envelope"></i>
                    </div>
                    <div class="input-box">
                        <input type="password" class="input-field" name="password" placeholder="Password" required>
                        <i class="bx bx-lock-alt"></i>
                    </div>
                    <div class="input-box">
                        <select name="role" class="input-field" required>
                            <option value="" disabled selected>Chọn vai trò</option>
                            <option value="patient">Patient</option>
                            <option value="doctor">Doctor</option>
                            <option value="nurse">Nurse</option>
                            <option value="receptionist">Receptionist</option>
                        </select>
                        <i class="bx bx-user"></i>
                    </div>
                    <div class="input-box">
                        <input type="submit" class="submit" value="Register">
                    </div>
                    <div class="two-col">
                        <div class="one">
                            <input type="checkbox" id="register-check" name="rememberMe">
                            <label for="register-check">Remember Me</label>
                        </div>
                        <div class="two">
                            <label><a href="#">Terms & conditions</a></label>
                        </div>
                    </div>
                    <c:if test="${not empty error}">
                        <div class="error" style="color: red;">${error}</div>
                    </c:if>
                </form>
            </div>
        </div>

        <script>
            function login() {
                document.getElementById('register').style.display = 'none';
                document.getElementById('login').style.display = 'block';
            }

            function register() {
                document.getElementById('login').style.display = 'none';
                document.getElementById('register').style.display = 'block';
            }

            // Add event listeners to navigation buttons
            document.getElementById('loginBtn').addEventListener('click', login);
            document.getElementById('registerBtn').addEventListener('click', register);

            // Show login form by default on page load
            login();
        </script>
    </body>
</html>