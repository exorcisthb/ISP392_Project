package controller.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import model.entity.Users;
import model.service.UserService;

@WebServlet(name = "EditProfileUserController", urlPatterns = {"/EditProfileUserController"})
public class EditProfileController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String role = user.getRole();
        String jspPath = getJspPathByRole(role);
        request.getRequestDispatcher(jspPath).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("/views/common/login.jsp");
            return;
        }

        try {
            // Lấy dữ liệu chung
            String fullName = request.getParameter("fullName");
            String dobStr = request.getParameter("dob");
            String gender = request.getParameter("gender");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            // Parse ngày sinh
            Date dob = null;
            if (dobStr != null && !dobStr.isEmpty()) {
                dob = Date.valueOf(dobStr);
            }

            // Cập nhật thông tin chung
            user.setFullName(fullName);
            user.setDob(dob);
            user.setGender(gender);
            user.setPhone(phone);
            user.setAddress(address);

            // Cập nhật thông tin riêng theo role
            String role = user.getRole().toLowerCase();
            switch (role) {
                case "doctor":
                case "nurse":
                    String specialization = request.getParameter("specialization");
                    user.setSpecialization(specialization);
                    user.setMedicalHistory(null);
                    break;

                case "patient":
                    String medicalHistory = request.getParameter("medicalHistory");
                    user.setMedicalHistory(medicalHistory);
                    user.setSpecialization(null);
                    break;

                case "receptionist":
                    user.setSpecialization(null);
                    user.setMedicalHistory(null);
                    break;

                default:
                    throw new ServletException("Vai trò không được hỗ trợ: " + role);
            }

            // Gọi Service cập nhật
            UserService userService = new UserService(); // Sử dụng UserService thay vì UserDAO
            userService.updateUserProfile(user);
            session.setAttribute("user", user);
            request.setAttribute("success", "Cập nhật hồ sơ thành công.");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cập nhật hồ sơ: " + e.getMessage());
        }

        // Quay lại đúng trang JSP theo vai trò
        String jspPath = getJspPathByRole(user.getRole());
        request.getRequestDispatcher(jspPath).forward(request, response);
    }

    private String getJspPathByRole(String role) {
        if (role == null) return "/views/common/error.jsp";

        switch (role.toLowerCase()) {
            case "doctor":
            case "nurse":
                return "/views/user/DoctorNurse/EditProfileDoctorNurse.jsp";
            case "patient":
                return "/views/user/Patient/EditProfilePatient.jsp";
            case "receptionist":
                return "/views/user/Receptionist/EditProfileReceptionist.jsp";
            default:
                return null;
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet dùng chung cập nhật hồ sơ cho Doctor/Nurse, Patient, Receptionist";
    }
}
