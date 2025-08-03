# PHÂN TÍCH LỖI: "Không tìm thấy lịch của bác sĩ/y tá hiện tại"

## 🔍 Tóm tắt vấn đề
Khi người dùng bấm nút "Xác nhận" ở trang edit lịch trình bác sĩ/y tá, hệ thống báo lỗi **"Không tìm thấy lịch của bác sĩ/y tá hiện tại"**.

## 🎯 Nguyên nhân chính

### 1. **Lỗi logic trong luồng xử lý**
Thông báo lỗi này xuất hiện từ method `getScheduleById()` trong file `SchedulesDAO.java` tại **dòng 162**:

```java
public Schedules getScheduleById(int scheduleID) throws SQLException {
    // ... logic query database ...
    if (rs.next()) {
        // Tạo và return schedule object
        return schedule;
    }
    return null; // Không tìm thấy lịch trình <- ĐÂY LÀ NGUYÊN NHÂN!
}
```

### 2. **Các điểm trong code gây ra lỗi**

#### A. Trong `EditScheduleDoctorNurseServlet.java` (dòng 42-47):
```java
Schedules schedule = schedulesDAO.getScheduleById(scheduleID);
if (schedule == null) {
    request.setAttribute("error", "Không tìm thấy lịch của bác sĩ/y tá hiện tại.");
    // Forward đến JSP để hiển thị lỗi
}
```

#### B. Trong `UpdateScheduleDoctorNurseServlet.java` (dòng 50-55):
```java
Schedules existingSchedule = schedulesDAO.getScheduleById(scheduleID);
if (existingSchedule == null) {
    request.setAttribute("error", "Không tìm thấy lịch của bác sĩ/y tá hiện tại...");
    // Forward đến JSP để hiển thị lỗi
}
```

## 🚨 Các nguyên nhân có thể gây ra lỗi

### 1. **ID lịch trình không tồn tại trong database**
- ScheduleID được truyền qua URL parameter có thể:
  - Không tồn tại trong bảng `Schedules`
  - Đã bị xóa bởi người dùng khác
  - Bị corrupted trong quá trình truyền tải

### 2. **Vấn đề kết nối database**
- Kết nối database bị lỗi
- Query SQL không thực thi được
- Timeout khi truy vấn database

### 3. **Vấn đề parsing parameter**
- ScheduleID parameter bị null hoặc rỗng
- Format không đúng (không phải số nguyên)
- Encoding/decoding URL có vấn đề

### 4. **Race condition**
- Người dùng A đang edit schedule
- Người dùng B xóa schedule đó
- Người dùng A submit form → lỗi

### 5. **Session/Authentication issues**
- Session hết hạn
- Người dùng không có quyền truy cập schedule đó
- Database permissions bị thay đổi

## 🔧 Giải pháp khắc phục

### 1. **Cải thiện validation và error handling**

```java
// Trong EditScheduleDoctorNurseServlet
@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) {
    String scheduleIdParam = request.getParameter("scheduleID");
    
    // Validation tốt hơn
    if (scheduleIdParam == null || scheduleIdParam.trim().isEmpty()) {
        request.setAttribute("error", "Thiếu thông tin ID lịch trình.");
        response.sendRedirect(request.getContextPath() + "/admin/viewSchedules");
        return;
    }
    
    try {
        int scheduleID = Integer.parseInt(scheduleIdParam);
        
        // Kiểm tra xem scheduleID có hợp lệ không (> 0)
        if (scheduleID <= 0) {
            request.setAttribute("error", "ID lịch trình không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/admin/viewSchedules");
            return;
        }
        
        Schedules schedule = schedulesDAO.getScheduleById(scheduleID);
        if (schedule == null) {
            // Logging để debug
            System.err.println("Schedule not found for ID: " + scheduleID);
            
            request.setAttribute("error", 
                "Lịch trình có ID " + scheduleID + " không tồn tại hoặc đã bị xóa. " +
                "Vui lòng kiểm tra lại danh sách lịch trình.");
            response.sendRedirect(request.getContextPath() + "/admin/viewSchedules?error=notfound");
            return;
        }
        
        request.setAttribute("schedule", schedule);
        request.getRequestDispatcher("/views/admin/EditScheduleDoctorNurse.jsp")
               .forward(request, response);
               
    } catch (NumberFormatException e) {
        System.err.println("Invalid scheduleID format: " + scheduleIdParam);
        request.setAttribute("error", "ID lịch trình phải là số nguyên.");
        response.sendRedirect(request.getContextPath() + "/admin/viewSchedules");
    } catch (SQLException e) {
        System.err.println("Database error: " + e.getMessage());
        e.printStackTrace();
        request.setAttribute("error", "Lỗi kết nối cơ sở dữ liệu. Vui lòng thử lại sau.");
        response.sendRedirect(request.getContextPath() + "/admin/viewSchedules");
    }
}
```

