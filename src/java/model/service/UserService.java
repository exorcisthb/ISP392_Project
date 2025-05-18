package model.service;

import java.sql.SQLException;
import java.sql.Date;
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

        // Mã hóa mật khẩu
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        // Tạo đối tượng user
        Users user = new Users();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(hashedPassword);
        user.setRole(role);
        user.setPhone(phone);
        user.setCreatedAt(new Date(System.currentTimeMillis()));
        user.setCreatedBy(null); // Dòng 38 - Đã sửa trong Users.java nên không còn lỗi

        // Gọi DAO để lưu vào DB
        return userDAO.registerUserBasic(user);
    }

    // Kiểm tra username/email đã tồn tại
    public boolean isEmailOrUsernameExists(String email, String username) throws SQLException {
        return userDAO.isEmailOrUsernameExists(email, username);
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
}