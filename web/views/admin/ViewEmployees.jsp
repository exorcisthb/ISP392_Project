<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.entity.Users" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách bác sĩ</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="container mt-5">


            <h2 class="text-center mb-4">Danh sách Bác Sĩ / Y Tá</h2>

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
                                            <a href="${pageContext.request.contextPath}/ViewDoctorNurseDetailServlet?id=${user.userID}" class="btn btn-sm btn-info text-white">Xem chi tiết</a>
                                            <a href="editDoctor.jsp?id=${user.userID}" class="btn btn-sm btn-primary">Sửa</a>
                                            <a href="${pageContext.request.contextPath}/deleteDoctor?id=${user.userID}" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa bác sĩ này?');">Xóa</a>
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