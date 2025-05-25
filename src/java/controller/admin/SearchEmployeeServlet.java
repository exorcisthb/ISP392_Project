package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.io.IOException;
import java.util.List;
import model.entity.Users;
import model.service.UserService;

public class SearchEmployeeServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { 
         Users loggedInUser = (Users) request.getSession().getAttribute("loggedInUser");      
        if (loggedInUser == null || !"Admin".equals(loggedInUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/views/common/login.jsp");
            return;
        }
        // Lấy tham số tìm kiếm từ form
        String query = request.getParameter("searchQuery");
        if (query == null) query = "";// Nếu không có tham số, lấy tất cả nhân viên

        try {
            // Tìm kiếm nhân viên dựa trên query
            List<Users> employees = userService.searchEmployeesByEmailOrUsername(query);
            request.setAttribute("employees", employees);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tìm kiếm nhân viên: " + e.getMessage());          
        }
        request.getRequestDispatcher("/views/admin/SearchEmployees.jsp").forward(request, response);
    }
    }
