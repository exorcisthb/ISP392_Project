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
</head>
<body class="bg-light">
    <div class="container mt-5">
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