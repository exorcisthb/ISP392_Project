<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Bác Sĩ / Y Tá</title>
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
    </style>
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center mb-4">Thêm Bác Sĩ / Y Tá</h2>

    <div class="form-container">
        <form action="AddEmployeeServlet" method="post">
            <div class="mb-3">
                <label for="fullName" class="form-label">Họ và tên</label>
                <input type="text" class="form-control" id="fullName" name="fullName" placeholder="Nhập họ và tên" required>
            </div>

            <div class="mb-3">
                <label for="gender" class="form-label">Giới tính</label>
                <select class="form-select" id="gender" name="gender" required>
                    <option value="" disabled selected>Chọn giới tính</option>
                    <option value="Nam">Nam</option>
                    <option value="Nữ">Nữ</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="dob" class="form-label">Ngày sinh</label>
                <input type="date" class="form-control" id="dob" name="dob" required>
            </div>

            <div class="mb-3">
                <label for="specialization" class="form-label">Chuyên khoa</label>
                <select class="form-select" id="specialization" name="specialization" required>
                    <option value="" disabled selected>Chọn trình độ</option>
                    <option value="Chuyên môn">Chuyên môn</option>
                    <option value="Thạc Sỹ">Thạc Sỹ</option>
                    <option value="Tiến Sỹ">Tiến Sỹ</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="role" class="form-label">Vai trò</label>
                <select class="form-select" id="role" name="role" required>
                    <option value="" disabled selected>Chọn vai trò</option>
                    <option value="Bác sĩ">Bác sĩ</option>
                    <option value="Y tá">Y tá</option>
                </select>
            </div>

            <!-- Hidden field for status, defaulting to "Hoạt động" -->
            <input type="hidden" id="status" name="status" value="Hoạt động">

            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Nhập email" required>
            </div>

            <div class="mb-3">
                <label for="phone" class="form-label">Số điện thoại</label>
                <input type="text" class="form-control" id="phone" name="phone" placeholder="Nhập số điện thoại">
            </div>

            <div class="mb-3">
                <label for="address" class="form-label">Địa chỉ</label>
                <input type="text" class="form-control" id="address" name="address" placeholder="Nhập địa chỉ">
            </div>

            <div class="d-flex justify-content-between">
                <button type="submit" class="btn btn-custom text-white">Thêm</button>
                <a href="ViewEmployees.jsp" class="btn btn-secondary">Quay lại</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>