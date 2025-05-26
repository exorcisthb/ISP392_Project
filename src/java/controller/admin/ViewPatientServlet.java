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
        System.out.println("Số lượng bệnh nhân lấy được: " + (patients != null ? patients.size() : 0)); // Thêm log
        request.setAttribute("patients", patients); // Fixed attribute name
    } catch (SQLException e) {
        e.printStackTrace();
        request.setAttribute("error", "Lỗi khi tải danh sách bệnh nhân: " + e.getMessage());
        System.out.println("Lỗi SQL: " + e.getMessage()); // Thêm log lỗi
    }

    request.getRequestDispatcher("views/admin/ViewPatients.jsp").forward(request, response);
}
}
