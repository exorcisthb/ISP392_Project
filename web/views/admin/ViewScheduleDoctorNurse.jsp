<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.entity.Schedules"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản lý lịch trình bác sĩ/y tá</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Danh sách lịch trình bác sĩ/y tá</h2>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success">
                <% if ("updated".equals(request.getParameter("success"))) { %>
                    Cập nhật lịch trình thành công!
                <% } else if ("reassigned".equals(request.getParameter("success"))) { %>
                    Phân công lại lịch trình thành công!
                <% } %>
            </div>
        <% } %>
        
        <div class="table-responsive">
            <table class="table table-striped table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Bác sĩ ID</th>
                        <th>Y tá ID</th>
                        <th>Thời gian bắt đầu</th>
                        <th>Thời gian kết thúc</th>
                        <th>Ngày trong tuần</th>
                        <th>Phòng ID</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Schedules> schedules = (List<Schedules>) request.getAttribute("schedules");
                        if (schedules != null && !schedules.isEmpty()) {
                            for (Schedules schedule : schedules) {
                    %>
                    <tr>
                        <td><%= schedule.getScheduleID() %></td>
                        <td><%= schedule.getDoctorID() %></td>
                        <td><%= schedule.getNurseID() %></td>
                        <td><%= schedule.getStartTime() %></td>
                        <td><%= schedule.getEndTime() %></td>
                        <td><%= schedule.getDayOfWeek() %></td>
                        <td><%= schedule.getRoomID() %></td>
                        <td><%= schedule.getStatus() %></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/editSchedule?scheduleID=<%= schedule.getScheduleID() %>" 
                               class="btn btn-primary btn-sm">Chỉnh sửa</a>
                            <a href="${pageContext.request.contextPath}/admin/reassignSchedule?scheduleID=<%= schedule.getScheduleID() %>" 
                               class="btn btn-warning btn-sm">Phân công lại</a>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="9" class="text-center">Không có lịch trình nào</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
        
        <div class="mt-3">
            <a href="${pageContext.request.contextPath}/views/admin/dashboard.jsp" class="btn btn-secondary">Về Dashboard</a>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>