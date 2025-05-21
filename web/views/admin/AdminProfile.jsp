<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.entity.Admins" %>
<%
    Admins admin = (Admins) request.getAttribute("adminProfile");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thông tin Hồ sơ Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
    <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-2xl">
        <h1 class="text-2xl font-bold text-center mb-6 text-blue-600">Hồ sơ Quản trị viên</h1>

        <div class="space-y-4">
            <div class="flex justify-between">
                <span class="font-semibold text-gray-700">ID:</span>
                <span><%= admin.getAdminID() %></span>
            </div>
                 <div class="flex justify-between">
                <span class="font-semibold text-gray-700">Username:</span>
                <span><%= admin.getUsername() %></span>
            </div>
            <div class="flex justify-between">
                <span class="font-semibold text-gray-700">Tên đầy đủ:</span>
                <span><%= admin.getFullName() %></span>
            </div>
            <div class="flex justify-between">
                <span class="font-semibold text-gray-700">Email:</span>
                <span><%= admin.getEmail() %></span>
            </div>
            
            <div class="flex justify-between">
                <span class="font-semibold text-gray-700">Ngày tạo tài khoản:</span>
                <span><%= admin.getCreatedAt() %></span>
            </div>
               
        </div>
            

        <div class="mt-8 text-center">
            <a href="<%= request.getContextPath() %>/views/admin/dashboard.jsp" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition">
                Quay về Dashboard
            </a>
        </div>
    </div>
</body>
</html>
