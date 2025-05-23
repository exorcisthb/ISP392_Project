<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách bệnh nhân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center mb-4">Danh sách bệnh nhân</h2>

    <div class="d-flex justify-content-between mb-3">
        <input type="text" class="form-control w-50 me-2" placeholder="Tìm theo tên hoặc số điện thoại..." id="searchInput">
        <a href="addPatient.jsp" class="btn btn-success">Thêm bệnh nhân</a>
    </div>

    <table class="table table-bordered table-hover">
        <thead class="table-danger text-center">
        <tr>
            <th>ID</th>
            <th>Họ tên</th>
            <th>Giới tính</th>
            <th>Ngày sinh</th>
            <th>SĐT</th>
            <th>Địa chỉ</th>
            <th>Trạng Thái</th>
            <th>Hành Động</th>
        </tr>
        </thead>
        <tbody id="patientTable">
        <tr>
            <td>1</td>
            <td>Nguyễn Văn B</td>
            <td>Nam</td>
            <td>12/10/1995</td>
            <td>0912345678</td>
            <td>123 Nguyễn Trãi, Hà Nội</td>
            <td class="text-center d-flex justify-content-center gap-1">
                <a href="viewPatient.jsp?id=1" class="btn btn-sm btn-info text-white">Xem chi tiết</a>
                <a href="editPatient.jsp?id=1" class="btn btn-sm btn-primary">Sửa</a>
                <a href="deletePatient?id=1" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa bệnh nhân này?');">Xóa</a>
            </td>
        </tr>
        </tbody>
    </table>
</div>

<script>
    document.getElementById("searchInput").addEventListener("keyup", function () {
        let filter = this.value.toLowerCase();
        let rows = document.querySelectorAll("#patientTable tr");
        rows.forEach(row => {
            let text = row.innerText.toLowerCase();
            row.style.display = text.includes(filter) ? "" : "none";
        });
    });
</script>
</body>
</html>