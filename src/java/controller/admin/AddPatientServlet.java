package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.entity.Users;
import model.service.UserService;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

public class AddPatientServlet extends HttpServlet {
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra quyền Admin
        Users loggedInUser = (Users) request.getSession().getAttribute("loggedInUser");
        if (loggedInUser == null || !"Admin".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/views/common/login.jsp");
            return;
        }
        // Hiển thị form thêm bệnh nhân
        request.getRequestDispatcher("/views/admin/AddPatient.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra quyền Admin
        Users loggedInUser = (Users) request.getSession().getAttribute("loggedInUser");
        if (loggedInUser == null || !"Admin".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/views/common/login.jsp");
            return;
        }

        // Lấy dữ liệu từ form
        String fullName = request.getParameter("fullName");
        String dobStr = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        String medicalHistory = request.getParameter("medicalHistory");

        // Parse ngày sinh
        Date dob = null;
        if (dobStr != null && !dobStr.isEmpty()) {
            try {
                dob = Date.valueOf(dobStr);
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", "Ngày sinh không hợp lệ");
                request.getRequestDispatcher("/views/admin/AddPatient.jsp").forward(request, response);
                return;
            }
        }

        // Kiểm tra các trường bắt buộc tối thiểu
        if (fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Tên đầy đủ là bắt buộc");
            request.getRequestDispatcher("/views/admin/AddPatient.jsp").forward(request, response);
            return;
        }
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email là bắt buộc");
            request.getRequestDispatcher("/views/admin/AddPatient.jsp").forward(request, response);
            return;
        }
        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("error", "Tên đăng nhập (username) là bắt buộc");
            request.getRequestDispatcher("/views/admin/AddPatient.jsp").forward(request, response);
            return;
        }
        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Mật khẩu là bắt buộc");
            request.getRequestDispatcher("/views/admin/AddPatient.jsp").forward(request, response);
            return;
        }

        try {
            boolean success = userService.addUser(
                    fullName,
                    gender,
                    dob,
                    null,           // specialization null cho patient
                    "Patient",      // role
                    "Active",       // status mặc định
                    email,
                    phone,
                    address,
                    username,
                    password,
                    medicalHistory,
                    loggedInUser.getUserID() // createdBy
            );

            if (success) {
                // Thêm thành công => chuyển hướng sang danh sách bệnh nhân
                response.sendRedirect(request.getContextPath() + "/admin/ViewPatientServlet");
            } else {
                request.setAttribute("error", "Lỗi khi thêm bệnh nhân: Không thể thêm dữ liệu");
                request.getRequestDispatcher("/views/admin/AddPatient.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            // Lỗi do duplicate hoặc validate từ service
            request.setAttribute("error", "Lỗi khi thêm bệnh nhân: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/AddPatient.jsp").forward(request, response);
        }
    }
}
