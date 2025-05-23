package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.entity.Users;
import model.service.UserService;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "ViewPatientServlet", urlPatterns = {"/ViewPatientServlet"})
public class ViewPatientServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Users> patients = userService.getAllPatient();
            request.setAttribute("patients", patients); // Fixed attribute name
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải danh sách bệnh nhân: " + e.getMessage());
        }

        request.getRequestDispatcher("views/admin/ViewPatients.jsp").forward(request, response);
    }
}