package model.service;

import java.sql.Date;
import java.sql.SQLException;
import model.dao.UserDAO;
import model.entity.Users;
import org.mindrot.jbcrypt.BCrypt;

public class UserService {

    private final UserDAO userDAO;

    public UserService() {
        this.userDAO = new UserDAO();
    }

    // Xác thực người dùng
    public Users authenticateUser(String emailOrUsername, String password) throws SQLException {
        Users user = userDAO.findUserByEmailOrUsername(emailOrUsername);
        if (user != null && BCrypt.checkpw(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    // Đăng ký người dùng mới
    public boolean registerUser(Users user) throws SQLException {
        if (userDAO.isEmailOrUsernameExists(user.getEmail(), user.getUsername())) {
            return false;
        }
        user.setPassword(BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()));
        user.setStatus("active");
        user.setCreatedBy(1);
        user.setCreatedAt(new Date(System.currentTimeMillis()));
        user.setUpdatedAt(new Date(System.currentTimeMillis()));
        return userDAO.registerUser(user) > 0;
    }
}