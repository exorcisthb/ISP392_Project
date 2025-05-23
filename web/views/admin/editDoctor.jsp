<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa thông tin bác sĩ / y tá</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="d-flex justify-content-start mb-3">
        <a href="${pageContext.request.contextPath}/views/admin/dashboard.jsp" class="btn btn-primary">Home</a>
    </div>

    <h2 class="text-center mb-4">Sửa thông tin bác sĩ / y tá</h2>
    <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">${error}</div>
    </c:if>
    <c:if test="${empty employee}">
        <div class="alert alert-danger" role="alert">Không tìm thấy nhân viên để chỉnh sửa.</div>
        <a href="${pageContext.request.contextPath}/ViewEmployeeServlet" class="btn btn-secondary">Quay lại</a>
    </c:if>
    <c:if test="${not empty employee}">
        <form action="${pageContext.request.contextPath}/EditEmployeeServlet" method="post" class="needs-validation" novalidate>
            <input type="hidden" name="userID" value="${employee.userID}">
            <div class="mb-3">
                <label for="fullName" class="form-label">Họ và tên</label>
                <input type="text" class="form-control" id="fullName" name="fullName"
                       value="${not empty formFullName ? formFullName : (not empty employee.fullName ? employee.fullName : '')}"
                       required>
                <div class="invalid-feedback">Họ và tên chỉ được chứa chữ cái và dấu cách.</div>
            </div>
            <div class="mb-3">
                <label for="gender" class="form-label">Giới tính</label>
                <select class="form-select" id="gender" name="gender" required>
                    <option value="" disabled ${empty formGender && empty employee.gender ? 'selected' : ''}>Chọn giới tính</option>
                    <option value="Nam" ${formGender == 'Nam' || (empty formGender && employee.gender == 'Nam') ? 'selected' : ''}>Nam</option>
                    <option value="Nữ" ${formGender == 'Nữ' || (empty formGender && employee.gender == 'Nữ') ? 'selected' : ''}>Nữ</option>
                </select>
                <div class="invalid-feedback">Vui lòng chọn giới tính.</div>
            </div>
            <div class="mb-3">
                <label for="specialization" class="form-label">Chuyên khoa</label>
                <select class="form-select" id="specialization" name="specialization" required>
                    <option value="" disabled ${empty formSpecialization && empty employee.specialization ? 'selected' : ''}>Chọn chuyên khoa</option>
                    <option value="Chuyên môn" ${formSpecialization == 'Chuyên môn' || (empty formSpecialization && employee.specialization == 'Chuyên môn') ? 'selected' : ''}>Chuyên môn</option>
                    <option value="Thạc sĩ" ${formSpecialization == 'Thạc sĩ' || (empty formSpecialization && employee.specialization == 'Thạc sĩ') ? 'selected' : ''}>Thạc sĩ</option>
                    <option value="Tiến sĩ" ${formSpecialization == 'Tiến sĩ' || (empty formSpecialization && employee.specialization == 'Tiến sĩ') ? 'selected' : ''}>Tiến sĩ</option>
                </select>
                <div class="invalid-feedback">Vui lòng chọn chuyên khoa.</div>
            </div>
            <div class="mb-3">
                <label for="dob" class="form-label">Ngày sinh</label>
                <input type="date" class="form-control" id="dob" name="dob"
                       value="${not empty formDob ? formDob : (not empty employee.dob ? employee.dob : '')}"
                       required>
                <div class="invalid-feedback">Vui lòng nhập ngày sinh.</div>
            </div>
            <div class="d-flex justify-content-end">
                <a href="${pageContext.request.contextPath}/ViewEmployeeServlet" class="btn btn-secondary me-2">Hủy</a>
                <button type="submit" class="btn btn-primary">Lưu</button>
            </div>
        </form>
    </c:if>
</div>
<script>
    (function () {
        'use strict';
        const forms = document.querySelectorAll('.needs-validation');
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    })();
</script>
</body>
</html>