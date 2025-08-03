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

@WebServlet(name = "ReassignScheduleDoctorNurseServlet", urlPatterns = {"/ReassignScheduleDoctorNurseServlet", "/admin/reassignSchedule"})
public class ReassignScheduleDoctorNurseServlet extends HttpServlet {

    private SchedulesDAO schedulesDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        schedulesDAO = new SchedulesDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String scheduleIdParam = request.getParameter("scheduleID");
        
        if (scheduleIdParam == null || scheduleIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/viewSchedules");
            return;
        }
        
        try {
            int scheduleID = Integer.parseInt(scheduleIdParam);
            
            // Lấy thông tin lịch trình cần phân công lại
            Schedules schedule = schedulesDAO.getScheduleById(scheduleID);
            
            if (schedule == null) {
                // NGUYÊN NHÂN GÂY RA LỖI TƯƠNG TỰ!
                request.setAttribute("error", "Không tìm thấy lịch của bác sĩ/y tá hiện tại để phân công lại.");
                request.getRequestDispatcher("/views/admin/ReassignScheduleDoctorNurse.jsp")
                       .forward(request, response);
                return;
            }
            
            request.setAttribute("schedule", schedule);
            request.getRequestDispatcher("/views/admin/ReassignScheduleDoctorNurse.jsp")
                   .forward(request, response);
                   
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID lịch trình không hợp lệ.");
            request.getRequestDispatcher("/views/admin/ReassignScheduleDoctorNurse.jsp")
                   .forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải thông tin lịch trình: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/ReassignScheduleDoctorNurse.jsp")
                   .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String scheduleIdParam = request.getParameter("scheduleID");
            String newDoctorIdParam = request.getParameter("newDoctorID");
            String newNurseIdParam = request.getParameter("newNurseID");
            
            if (scheduleIdParam == null || scheduleIdParam.trim().isEmpty()) {
                request.setAttribute("error", "ID lịch trình không được để trống.");
                request.getRequestDispatcher("/views/admin/ReassignScheduleDoctorNurse.jsp")
                       .forward(request, response);
                return;
            }
            
            int scheduleID = Integer.parseInt(scheduleIdParam);
            
            // Kiểm tra xem lịch trình có tồn tại không
            Schedules existingSchedule = schedulesDAO.getScheduleById(scheduleID);
            if (existingSchedule == null) {
                request.setAttribute("error", "Không tìm thấy lịch của bác sĩ/y tá hiện tại để phân công lại.");
                request.getRequestDispatcher("/views/admin/ReassignScheduleDoctorNurse.jsp")
                       .forward(request, response);
                return;
            }
            
            // Cập nhật thông tin bác sĩ và y tá mới
            existingSchedule.setDoctorID(Integer.parseInt(newDoctorIdParam));
            existingSchedule.setNurseID(Integer.parseInt(newNurseIdParam));
            
            boolean success = schedulesDAO.updateSchedule(existingSchedule);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/viewSchedules?success=reassigned");
            } else {
                request.setAttribute("error", "Không thể phân công lại lịch trình. Vui lòng kiểm tra lại thông tin.");
                request.setAttribute("schedule", existingSchedule);
                request.getRequestDispatcher("/views/admin/ReassignScheduleDoctorNurse.jsp")
                       .forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu nhập vào không hợp lệ.");
            request.getRequestDispatcher("/views/admin/ReassignScheduleDoctorNurse.jsp")
                   .forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/ReassignScheduleDoctorNurse.jsp")
                   .forward(request, response);
        }
    }
}