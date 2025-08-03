package controller.admin;

import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.dao.SchedulesDAO;
import model.entity.Schedules;

@WebServlet(name = "EditScheduleDoctorNurseServlet", urlPatterns = {"/EditScheduleDoctorNurseServlet", "/admin/editSchedule"})
public class EditScheduleDoctorNurseServlet extends HttpServlet {

    private SchedulesDAO schedulesDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        schedulesDAO = new SchedulesDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy scheduleID từ parameter
        String scheduleIdParam = request.getParameter("scheduleID");
        
        if (scheduleIdParam == null || scheduleIdParam.trim().isEmpty()) {
            // Nếu không có scheduleID, redirect về trang danh sách
            response.sendRedirect(request.getContextPath() + "/admin/viewSchedules");
            return;
        }
        
        try {
            int scheduleID = Integer.parseInt(scheduleIdParam);
            
            // Lấy thông tin lịch trình từ database
            Schedules schedule = schedulesDAO.getScheduleById(scheduleID);
            
            if (schedule == null) {
                // ĐÂY LÀ NGUYÊN NHÂN GÂY RA LỖI!
                // Khi không tìm thấy lịch trình, hệ thống sẽ báo lỗi
                request.setAttribute("error", "Không tìm thấy lịch của bác sĩ/y tá hiện tại.");
                request.getRequestDispatcher("/views/admin/EditScheduleDoctorNurse.jsp")
                       .forward(request, response);
                return;
            }
            
            // Set thông tin lịch trình để JSP hiển thị
            request.setAttribute("schedule", schedule);
            
            // Forward đến trang chỉnh sửa
            request.getRequestDispatcher("/views/admin/EditScheduleDoctorNurse.jsp")
                   .forward(request, response);
                   
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID lịch trình không hợp lệ.");
            request.getRequestDispatcher("/views/admin/EditScheduleDoctorNurse.jsp")
                   .forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải thông tin lịch trình: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/EditScheduleDoctorNurse.jsp")
                   .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}