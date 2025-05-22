<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lỗi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center mb-4 text-danger">Đã xảy ra lỗi</h2>
    <div class="alert alert-danger" role="alert">
        <%
            String errorMessage = (String) request.getAttribute("error");
            if (errorMessage != null) {
                out.println(errorMessage);
            } else {
                out.println("Đã xảy ra lỗi không xác định. Vui lòng thử lại sau.");
            }
        %>
    </div>
    <div class="text-center">
        <a href="${pageContext.request.contextPath}/ViewEmployeeServlet" class="btn btn-primary">Quay lại danh sách bác sĩ/y tá</a>
    </div>
</div>
</body>
</html>