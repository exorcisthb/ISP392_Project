<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách bác sĩ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center mb-4">Danh sách bác sĩ</h2>

    <div class="d-flex justify-content-between mb-3">
        <input type="text" class="form-control w-50 me-2" placeholder="Tìm theo tên hoặc chuyên khoa..." id="searchInput">
        <a href="addDoctor.jsp" class="btn btn-success">Thêm bác sĩ</a>
    </div>

    <table class="table table-bordered table-hover">
        <thead class="table-primary text-center">
        <tr>
            <th>ID</th>
            <th>Tên</th>
            <th>Giới tính</th>
            <th>Chuyên khoa</th>
            <th>Ngày sinh</th>
            <th>Trạng Thái</th>
        </tr>
        </thead>
        <tbody id="doctorTable">
        <tr>
            <td>1</td>
            <td>Trần Thị A</td>
            <td>Nữ</td>
            <td>Nội khoa</td>
            <td>15/05/1980</td>
            <td class="text-center d-flex justify-content-center gap-1">
                <a href="viewDoctor.jsp?id=1" class="btn btn-sm btn-info text-white">Xem chi tiết</a>
                <a href="editDoctor.jsp?id=1" class="btn btn-sm btn-primary">Sửa</a>
                <a href="deleteDoctor?id=1" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa bác sĩ này?');">Xóa</a>
            </td>
        </tr>
        </tbody>
    </table>
</div>

<script>
    document.getElementById("searchInput").addEventListener("keyup", function () {
        let filter = this.value.toLowerCase();
        let rows = document.querySelectorAll("#doctorTable tr");
        rows.forEach(row => {
            let text = row.innerText.toLowerCase();
            row.style.display = text.includes(filter) ? "" : "none";
        });
    });
</script>
</body>
</html>