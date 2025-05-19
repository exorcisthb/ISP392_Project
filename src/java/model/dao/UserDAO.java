package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.entity.Users;

/**
 *
 * @author exorc
 */
public class UserDAO {

    private final DBContext dbContext;

    public UserDAO() {
        this.dbContext = DBContext.getInstance();
    }

    // Kiểm tra email hoặc username đã tồn tại chưa (ở cả Users và PendingUsers)
    public boolean isEmailOrUsernameExists(String email, String username) throws SQLException {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ? OR username = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    return true;
                }
            }
        }

        sql = "SELECT COUNT(*) FROM users WHERE email = ? OR username = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    // Thêm người dùng mới vào bảng PendingUsers
    public boolean registerPendingUser(Users user) throws SQLException {
        String sql = "INSERT INTO users (username, email, password, role, createdAt) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getRole());
            stmt.setDate(5, user.getCreatedAt());
            return stmt.executeUpdate() > 0;
        }
    }

    // Tìm người dùng trong PendingUsers dựa trên email/username
    public Users findPendingUserByEmailOrUsername(String emailOrUsername) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ? OR username = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, emailOrUsername);
            stmt.setString(2, emailOrUsername);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Users user = new Users();
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                    user.setCreatedAt(rs.getDate("createdAt"));
                    return user;
                }
            }
        }
        return null;
    }

    // Xóa người dùng khỏi PendingUsers
    public boolean deletePendingUser(String username) throws SQLException {
        String sql = "DELETE FROM users WHERE username = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            return stmt.executeUpdate() > 0;
        }
    }

    // Thêm người dùng mới vào bảng users và trả về userID (from original code)
    public int registerUser(Users user) throws SQLException {
        String sql = "INSERT INTO users (username, password, email, fullName, dob, gender, phone, address, medicalHistory, specialization, role, status, createdBy, createdAt, updatedAt) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getFullName());
            stmt.setDate(5, user.getDob());
            stmt.setString(6, user.getGender());
            stmt.setString(7, user.getPhone());
            stmt.setString(8, user.getAddress());
            stmt.setString(9, user.getMedicalHistory());
            stmt.setString(10, user.getSpecialization());
            stmt.setString(11, user.getRole());
            stmt.setString(12, user.getStatus());
            stmt.setInt(13, user.getCreatedBy());
            stmt.setDate(14, user.getCreatedAt());
            stmt.setDate(15, user.getUpdatedAt());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); // Trả về userID vừa tạo
                    }
                }
            }
        }
        return -1; // Trả về -1 nếu không tạo được
    }

    // Tìm người dùng trong Users dựa trên email/username (from original code)
    public Users findUserByEmailOrUsername(String emailOrUsername) throws SQLException {
        String sql = "SELECT * FROM users WHERE email = ? OR username = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, emailOrUsername);
            stmt.setString(2, emailOrUsername);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Users user = new Users();
                    user.setUserID(rs.getInt("userID"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setEmail(rs.getString("email"));
                    user.setFullName(rs.getString("fullName"));
                    user.setDob(rs.getDate("dob"));
                    user.setGender(rs.getString("gender"));
                    user.setPhone(rs.getString("phone"));
                    user.setAddress(rs.getString("address"));
                    user.setMedicalHistory(rs.getString("medicalHistory"));
                    user.setSpecialization(rs.getString("specialization"));
                    user.setRole(rs.getString("role"));
                    user.setStatus(rs.getString("status"));
                    user.setCreatedBy(rs.getInt("createdBy"));
                    user.setCreatedAt(rs.getDate("createdAt"));
                    user.setUpdatedAt(rs.getDate("updatedAt"));
                    return user;
                }
            }
        }
        return null;
    }    
    // UserDAO.java (bổ sung)
public boolean updatePassword(String email, String newPassword) {
    String sql = "UPDATE Users SET password = ? WHERE email = ?";
    try (Connection conn = dbContext.getConnection(); 
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, newPassword);
        ps.setString(2, email);
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}

public boolean checkOldPassword(int userId, String oldPassword) {
    String sql = "SELECT * FROM Users WHERE id = ? AND password = ?";
    try (Connection conn = dbContext.getConnection(); 
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, userId);
        ps.setString(2, oldPassword);
        ResultSet rs = ps.executeQuery();
        return rs.next();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}

}