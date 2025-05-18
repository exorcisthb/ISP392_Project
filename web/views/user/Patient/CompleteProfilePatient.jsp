<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hoàn thiện hồ sơ - Patient</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; font-weight: bold; }
        input, select, textarea { width: 100%; padding: 8px; margin-top: 5px; }
        button { background-color: #4CAF50; color: white; padding: 10px 20px; border: none; cursor: pointer; }
        button:hover { background-color: #45a049; }
        .error { color: red; }
    </style>
</head>
<body>
    <h2>Hoàn thiện hồ sơ (Patient)</h2>
    <form action="${pageContext.request.contextPath}/CompleteProfileController" method="post">
        <input type="hidden" name="userID" value="${sessionScope.user.userID}">
        <div class="form-group">
            <label for="fullName">Họ và tên:</label>
            <input type="text" id="fullName" name="fullName" required>
        </div>
        <div class="form-group">
            <label for="dob">Ngày sinh:</label>
            <input type="date" id="dob" name="dob" required>
        </div>
        <div class="form-group">
            <label for="gender">Giới tính:</label>
            <select id="gender" name="gender" required>
                <option value="">Chọn giới tính</option>
                <option value="Male">Nam</option>
                <option value="Female">Nữ</option>
                <option value="Other">Khác</option>
            </select>
        </div>
        <div class="form-group">
            <label for="phone">Số điện thoại:</label>
            <input type="tel" id="phone" name="phone" required>
        </div>
        <div class="form-group">
            <label for="address">Địa chỉ:</label>
            <input type="text" id="address" name="address" required>
        </div>
        
        <button type="submit">Hoàn thiện</button>
        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>
    </form>
</body>
</html>