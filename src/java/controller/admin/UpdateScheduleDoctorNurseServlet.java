package controller.admin;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.dao.SchedulesDAO;
import model.entity.Schedules;

@WebServlet(name = "UpdateScheduleDoctorNurseServlet", urlPatterns = {"/UpdateScheduleDoctorNurseServlet", "/admin/updateSchedule"})
public class UpdateScheduleDoctorNurseServlet extends HttpServlet {

    private SchedulesDAO schedulesDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        schedulesDAO = new SchedulesDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Lấy thông tin từ form
            String scheduleIdParam = request.getParameter("scheduleID");
            String doctorIdParam = request.getParameter("doctorID");
            String nurseIdParam = request.getParameter("nurseID");
            String startTimeParam = request.getParameter("startTime");
            String endTimeParam = request.getParameter("endTime");
            String dayOfWeek = request.getParameter("dayOfWeek");
            String roomIdParam = request.getParameter("roomID");
            String status = request.getParameter("status");
            String createdByParam = request.getParameter("createdBy");
            
            // Validate input
            if (scheduleIdParam == null || scheduleIdParam.trim().isEmpty()) {
                request.setAttribute("error", "ID lịch trình không được để trống.");
                request.getRequestDispatcher("/views/admin/EditScheduleDoctorNurse.jsp")
                       .forward(request, response);
                return;
            }
            
            int scheduleID = Integer.parseInt(scheduleIdParam);
            
            // KIỂM TRA XEM LỊCH TRÌNH CÓ TỒN TẠI KHÔNG TRƯỚC KHI CẬP NHẬT
            Schedules existingSchedule = schedulesDAO.getScheduleById(scheduleID);
            if (existingSchedule == null) {
                // ĐÂY LÀ MỘT TRONG NHỮNG NGUYÊN NHÂN GÂY RA LỖI!
                request.setAttribute("error", "Không tìm thấy lịch của bác sĩ/y tá hiện tại. Có thể lịch đã bị xóa hoặc không tồn tại.");
                request.getRequestDispatcher("/views/admin/EditScheduleDoctorNurse.jsp")
                       .forward(request, response);
                return;
            }
            
            // Tạo đối tượng Schedule để cập nhật
            Schedules schedule = new Schedules();
            schedule.setScheduleID(scheduleID);
            schedule.setDoctorID(Integer.parseInt(doctorIdParam));
            schedule.setNurseID(Integer.parseInt(nurseIdParam));
            schedule.setStartTime(Date.valueOf(startTimeParam));
            schedule.setEndTime(Date.valueOf(endTimeParam));
            schedule.setDayOfWeek(dayOfWeek);
            schedule.setRoomID(Integer.parseInt(roomIdParam));
            schedule.setStatus(status);
            schedule.setCreatedBy(Integer.parseInt(createdByParam));
            
            // Thực hiện cập nhật
            boolean success = schedulesDAO.updateSchedule(schedule);
            
            if (success) {
                // Cập nhật thành công, redirect về trang danh sách
                response.sendRedirect(request.getContextPath() + "/admin/viewSchedules?success=updated");
            } else {
                // Cập nhật thất bại
                request.setAttribute("error", "Không thể cập nhật lịch trình. Vui lòng kiểm tra lại thông tin.");
                request.setAttribute("schedule", schedule);
                request.getRequestDispatcher("/views/admin/EditScheduleDoctorNurse.jsp")
                       .forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu nhập vào không hợp lệ. Vui lòng kiểm tra lại.");
            request.getRequestDispatcher("/views/admin/EditScheduleDoctorNurse.jsp")
                   .forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/EditScheduleDoctorNurse.jsp")
                   .forward(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Định dạng ngày không hợp lệ: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/EditScheduleDoctorNurse.jsp")
                   .forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to the edit servlet
        response.sendRedirect(request.getContextPath() + "/admin/editSchedule?" + request.getQueryString());
    }
}