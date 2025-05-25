package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.entity.Users;
import model.service.UserService;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

@WebServlet(name = "AddPatientServlet", urlPatterns = {"/AddPatientServlet"})
public class AddPatientServlet extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hiển thị form thêm bệnh nhân
        request.getRequestDispatcher("/views/admin/AddPatient.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy dữ liệu từ form
       String fullName = request.getParameter("fullName");
        String gender = request.getParameter("gender");
        String dobStr = request.getParameter("dob");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Giữ lại dữ liệu đã nhập (nếu lỗi)
        request.setAttribute("fullName", fullName);
        request.setAttribute("gender", gender);
        request.setAttribute("dob", dobStr);
        request.setAttribute("email", email);
        request.setAttribute("phone", phone);
        request.setAttribute("address", address);
        request.setAttribute("username", username);
        request.setAttribute("password", password);

        // Validate các trường bắt buộc
        if (fullName == null || fullName.trim().isEmpty() ||
            gender == null || gender.trim().isEmpty() ||
            dobStr == null || dobStr.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ các trường bắt buộc.");
            request.getRequestDispatcher("/views/admin/AddPatient.jsp").forward(request, response);
            return;
        }
        // Parse ngày sinh
        Date dob;
        try {
            dob = Date.valueOf(dobStr);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Ngày sinh không hợp lệ.");
            request.getRequestDispatcher("/views/admin/AddPatient.jsp").forward(request, response);
            return;
        }

        
      try {
            // Lấy adminId từ session (người tạo)
            HttpSession session = request.getSession();
            Integer createdBy = (Integer) session.getAttribute("adminId");
            if (createdBy == null) {
                // Nếu không có adminId, bạn có thể xử lý khác như redirect về login
                createdBy = 35; // Hoặc một giá trị mặc định
            }
            // Role mặc định là "patient"
            String role = "patient";
            // Status mặc định "Active"
            String status = "Active";

            // Call UserService to add the user
            boolean success = userService.addUser(fullName, gender, dob, null, role, status, email, phone, address, username, password, createdBy);
            if (success) {
                session.setAttribute("successMessage", "Thêm bệnh nhân thành công!");
                response.sendRedirect(request.getContextPath() + "/views/admin/ViewPatients.jsp");
            } else {
                request.setAttribute("error", "Không thể thêm bệnh nhân. Email, username hoặc số điện thoại có thể đã tồn tại.");
                request.getRequestDispatcher("views/admin/AddPatient.jsp").forward(request, response); 
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi thêm bệnh nhân: " + e.getMessage());
            request.getRequestDispatcher("views/admin/AddPatient.jsp").forward(request, response); 
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("views/admin/AddPatient.jsp").forward(request, response); // Quay lại form để sửa
        }
    }
}
