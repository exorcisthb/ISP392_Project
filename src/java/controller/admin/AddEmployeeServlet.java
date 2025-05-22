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

@WebServlet(name = "AddEmployeeServlet", urlPatterns = {"/AddEmployeeServlet", "/admin/viewEmployees"})
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
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Retain form values in case of error
        request.setAttribute("fullName", fullName);
        request.setAttribute("gender", gender);
        request.setAttribute("dob", dobStr);
        request.setAttribute("specialization", specialization);
        request.setAttribute("role", role);
        request.setAttribute("username", username);
        request.setAttribute("password", password);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);
        request.setAttribute("address", address);

        // Basic validation
        if (fullName == null || fullName.trim().isEmpty() ||
            gender == null || gender.trim().isEmpty() ||
            dobStr == null || dobStr.trim().isEmpty() ||
            role == null || role.trim().isEmpty() ||
            username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
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

        // Optional validation for specialization based on role
        if ((role.equals("doctor") || role.equals("nurse")) && (specialization == null || specialization.trim().isEmpty())) {
            request.setAttribute("error", "Chuyên môn là bắt buộc cho bác sĩ hoặc y tá.");
            request.getRequestDispatcher("views/admin/ViewEmployees.jsp").forward(request, response);
            return;
        }

        try {
            // Get the admin ID from session
            HttpSession session = request.getSession();
            Integer createdBy = (Integer) session.getAttribute("adminId");
            if (createdBy == null) {
                createdBy = 35; // Gán admin ID khớp với database
            }

            // Set default status as "Active" (khớp với database)
            String status = "Active";

            // Call UserService to add the user
            boolean success = userService.addUser(fullName, gender, dob, specialization, role, status, email, phone, address, username, password, createdBy);
            if (success) {
                // Set success message in session and redirect to the view employees page
                session.setAttribute("successMessage", "Thêm nhân viên thành công!");
                response.sendRedirect(request.getContextPath() + "/views/admin/ViewEmployees.jsp");
            } else {
                request.setAttribute("error", "Không thể thêm nhân viên. Email, username hoặc số điện thoại có thể đã tồn tại.");
                request.getRequestDispatcher("views/admin/AddDoctorNurse.jsp").forward(request, response); // Quay lại form để sửa
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi thêm nhân viên: " + e.getMessage());
            request.getRequestDispatcher("views/admin/AddDoctorNurse.jsp").forward(request, response); // Quay lại form để sửa
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("views/admin/AddDoctorNurse.jsp").forward(request, response); // Quay lại form để sửa
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        if (path.equals("/AddEmployeeServlet")) {
            // Forward to AddDoctorNurse.jsp for adding a new employee
            request.getRequestDispatcher("/views/admin/AddDoctorNurse.jsp").forward(request, response);
        } else if (path.equals("/admin/viewEmployees")) {
            // Forward to ViewEmployees.jsp to display the list of employees
            request.getRequestDispatcher("/views/admin/ViewEmployees.jsp").forward(request, response);
        }
    }
}