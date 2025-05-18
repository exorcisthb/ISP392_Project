package controller.common;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.service.UserService;
import model.entity.Users;

/**
 * Xử lý hoàn thiện hồ sơ của user
 */
@WebServlet(name = "CompleteProfileController", urlPatterns = {"/CompleteProfileController"})
public class CompleteProfileController extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy user từ session
        Users user = (Users) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/UserLoginController");
            return;
        }

        try {
            // Lấy thông tin từ form
            String fullName = request.getParameter("fullName");
            String dobStr = request.getParameter("dob");
            String gender = request.getParameter("gender");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String medicalHistory = request.getParameter("medicalHistory"); // Chỉ cho Patient
            String specialization = request.getParameter("specialization"); // Chỉ cho Doctor/Nurse

            // Validate dữ liệu
            if (fullName == null || fullName.trim().isEmpty() ||
                dobStr == null || dobStr.trim().isEmpty() ||
                gender == null || gender.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty() ||
                address == null || address.trim().isEmpty()) {
                request.setAttribute("error", "Vui lòng điền đầy đủ các trường bắt buộc.");
                redirectToCompleteProfile(user.getRole(), request, response);
                return;
            }

            // Cập nhật thông tin user
            user.setFullName(fullName);
            user.setDob(Date.valueOf(dobStr));
            user.setGender(gender);
            user.setPhone(phone);
            user.setAddress(address);
            user.setMedicalHistory(medicalHistory != null ? medicalHistory : "");
            user.setSpecialization(specialization != null ? specialization : "");

            // Gọi service để cập nhật vào database
            userService.updateUserProfile(user);

            // Chuyển hướng đến dashboard
            String redirectUrl = getDashboardUrl(user.getRole());
            response.sendRedirect(request.getContextPath() + redirectUrl);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi cập nhật hồ sơ: " + e.getMessage());
            redirectToCompleteProfile(user.getRole(), request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Ngày sinh không hợp lệ.");
            redirectToCompleteProfile(user.getRole(), request, response);
        }
    }

    private void redirectToCompleteProfile(String role, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        switch (role.toLowerCase()) {
            case "patient":
                request.getRequestDispatcher("/views/user/Patient/CompleteProfilePatient.jsp").forward(request, response);
                break;
            case "doctor":
            case "nurse":
                request.getRequestDispatcher("/views/user/DoctorNurse/CompleteProfileDoctorNurse.jsp").forward(request, response);
                break;
            case "receptionist":
                request.getRequestDispatcher("/views/user/Receptionist/CompleteProfileReceptionist.jsp").forward(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/default/completeProfile");
        }
    }

    private String getDashboardUrl(String role) {
        if (role == null) {
            return "/default/dashboard";
        }
        switch (role.toLowerCase()) {
            case "patient":
                return "/views/user/Patient/PatientDashBoard.jsp";
            case "doctor":
            case "nurse":
                return "/views/user/DoctorNurse/EmployeeDashBoard.jsp";
            case "receptionist":
                return "/views/user/Receptionist/ReceptionistDashBoard.jsp";
            default:
                return "/default/dashboard";
        }
    }
}