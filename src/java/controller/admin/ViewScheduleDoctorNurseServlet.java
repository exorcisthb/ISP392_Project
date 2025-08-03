package controller.admin;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.dao.SchedulesDAO;
import model.entity.Schedules;

@WebServlet(name = "ViewScheduleDoctorNurseServlet", urlPatterns = {"/ViewScheduleDoctorNurseServlet", "/admin/viewSchedules"})
public class ViewScheduleDoctorNurseServlet extends HttpServlet {

    private SchedulesDAO schedulesDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        schedulesDAO = new SchedulesDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy danh sách tất cả lịch trình
            List<Schedules> schedules = schedulesDAO.getAllSchedules();
            
            // Set attribute để JSP có thể sử dụng
            request.setAttribute("schedules", schedules);
            
            // Forward đến trang hiển thị
            request.getRequestDispatcher("/views/admin/ViewScheduleDoctorNurse.jsp")
                   .forward(request, response);
                   
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải danh sách lịch trình: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/ViewScheduleDoctorNurse.jsp")
                   .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}