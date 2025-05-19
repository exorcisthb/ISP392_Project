package controller.common;

import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.service.UserService;

@WebServlet(name = "RegistrationServlet", urlPatterns = {"/RegistrationServlet"})
public class RegistrationServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Lưu giá trị tạm để giữ nguyên khi có lỗi
        request.setAttribute("username", username);
        request.setAttribute("password", password);
        request.setAttribute("role", role);

        if (username == null || username.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            role == null || role.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng điền đầy đủ Username, Email, Password và Role.");
            request.getRequestDispatcher("/views/common/login.jsp").forward(request, response);
            return;
        }

        // Validate email
        if (!email.endsWith("@gmail.com") || email.equals("@gmail.com")) {
            request.setAttribute("error", "Gmail sai");
            request.setAttribute("email", ""); // Reset email
            request.getRequestDispatcher("/views/common/login.jsp").forward(request, response);
            return;
        }

        try {
            if (userService.registerUser(username, email, password, role, null)) {
                // Lưu thông báo thành công vào session
                HttpSession session = request.getSession();
                session.setAttribute("successMessage", "Đã đăng ký thành công, vui lòng đăng nhập!");
                response.sendRedirect(request.getContextPath() + "/UserLoginController");
            } else {
                request.setAttribute("error", "Username hoặc Email đã tồn tại.");
                request.setAttribute("email", email); // Giữ email nếu lỗi này
                request.getRequestDispatcher("/views/common/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            if (e.getMessage().contains("Email phải có đuôi @gmail.com.")) {
                request.setAttribute("error", "Gmail sai");
                request.setAttribute("email", ""); // Reset email nếu lỗi định dạng
            } else {
                request.setAttribute("error", "Lỗi khi đăng ký: " + e.getMessage());
                request.setAttribute("email", email); // Giữ email nếu lỗi khác
            }
            request.getRequestDispatcher("/views/common/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/common/login.jsp").forward(request, response);
    }
}