package controller.common;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.dao.UserDAO;
import model.entity.Users;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet(name = "RegistrationServlet", urlPatterns = {"/RegistrationServlet"})
public class RegistrationServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/common/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (username == null || username.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            role == null || role.trim().isEmpty()) {
            request.setAttribute("error", "Tất cả các trường đều bắt buộc.");
            request.getRequestDispatcher("/views/common/login.jsp").forward(request, response);
            return;
        }

        if (!role.equals("patient") && !role.equals("doctor") && !role.equals("nurse") && !role.equals("receptionist")) {
            request.setAttribute("error", "Vai trò không hợp lệ.");
            request.getRequestDispatcher("/views/common/login.jsp").forward(request, response);
            return;
        }

        try {
            if (userDAO.isEmailOrUsernameExists(email, username)) {
                request.setAttribute("error", "Email hoặc username đã tồn tại.");
                request.getRequestDispatcher("/views/common/login.jsp").forward(request, response);
                return;
            }

            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            Users user = new Users();
            user.setUsername(username);
            user.setEmail(email);
            user.setPassword(hashedPassword);
            user.setRole(role);
            user.setCreatedAt(new Date(System.currentTimeMillis()));

            if (userDAO.registerPendingUser(user)) {
                request.setAttribute("successMessage", "Đăng ký thành công! Vui lòng đăng nhập để hoàn tất thông tin cá nhân.");
                request.getRequestDispatcher("/views/common/login.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại.");
                request.getRequestDispatcher("/views/common/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/views/common/login.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles user registration and stores data in PendingUsers";
    }
}