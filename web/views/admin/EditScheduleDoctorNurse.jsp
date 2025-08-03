<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.entity.Schedules"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chỉnh sửa lịch trình bác sĩ/y tá</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Chỉnh sửa lịch trình bác sĩ/y tá</h2>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <%= request.getAttribute("error") %>
                <!-- ĐÂY LÀ NƠI HIỂN THỊ LỖI "Không tìm thấy lịch của bác sĩ/y tá hiện tại." -->
            </div>
        <% } %>
        
        <%
            Schedules schedule = (Schedules) request.getAttribute("schedule");
            if (schedule != null) {
        %>
        
        <form action="${pageContext.request.contextPath}/admin/updateSchedule" method="post" class="needs-validation" novalidate>
            <input type="hidden" name="scheduleID" value="<%= schedule.getScheduleID() %>">
            
            <div class="row">
                <div class="col-md-6">
                    <div class="mb-3">
                        <label for="doctorID" class="form-label">ID Bác sĩ</label>
                        <input type="number" class="form-control" id="doctorID" name="doctorID" 
                               value="<%= schedule.getDoctorID() %>" required>
                        <div class="invalid-feedback">
                            Vui lòng nhập ID bác sĩ.
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="mb-3">
                        <label for="nurseID" class="form-label">ID Y tá</label>
                        <input type="number" class="form-control" id="nurseID" name="nurseID" 
                               value="<%= schedule.getNurseID() %>" required>
                        <div class="invalid-feedback">
                            Vui lòng nhập ID y tá.
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-6">
                    <div class="mb-3">
                        <label for="startTime" class="form-label">Thời gian bắt đầu</label>
                        <input type="date" class="form-control" id="startTime" name="startTime" 
                               value="<%= schedule.getStartTime() %>" required>
                        <div class="invalid-feedback">
                            Vui lòng chọn thời gian bắt đầu.
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="mb-3">
                        <label for="endTime" class="form-label">Thời gian kết thúc</label>
                        <input type="date" class="form-control" id="endTime" name="endTime" 
                               value="<%= schedule.getEndTime() %>" required>
                        <div class="invalid-feedback">
                            Vui lòng chọn thời gian kết thúc.
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-4">
                    <div class="mb-3">
                        <label for="dayOfWeek" class="form-label">Ngày trong tuần</label>
                        <select class="form-select" id="dayOfWeek" name="dayOfWeek" required>
                            <option value="">Chọn ngày</option>
                            <option value="Monday" <%= "Monday".equals(schedule.getDayOfWeek()) ? "selected" : "" %>>Thứ Hai</option>
                            <option value="Tuesday" <%= "Tuesday".equals(schedule.getDayOfWeek()) ? "selected" : "" %>>Thứ Ba</option>
                            <option value="Wednesday" <%= "Wednesday".equals(schedule.getDayOfWeek()) ? "selected" : "" %>>Thứ Tư</option>
                            <option value="Thursday" <%= "Thursday".equals(schedule.getDayOfWeek()) ? "selected" : "" %>>Thứ Năm</option>
                            <option value="Friday" <%= "Friday".equals(schedule.getDayOfWeek()) ? "selected" : "" %>>Thứ Sáu</option>
                            <option value="Saturday" <%= "Saturday".equals(schedule.getDayOfWeek()) ? "selected" : "" %>>Thứ Bảy</option>
                        </select>
                        <div class="invalid-feedback">
                            Vui lòng chọn ngày trong tuần.
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="mb-3">
                        <label for="roomID" class="form-label">ID Phòng</label>
                        <input type="number" class="form-control" id="roomID" name="roomID" 
                               value="<%= schedule.getRoomID() %>" required>
                        <div class="invalid-feedback">
                            Vui lòng nhập ID phòng.
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="mb-3">
                        <label for="status" class="form-label">Trạng thái</label>
                        <select class="form-select" id="status" name="status" required>
                            <option value="">Chọn trạng thái</option>
                            <option value="Available" <%= "Available".equals(schedule.getStatus()) ? "selected" : "" %>>Có sẵn</option>
                            <option value="Busy" <%= "Busy".equals(schedule.getStatus()) ? "selected" : "" %>>Bận</option>
                            <option value="Unavailable" <%= "Unavailable".equals(schedule.getStatus()) ? "selected" : "" %>>Không có sẵn</option>
                        </select>
                        <div class="invalid-feedback">
                            Vui lòng chọn trạng thái.
                        </div>
                    </div>
                </div>
            </div>
            
            <input type="hidden" name="createdBy" value="<%= schedule.getCreatedBy() %>">
            
            <div class="mb-3">
                <button type="submit" class="btn btn-primary">Xác nhận cập nhật</button>
                <!-- ĐÂY LÀ NÚT MÀ NGƯỜI DÙNG BẤM VÀ GÂY RA LỖI -->
                <a href="${pageContext.request.contextPath}/admin/viewSchedules" class="btn btn-secondary">Hủy</a>
            </div>
        </form>
        
        <% } else { %>
            <div class="alert alert-warning">
                Không có thông tin lịch trình để chỉnh sửa.
                <a href="${pageContext.request.contextPath}/admin/viewSchedules" class="btn btn-primary mt-2">Về danh sách lịch trình</a>
            </div>
        <% } %>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Bootstrap form validation
        (function() {
            'use strict';
            window.addEventListener('load', function() {
                var forms = document.getElementsByClassName('needs-validation');
                var validation = Array.prototype.filter.call(forms, function(form) {
                    form.addEventListener('submit', function(event) {
                        if (form.checkValidity() === false) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            }, false);
        })();
    </script>
</body>
</html>