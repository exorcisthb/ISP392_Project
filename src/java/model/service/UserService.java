package model.service;

import java.sql.SQLException;
import java.sql.Date;
import java.time.LocalDate;
import model.dao.UserDAO;
import model.entity.Users;
import org.mindrot.jbcrypt.BCrypt;

public class UserService {

    private final UserDAO userDAO;

    public UserService() {
        this.userDAO = new UserDAO();
    }

    // Đăng ký tài khoản người dùng mới
    public boolean registerUser(String username, String email, String password, String role, String phone) throws SQLException {
        // Kiểm tra tồn tại
        if (userDAO.isEmailOrUsernameExists(email, username)) {
            return false;
        }
        if (phone != null && !phone.trim().isEmpty() && userDAO.isPhoneExists(phone)) {
            return false;
        }

        // Mã hóa và validate mật khẩu
        validatePassword(password);
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        // Tạo đối tượng user
        Users user = new Users();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(hashedPassword);
        user.setRole(role);
        user.setPhone(phone);
        user.setCreatedAt(new Date(System.currentTimeMillis()));
        user.setCreatedBy(null);

        // Gọi DAO để lưu vào DB
        return userDAO.registerUserBasic(user);
    }

    // Kiểm tra username/email đã tồn tại
    public boolean isEmailOrUsernameExists(String email, String username) throws SQLException {
        return userDAO.isEmailOrUsernameExists(email, username);
    }

    // Validate phone number: must be exactly 10 digits or null/empty
    private void validatePhoneNumber(String phone) throws IllegalArgumentException {
        if (phone != null && !phone.trim().isEmpty() && !phone.matches("\\d{10}")) {
            throw new IllegalArgumentException("Phone number must be exactly 10 digits.");
        }
    }

    // Xác thực người dùng khi đăng nhập
    public Users authenticateUser(String emailOrUsername, String password) throws SQLException {
        Users user = userDAO.findUserByEmailOrUsername(emailOrUsername);
        if (user == null) {
            return null;
        }
        if (BCrypt.checkpw(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    // Kiểm tra xem user đã hoàn thiện hồ sơ chưa
    public boolean isProfileComplete(Users user) {
        return user.getFullName() != null && !user.getFullName().trim().isEmpty() &&
               user.getDob() != null &&
               user.getGender() != null && !user.getGender().trim().isEmpty() &&
               user.getPhone() != null && !user.getPhone().trim().isEmpty() &&
               user.getAddress() != null && !user.getAddress().trim().isEmpty();
    }

    // Cập nhật thông tin hồ sơ của user
    public void updateUserProfile(Users user) throws SQLException {
        userDAO.updateUserProfile(user);
    }

    // Cập nhật thông tin nhân viên
    public void addEmployee(String emailOrUsername, String fullName, String specialization, 
                           String phone, String dobStr, String gender, String address, int adminId) throws Exception {
        // Tìm người dùng
        Users user = userDAO.findUserByEmailOrUsername(emailOrUsername);
        if (user == null) {
            throw new Exception("Không tìm thấy người dùng với email hoặc username: " + emailOrUsername);
        }

        // Kiểm tra vai trò
        if (!user.getRole().equals("Doctor") && !user.getRole().equals("Nurse") && !user.getRole().equals("Receptionist")) {
            throw new Exception("Người dùng không có vai trò nhân viên: " + user.getRole());
        }

        // Kiểm tra trạng thái
        if (user.getStatus().equals("Active")) {
            throw new Exception("Tài khoản nhân viên đã được kích hoạt!");
        }

        // Kiểm tra số điện thoại
        if (phone != null && !phone.trim().isEmpty() && userDAO.isPhoneExists(phone)) {
            throw new Exception("Số điện thoại đã được sử dụng!");
        }

        // Cập nhật thông tin
        user.setFullName(fullName);
        user.setSpecialization(specialization.isEmpty() ? null : specialization);
        user.setPhone(phone.isEmpty() ? null : phone);
        user.setDob(dobStr.isEmpty() ? null : java.sql.Date.valueOf(dobStr));
        user.setGender(gender.isEmpty() ? null : gender);
        user.setAddress(address.isEmpty() ? null : address);

        // Gọi DAO để cập nhật
        boolean updated = userDAO.updateEmployeeRole(user, adminId);
        if (!updated) {
            throw new Exception("Không thể cập nhật thông tin nhân viên!");
        }
    }

    // Validate email: must end with @gmail.com
    private void validateEmail(String email) throws IllegalArgumentException {
        if (email == null || email.trim().isEmpty() || !email.endsWith("@gmail.com") || email.equals("@gmail.com")) {
            throw new IllegalArgumentException("Email phải có đuôi @gmail.com.");
        }
    }

    // Validate DOB: must not exceed current date
    private void validateDob(Date dob) throws IllegalArgumentException {
        LocalDate currentDate = LocalDate.now(); // Current date: 01:20 PM +07 on Wednesday, May 21, 2025
        LocalDate dobDate = dob.toLocalDate();
        if (dobDate.isAfter(currentDate)) {
            throw new IllegalArgumentException("Năm sinh không được vượt quá thời gian thực.");
        }
    }

    // Validate password: at least 8 chars, 1 uppercase, 1 special char, 1 digit
    private void validatePassword(String password) throws IllegalArgumentException {
        if (password == null || password.length() < 8 ||
            !password.matches("^(?=.*[A-Z])(?=.*[!@#$%^&*])(?=.*\\d).+$")) {
            throw new IllegalArgumentException("Mật khẩu phải có ít nhất 8 ký tự, 1 chữ cái in hoa, 1 ký tự đặc biệt và 1 số.");
        }
    }

    // New method to update password
    public boolean updatePassword(String email, String newPassword) throws SQLException {
        validateEmail(email);
        validatePassword(newPassword);
        String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        return userDAO.updatePassword(email, hashedPassword);
    }
      public Users getUserByID(int userID) throws SQLException {
           return userDAO.getUserByID(userID);
}
}