<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Cập Nhật Nhân Viên</title>
    <meta charset="UTF-8">
</head>
<body>
    <h2>Cập Nhật Thông Tin Nhân Viên</h2>
    <% if (request.getAttribute("error") != null) { %>
        <p style="color:red;"><%= request.getAttribute("error") %></p>
    <% } %>
    <% if (request.getSession().getAttribute("message") != null) { %>
        <p style="color:green;"><%= request.getSession().getAttribute("message") %></p>
        <% request.getSession().removeAttribute("message"); %>
    <% } %>
    <form action="AddEmployeeServlet" method="post">
        <!-- Tìm người dùng đã đăng ký -->
        <label>Email hoặc Username:</label>
        <input type="text" name="emailOrUsername" required>
        <button type="button" onclick="checkUser()">Kiểm Tra</button><br>
        <!-- Thông tin bổ sung -->
        <label>Họ Tên:</label>
        <input type="text" name="fullName" required><br>
        <label>Chuyên Môn (cho Bác Sĩ):</label>
        <input type="text" name="specialization"><br>
        <label>Số Điện Thoại:</label>
        <input type="text" name="phone"><br>
        <label>Ngày Sinh:</label>
        <input type="date" name="dob"><br>
        <label>Giới Tính:</label>
        <select name="gender">
            <option value="Male">Nam</option>
            <option value="Female">Nữ</option>
            <option value="Other">Khác</option>
        </select><br>
        <label>Địa Chỉ:</label>
        <input type="text" name="address"><br>
        <input type="hidden" name="adminId" value="<%= session.getAttribute("adminId") %>">
        <input type="submit" value="Cập Nhật Nhân Viên">
    </form>
    <script>
        function checkUser() {
            alert("Vui lòng kiểm tra email hoặc username!");
        }
    </script>
</body>
</html>