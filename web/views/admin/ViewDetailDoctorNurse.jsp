<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.entity.Users" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết Bác Sĩ / Y Tá</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .detail-card {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin-bottom: 20px;
            }
            .detail-label {
                font-weight: bold;
                color: #333;
            }
            .detail-value {
                color: #555;
            }
        </style>
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <div class="d-flex justify-content-start mb-3">
                <a href="${pageContext.request.contextPath}/views/admin/dashboard.jsp" class="btn btn-primary">Home</a>
            </div>
            <h2 class="text-center mb-4">Chi tiết Bác Sĩ / Y Tá</h2>
            <form action="ViewEmployeeServlet" method="post"></form>
            <c:choose>
                <c:when test="${not empty requestScope.user}">
                    <div class="detail-card">
                        <div class="row mb-3">
                            <div class="col-md-3 detail-label">ID:</div>
                            <div class="col-md-9 detail-value">${requestScope.user.userID}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-3 detail-label">Tên đầy đủ:</div>
                            <div class="col-md-9 detail-value">${requestScope.user.fullName}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-3 detail-label">Tên đăng nhập:</div>
                            <div class="col-md-9 detail-value">${requestScope.user.username}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-3 detail-label">Email:</div>
                            <div class="col-md-9 detail-value">${requestScope.user.email}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-3 detail-label">Giới tính:</div>
                            <div class="col-md-9 detail-value">${requestScope.user.gender}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-3 detail-label">Chuyên khoa:</div>
                            <div class="col-md-9 detail-value">${requestScope.user.specialization}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-3 detail-label">Ngày sinh:</div>
                            <div class="col-md-9 detail-value">
                                <fmt:formatDate value="${requestScope.user.dob}" pattern="dd/MM/yyyy" />
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-3 detail-label">Số điện thoại:</div>
                            <div class="col-md-9 detail-value">${requestScope.user.phone}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-3 detail-label">Địa chỉ:</div>
                            <div class="col-md-9 detail-value">${requestScope.user.address}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-3 detail-label">Vai trò:</div>
                            <div class="col-md-9 detail-value">${requestScope.user.role}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-3 detail-label">Trạng thái:</div>
                            <div class="col-md-9 detail-value">${requestScope.user.status}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-3 detail-label">Ngày tạo:</div>
                            <div class="col-md-9 detail-value">
                                <fmt:formatDate value="${requestScope.user.createdAt}" pattern="dd/MM/yyyy HH:mm:ss" />
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-3 detail-label">Ngày cập nhật:</div>
                            <div class="col-md-9 detail-value">
                                <fmt:formatDate value="${requestScope.user.updatedAt}" pattern="dd/MM/yyyy HH:mm:ss" />
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-danger text-center" role="alert">
                        Không tìm thấy thông tin bác sĩ/y tá!
                    </div>
                </c:otherwise>
            </c:choose>

            <div class="text-center">
                <a href="${pageContext.request.contextPath}/ViewEmployeeServlet" class="btn btn-primary">Quay lại danh sách</a>
            </div>
        </div>
    </body>
</html>