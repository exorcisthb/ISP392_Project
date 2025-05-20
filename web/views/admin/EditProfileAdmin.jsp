<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.entity.Admins"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa hồ sơ Admin</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f4f6;
            padding: 20px;
        }
        .form-container {
            background-color: white;
            max-width: 500px;
            margin: 0 auto;
            padding: 24px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 16px;
        }
        label {
            display: block;
            margin-top: 12px;
        }
        input {
            width: 100%;
            padding: 8px;
            margin-top: 4px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        .btn {
            margin-top: 20px;
            padding: 10px;
            background-color: #10b981;
            color: white;
            border: none;
            width: 100%;
            border-radius: 6px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #059669;
        }
        .message {
            text-align: center;
            margin-top: 12px;
        }
        .message.success {
            color: green;
        }
        .message.error {
            color: red;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Chỉnh sửa hồ sơ Admin</h2>

        <%
            Admins admin = (Admins) session.getAttribute("admin");
            if (admin == null) {
                response.sendRedirect(request.getContextPath() + "/views/admin/login.jsp");
                return;
            }
            request.setAttribute("admin", admin);
        %>

        <c:if test="${not empty success}">
            <div class="message success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="message error">${error}</div>
        </c:if>

        <form action="EditProfileAdminController" method="post">
            <label>Tên đăng nhập:</label>
            <input type="text" name="username" value="${admin.username}" required>
            <label>Họ tên:</label>
            <input type="text" name="fullName" value="${admin.fullName}" required>

            <label>Email:</label>
            <input type="email" name="email" value="${admin.email}" required>

            <button type="submit" class="btn">Cập nhật</button>
                <c:if test="${not empty error}">
                    <p class="error">${error}</p>
                </c:if>
                <c:if test="${not empty success}">
                    <p class="success">${success}</p>
                </c:if>  
                <a href="${pageContext.request.contextPath}/views/admin/dashboard.jsp">
                    <button type="button" class="btn">Quay lại trang chủ</button>
                </a>
        </form>
    </div>
</body>
</html>