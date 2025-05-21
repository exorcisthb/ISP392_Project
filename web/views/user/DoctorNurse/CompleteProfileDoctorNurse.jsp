<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hoàn Thiện Hồ Sơ - Bác Sĩ/Y Tá</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .form-label {
            font-weight: bold;
        }
        .btn-custom {
            background-color: #28a745;
            border-color: #28a745;
        }
        .btn-custom:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }
        .error {
            color: #dc3545;
            font-size: 0.9em;
            margin-top: 5px;
        }
    </style>
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center mb-4">Hoàn Thiện Hồ Sơ (Bác Sĩ/Y Tá)</h2>

    <div class="form-container">
        <form action="${pageContext.request.contextPath}/CompleteProfileController" method="post">
            <input type="hidden" name="userID" value="${sessionScope.user.userID}">

            <div class="mb-3">
                <label for="fullName" class="form-label">Họ và tên</label>
                <input type="text" class="form-control" id="fullName" name="fullName" value="${fullName}" placeholder="Nhập họ và tên" required>
            </div>

            <div class="mb-3">
                <label for="gender" class="form-label">Giới tính</label>
                <select class="form-select" id="gender" name="gender" required>
                    <option value="" disabled ${empty gender ? 'selected' : ''}>Chọn giới tính</option>
                    <option value="Nam" ${gender == 'Nam' ? 'selected' : ''}>Nam</option>
                    <option value="Nữ" ${gender == 'Nữ' ? 'selected' : ''}>Nữ</option>
                    <option value="Khác" ${gender == 'Khác' ? 'selected' : ''}>Khác</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="dob" class="form-label">Ngày sinh</label>
                <input type="date" class="form-control" id="dob" name="dob" value="${dob}" required>
            </div>

            <div class="mb-3">
                <label for="phone" class="form-label">Số điện thoại</label>
                <input type="tel" class="form-control" id="phone" name="phone" value="${phone}" placeholder="Nhập số điện thoại (10 chữ số)" required>
            </div>

            <div class="mb-3">
                <label for="specialization" class="form-label">Trình độ chuyên môn</label>
                <select class="form-select" id="specialization" name="specialization" required>
                    <option value="" disabled ${empty specialization ? 'selected' : ''}>Chọn trình độ</option>
                    <option value="Chuyên môn" ${specialization == 'Chuyên môn' ? 'selected' : ''}>Chuyên môn</option>
                    <option value="Thạc Sỹ" ${specialization == 'Thạc Sỹ' ? 'selected' : ''}>Thạc Sỹ</option>
                    <option value="Tiến Sỹ" ${specialization == 'Tiến Sỹ' ? 'selected' : ''}>Tiến Sỹ</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="address" class="form-label">Địa chỉ</label>
                <input type="text" class="form-control" id="address" name="address" value="${address}" placeholder="Nhập địa chỉ" required>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">${error}</div>
            </c:if>

            <div class="d-flex justify-content-end">
                <button type="submit" class="btn btn-custom text-white">Hoàn thiện</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>