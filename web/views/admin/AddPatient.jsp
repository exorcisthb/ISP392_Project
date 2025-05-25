<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Thêm Bệnh Nhân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #e3f2fd, #bbdefb);
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .container {
            background: #fff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            margin-top: 40px;
            max-width: 700px;
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #2c3e50;
            font-weight: 600;
            letter-spacing: 1px;
        }
        label {
            font-weight: 500;
        }
        .btn-primary {
            background: linear-gradient(to right, #1976d2, #64b5f6);
            border: none;
        }
        .btn-primary:hover {
            background: linear-gradient(to right, #1565c0, #42a5f5);
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Thêm Bệnh Nhân Mới</h2>
    <form action="${pageContext.request.contextPath}/addpatient" method="post">
      <div class="mb-3">
            <label for="fullName" class="form-label">Họ và Tên *</label>
            <input type="text" class="form-control" id="fullName" name="fullName" 
                   value="${param.fullName}" required />
        </div>

        <div class="mb-3">
            <label for="dob" class="form-label">Ngày sinh</label>
            <input type="date" class="form-control" id="dob" name="dob" 
                   value="${param.dob}" />
        </div>

        <div class="mb-3">
            <label class="form-label">Giới tính</label><br/>
            <input type="radio" id="male" name="gender" value="Nam" 
                <c:if test="${param.gender == 'Nam'}">checked</c:if> />
            <label for="male">Nam</label>

            <input type="radio" id="female" name="gender" value="Nữ" 
                <c:if test="${param.gender == 'Nữ'}">checked</c:if> />
            <label for="female">Nữ</label>

            <input type="radio" id="other" name="gender" value="Khác" 
                <c:if test="${param.gender == 'Khác'}">checked</c:if> />
            <label for="other">Khác</label>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Email *</label>
            <input type="email" class="form-control" id="email" name="email" 
                   value="${param.email}" required />
        </div>

        <div class="mb-3">
            <label for="phone" class="form-label">Số điện thoại</label>
            <input type="text" class="form-control" id="phone" name="phone" 
                   value="${param.phone}" />
        </div>

        <div class="mb-3">
            <label for="username" class="form-label">Tên đăng nhập *</label>
            <input type="text" class="form-control" id="username" name="username" 
                   value="${param.username}" required />
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Mật khẩu *</label>
            <input type="password" class="form-control" id="password" name="password" 
                   required />
        </div>

        <div class="mb-3">
            <label for="address" class="form-label">Địa chỉ</label>
            <input type="text" class="form-control" id="address" name="address" 
                   value="${param.address}" />
        </div>

        <div class="mb-3">
            <label for="medicalHistory" class="form-label">Tiền sử bệnh</label>
            <textarea class="form-control" id="medicalHistory" name="medicalHistory" rows="4">${param.medicalHistory}</textarea>
        </div>

        <button type="submit" class="btn btn-primary">Thêm Bệnh Nhân</button>
    </form>
</div>
</body>
</html>
