package controller.admin;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.service.UserService;

@WebServlet(name = "AddEmployeeServlet", urlPatterns = {"/AddEmployeeServlet"})
public class AddEmployeeServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve form parameters
        String fullName = request.getParameter("fullName");
        String gender = request.getParameter("gender");
        String dobStr = request.getParameter("dob");
        String specialization = request.getParameter("specialization");
        String role = request.getParameter("role");
        String status = request.getParameter("status");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Retain form values in case of error
        request.setAttribute("fullName", fullName);
        request.setAttribute("gender", gender);
        request.setAttribute("dob", dobStr);
        request.setAttribute("specialization", specialization);
        request.setAttribute("role", role);
        request.setAttribute("status", status);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);
        request.setAttribute("address", address);

        // Basic validation
        if (fullName == null || fullName.trim().isEmpty() ||
            gender == null || gender.trim().isEmpty() ||
            dobStr == null || dobStr.trim().isEmpty() ||
            specialization == null || specialization.trim().isEmpty() ||
            role == null || role.trim().isEmpty() ||
            status == null || status.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ các trường bắt buộc.");
            request.getRequestDispatcher("views/admin/ViewEmployees.jsp").forward(request, response);
            return;
        }

        // Convert dob to java.sql.Date
        Date dob;
        try {
            dob = Date.valueOf(dobStr);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Ngày sinh không hợp lệ.");
            request.getRequestDispatcher("views/admin/ViewEmployees.jsp").forward(request, response);
            return;
        }

        try {
            // Get the admin ID from session (assuming the logged-in user is an admin)
            HttpSession session = request.getSession();
            Integer createdBy = (Integer) session.getAttribute("adminId"); // Adjust based on your session attribute
            if (createdBy == null) {
                createdBy = 1; // Default admin ID if not found in session (adjust as needed)
            }

            // Call UserService to add the employee
            boolean success = userService.addEmployee(fullName, gender, dob, specialization, role, status, email, phone, address, createdBy);
            if (success) {
                // Set success message in session and redirect to list page
                session.setAttribute("successMessage", "Thêm bác sĩ/y tá thành công!");
                response.sendRedirect(request.getContextPath() + "views/admin/ViewEmployees.jsp");
            } else {
                request.setAttribute("error", "Không thể thêm bác sĩ/y tá. Email hoặc số điện thoại có thể đã tồn tại.");
                request.getRequestDispatcher("views/admin/ViewEmployees.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi thêm bác sĩ/y tá: " + e.getMessage());
            request.getRequestDispatcher("views/admin/ViewEmployees.jsp").forward(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("views/admin/ViewEmployees.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Simply forward to the AddDoctorNurse.jsp page for GET requests
        request.getRequestDispatcher("/AddDoctorNurse.jsp").forward(request, response);
    }
}