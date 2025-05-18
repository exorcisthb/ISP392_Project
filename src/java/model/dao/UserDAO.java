package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.entity.Users;

public class UserDAO {

    private final DBContext dbContext;

    public UserDAO() {
        this.dbContext = DBContext.getInstance();
    }

    // Kiểm tra email hoặc username đã tồn tại chưa trong bảng Users
    public boolean isEmailOrUsernameExists(String email, String username) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ? OR username = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, username);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    // Kiểm tra số điện thoại đã tồn tại chưa (chỉ kiểm tra nếu phone không null)
    public boolean isPhoneExists(String phone) throws SQLException {
        if (phone == null || phone.trim().isEmpty()) return false;
        String sql = "SELECT COUNT(*) FROM Users WHERE phone = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, phone);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    // Đăng ký tài khoản cơ bản vào bảng Users
    public boolean registerUserBasic(Users user) throws SQLException {
        String sql = "INSERT INTO Users (username, email, password, role, phone, createdBy, createdAt) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getRole());
            stmt.setString(5, user.getPhone());
            stmt.setObject(6, user.getCreatedBy(), java.sql.Types.INTEGER);
            stmt.setDate(7, user.getCreatedAt());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("SQL Error in registerUserBasic: " + e.getMessage());
            throw e;
        }
    }

    // Tìm người dùng trong Users dựa trên email hoặc username
    public Users findUserByEmailOrUsername(String emailOrUsername) throws SQLException {
        String sql = "SELECT * FROM Users WHERE email = ? OR username = ?";
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

    // Cập nhật thông tin hồ sơ của user
    public void updateUserProfile(Users user) throws SQLException {
        String sql = "UPDATE Users SET fullName = ?, dob = ?, gender = ?, phone = ?, address = ?, " +
                     "medicalHistory = ?, specialization = ?, updatedAt = GETDATE() " +
                     "WHERE userID = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getFullName());
            stmt.setDate(2, user.getDob());
            stmt.setString(3, user.getGender());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getAddress());
            stmt.setString(6, user.getMedicalHistory());
            stmt.setString(7, user.getSpecialization());
            stmt.setInt(8, user.getUserID());
            stmt.executeUpdate();
        }
    }

    // Cập nhật thông tin nhân viên và trạng thái
    public boolean updateEmployeeRole(Users user, int adminId) throws SQLException {
        String sql = "UPDATE Users SET status = 'Active', fullName = ?, specialization = ?, phone = ?, dob = ?, " +
                     "gender = ?, address = ?, createdBy = ?, updatedAt = GETDATE() WHERE userID = ?";
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getSpecialization());
            stmt.setString(3, user.getPhone());
            stmt.setDate(4, user.getDob());
            stmt.setString(5, user.getGender());
            stmt.setString(6, user.getAddress());
            stmt.setObject(7, adminId, java.sql.Types.INTEGER);
            stmt.setInt(8, user.getUserID());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("SQL Error in updateEmployeeRole: " + e.getMessage());
            throw e;
        }
    }
}