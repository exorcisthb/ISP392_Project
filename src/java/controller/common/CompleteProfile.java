//package controller.common;
//
//import java.io.IOException;
//import java.sql.Date;
//import java.sql.SQLException;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import model.dao.UserDAO;
//import model.entity.Users;
//
//@WebServlet(name = "CompleteProfile", urlPatterns = {"/CompleteProfile"})
//public class CompleteProfile extends HttpServlet {
//
//    private UserDAO userDAO;
//
//    @Override
//    public void init() throws ServletException {
//        userDAO = new UserDAO();
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        String username = (String) session.getAttribute("username");
//        String role = (String) session.getAttribute("role");
//
//        String fullName = request.getParameter("fullName");
//        String dobStr = request.getParameter("dob");
//        String gender = request.getParameter("gender");
//        String phone = request.getParameter("phone");
//        String address = request.getParameter("address");
//        String specialization = request.getParameter("specialization");
//
//        if (fullName == null || fullName.trim().isEmpty() ||
//            dobStr == null || dobStr.trim().isEmpty() ||
//            gender == null || gender.trim().isEmpty() ||
//            phone == null || phone.trim().isEmpty() ||
//            address == null || address.trim().isEmpty()) {
//            request.setAttribute("error", "Tất cả các trường đều bắt buộc.");
//            request.getRequestDispatcher("/views/common/completeProfile.jsp").forward(request, response);
//            return;
//        }
//
//        if (("doctor".equals(role) || "nurse".equals(role)) && (specialization == null || specialization.trim().isEmpty())) {
//            request.setAttribute("error", "Chuyên môn là bắt buộc đối với Bác sĩ và Y tá.");
//            request.getRequestDispatcher("/views/common/completeProfile.jsp").forward(request, response);
//            return;
//        }
//
//        try {
//            Users pendingUser = userDAO.findPendingUserByEmailOrUsername(username);
//            if (pendingUser == null) {
//                request.setAttribute("error", "Không tìm thấy thông tin đăng ký tạm thời.");
//                request.getRequestDispatcher("/views/common/completeProfile.jsp").forward(request, response);
//                return;
//            }
//
//            Users user = new Users();
//            user.setUsername(pendingUser.getUsername());
//            user.setEmail(pendingUser.getEmail());
//            user.setPassword(pendingUser.getPassword());
//            user.setFullName(fullName);
//            user.setDob(Date.valueOf(dobStr));
//            user.setGender(gender);
//            user.setPhone(phone);
//            user.setAddress(address);
//            user.setMedicalHistory(null); // Optional
//            user.setSpecialization(("doctor".equals(role) || "nurse".equals(role)) ? specialization : null);
//            user.setRole(role);
//            user.setStatus("Active");
//            user.setCreatedBy(1); // Assume created by system or admin
//            user.setCreatedAt(new Date(System.currentTimeMillis()));
//            user.setUpdatedAt(new Date(System.currentTimeMillis()));
//
//            if (userDAO.registerUser(user)) {
//                userDAO.deletePendingUser(username);
//                response.sendRedirect(request.getContextPath() + "/login"); // Back to login to use existing controllers
//            } else {
//                request.setAttribute("error", "Không thể hoàn tất hồ sơ. Vui lòng thử lại.");
//                request.getRequestDispatcher("/views/common/completeProfile.jsp").forward(request, response);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//            request.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
//            request.getRequestDispatcher("/views/common/completeProfile.jsp").forward(request, response);
//        }
//    }
//
//    @Override
//    public String getServletInfo() {
//        return "Handles profile completion for new users";
//    }
//}