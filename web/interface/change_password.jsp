<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đổi mật khẩu</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <div class="container mt-5" style="max-width: 500px;">
        <h2 class="mb-4">Đổi mật khẩu</h2>

        <c:if test="${not empty message}">
            <div class="alert alert-info">${message}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/changePassword" method="post">
            <div class="mb-3">
                <label for="oldPassword" class="form-label">Mật khẩu cũ</label>
                <input type="password" class="form-control" id="oldPassword" name="oldPassword" required />
            </div>
            <div class="mb-3">
                <label for="newPassword" class="form-label">Mật khẩu mới</label>
                <input type="password" class="form-control" id="newPassword" name="newPassword" required />
            </div>
            <button type="submit" class="btn btn-primary w-100">Xác nhận đổi mật khẩu</button>
        </form>

        <div class="mt-3 text-center">
            <a href="${pageContext.request.contextPath}/views/common/login.jsp">Quay lại đăng nhập</a>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
</body>
</html>
