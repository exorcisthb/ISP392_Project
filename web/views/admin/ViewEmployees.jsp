<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.entity.Users" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách Nhân Viên</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background: linear-gradient(135deg, #fff3e0, #ffe082);
                font-family: 'Segoe UI', Arial, sans-serif;
            }

            .container {
                background: #ffffff;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
                margin-top: 40px;
                position: relative;
                overflow: hidden;
            }

            .container::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 5px;
                background: linear-gradient(to right, #f57f17, #ffca28);
            }

            h2 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 30px;
                font-size: 28px;
                font-weight: 600;
                letter-spacing: 1px;
            }

            .btn-primary {
                background: linear-gradient(to right, #f57f17, #ffca28);
                border: none;
                transition: all 0.3s ease;
            }

            .btn-primary:hover {
                background: linear-gradient(to right, #e65100, #ffb300);
                box-shadow: 0 5px 15px rgba(245, 127, 23, 0.3);
            }

            .btn-success {
                background: linear-gradient(to right, #f57f17, #ffca28);
                border: none;
                transition: all 0.3s ease;
            }

            .btn-success:hover {
                background: linear-gradient(to right, #e65100, #ffb300);
                box-shadow: 0 5px 15px rgba(245, 127, 23, 0.3);
            }

            .btn-info {
                background: linear-gradient(to right, #2e7d32, #66bb6a);
                border: none;
                transition: all 0.3s ease;
            }

            .btn-info:hover {
                background: linear-gradient(to right, #1b5e20, #4caf50);
                box-shadow: 0 5px 15px rgba(46, 125, 50, 0.3);
            }

            .btn-danger {
                background: #c62828;
                border: none;
                transition: all 0.3s ease;
            }

            .btn-danger:hover {
                background: #b71c1c;
                box-shadow: 0 5px 15px rgba(198, 40, 40, 0.3);
            }

            .table-hover tbody tr:hover {
                background-color: #fff8e1;
            }

            .table {
                border-radius: 8px;
                overflow: hidden;
            }

            .table-light {
                background-color: #f9fafb;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="d-flex justify-content-start mb-3">
                <a href="${pageContext.request.contextPath}/views/admin/dashboard.jsp" class="btn btn-success">Home</a>
            </div>
            <h2 class="text-center mb-4">Danh sách Nhân Viên</h2>
            <div class="d-flex justify-content-end mb-3">
                <a href="${pageContext.request.contextPath}/views/admin/AddDoctorNurse.jsp" class="btn btn-success">Thêm bác sĩ / Y Tá</a>
            </div>
            <form action="ViewEmployeeServlet" method="get">
                <table class="table table-bordered table-hover">
                    <thead class="table-light text-center">
                        <tr>
                            <th>ID</th>
                            <th>Tên</th>
                            <th>Giới tính</th>
                            <th>Chuyên khoa</th>
                            <th>Ngày sinh</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty employees}">
                                <c:forEach var="user" items="${employees}">
                                    <tr class="text-center">
                                        <td>${user.userID}</td>
                                        <td>${user.fullName}</td>
                                        <td>${user.gender}</td>
                                        <td>${user.specialization}</td>
                                        <td>
                                            <fmt:formatDate value="${user.dob}" pattern="dd/MM/yyyy" />
                                        </td>
                                        <td>${user.status}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/ViewDetailEmployeesServlet?id=${user.userID}" class="btn btn-sm btn-info text-white">Xem chi tiết</a>
                                            <a href="${pageContext.request.contextPath}/UpdateEmployeeServlet?id=${user.userID}" class="btn btn-sm btn-primary">Sửa</a>
                                            <a href="${pageContext.request.contextPath}/DeleteDoctorServlet?id=${user.userID}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa bác sĩ này?');">Xóa</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="7" class="text-center">Không có dữ liệu</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </form>
        </div>
    </body>
</html>