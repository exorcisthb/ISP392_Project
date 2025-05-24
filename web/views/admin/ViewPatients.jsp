<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.entity.Users" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách Bệnh Nhân</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background: linear-gradient(135deg, #e3f2fd, #bbdefb);
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
                background: linear-gradient(to right, #1976d2, #64b5f6);
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
                background: linear-gradient(to right, #1976d2, #64b5f6);
                border: none;
                transition: all 0.3s ease;
            }

            .btn-primary:hover {
                background: linear-gradient(to right, #1565c0, #42a5f5);
                box-shadow: 0 5px 15px rgba(25, 118, 210, 0.3);
            }

            .btn-success {
                background: linear-gradient(to right, #1976d2, #64b5f6);
                border: none;
                transition: all 0.3s ease;
            }

            .btn-success:hover {
                background: linear-gradient(to right, #1565c0, #42a5f5);
                box-shadow: 0 5px 15px rgba(25, 118, 210, 0.3);
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
                background-color: #e3f2fd;
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
                <a href="${pageContext.request.contextPath}/views/admin/dashboard.jsp" class="btn btn-primary">Home</a>
            </div>
            <h2 class="text-center mb-4">Danh sách Bệnh Nhân</h2>
            <div class="d-flex justify-content-end mb-3">
                <a href="${pageContext.request.contextPath}/views/admin/AddPatient.jsp" class="btn btn-success">Thêm bệnh nhân</a>
            </div>
            <form action="ViewPatientServlet" method="get">
                <table class="table table-bordered table-hover">
                    <thead class="table-light text-center">
                        <tr>
                            <th>ID</th>
                            <th>Họ tên</th>
                            <th>Giới tính</th>
                            <th>Ngày sinh</th>
                            <th>SĐT</th>
                            <th>Địa chỉ</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty patients}">
                                <c:forEach var="patient" items="${patients}">
                                    <tr class="text-center">
                                        <td>${patient.userID}</td>
                                        <td>${patient.fullName}</td>
                                        <td>${patient.gender}</td>
                                        <td><fmt:formatDate value="${patient.dob}" pattern="dd/MM/yyyy" /></td>
                                        <td>${patient.phone}</td>
                                        <td>${patient.address}</td>
                                        <td>${patient.status}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/ViewPatientDetailServlet?id=${patient.userID}" class="btn btn-sm btn-info text-white">Xem chi tiết</a>
                                            <a href="editPatient.jsp?id=${patient.userID}" class="btn btn-sm btn-primary">Sửa</a>
                                            <a href="${pageContext.request.contextPath}/deletePatient?id=${patient.userID}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa bệnh nhân này?');">Xóa</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="8" class="text-center">Không có dữ liệu</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </form>
        </div>
    </body>
</html>