### 2. **Cải thiện SchedulesDAO**

```java
public Schedules getScheduleById(int scheduleID) throws SQLException {
    // Validation input
    if (scheduleID <= 0) {
        System.err.println("Invalid scheduleID: " + scheduleID);
        return null;
    }
    
    String query = "SELECT * FROM Schedules WHERE ScheduleID = ?";
    try (Connection conn = dbContext.getConnection()) {
        if (conn == null) {
            System.err.println("Database connection is null");
            throw new SQLException("Không thể kết nối đến cơ sở dữ liệu");
        }
        
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, scheduleID);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Schedules schedule = new Schedules();
                    // ... mapping data ...
                    System.out.println("Found schedule with ID: " + scheduleID);
                    return schedule;
                } else {
                    System.err.println("No schedule found with ID: " + scheduleID);
                    return null; // Không tìm thấy lịch trình
                }
            }
        }
    } catch (SQLException e) {
        System.err.println("SQL Error in getScheduleById: " + e.getMessage());
        throw e;
    }
}
```

### 3. **Thêm logging và monitoring**

```java
// Thêm vào đầu method để tracking
System.out.println("=== EDIT SCHEDULE REQUEST ===");
System.out.println("ScheduleID param: " + scheduleIdParam);
System.out.println("Request URI: " + request.getRequestURI());
System.out.println("User session: " + request.getSession().getId());
System.out.println("Timestamp: " + new Date());
```

### 4. **Cải thiện UI/UX**

```html
<!-- Trong EditScheduleDoctorNurse.jsp -->
<% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="fas fa-exclamation-triangle"></i>
        <strong>Lỗi:</strong> <%= request.getAttribute("error") %>
        <br>
        <small class="text-muted">
            Nếu vấn đề vẫn tiếp tục, vui lòng liên hệ quản trị viên hệ thống.
        </small>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    
    <div class="mt-3">
        <a href="${pageContext.request.contextPath}/admin/viewSchedules" 
           class="btn btn-primary">
            <i class="fas fa-arrow-left"></i> Về danh sách lịch trình
        </a>
    </div>
<% } %>
```

## 🏃‍♂️ Cách debug ngay lập tức

### 1. **Kiểm tra database**
```sql
-- Kiểm tra xem schedule có tồn tại không
SELECT * FROM Schedules WHERE ScheduleID = [ID_CỤ_THỂ];

-- Kiểm tra tổng số records
SELECT COUNT(*) FROM Schedules;

-- Kiểm tra status của database connection
SELECT 1 as test_connection;
```

### 2. **Kiểm tra log files**
- Check server logs để xem có error nào không
- Xem network traffic để đảm bảo parameter được truyền đúng

### 3. **Test step by step**
1. Truy cập `/admin/viewSchedules` → Kiểm tra danh sách có hiển thị không
2. Click vào link "Chỉnh sửa" → Xem URL có đúng format không
3. Kiểm tra parameter trong browser developer tools

## 📋 Checklist khắc phục

- [ ] Kiểm tra database connection
- [ ] Validate scheduleID parameter
- [ ] Thêm proper error handling
- [ ] Cải thiện logging
- [ ] Test với different scenarios
- [ ] Update UI để user-friendly hơn
- [ ] Thêm database constraints nếu cần
- [ ] Review authorization logic

## 🎯 Kết luận

Lỗi **"Không tìm thấy lịch của bác sĩ/y tá hiện tại"** chủ yếu do:
1. **Schedule không tồn tại** trong database khi user cố gắng edit
2. **Parameter handling không đúng** trong servlet
3. **Thiếu validation** và error handling tốt

Giải pháp tốt nhất là **cải thiện validation, error handling và thêm logging** để dễ dàng debug khi có vấn đề xảy ra.