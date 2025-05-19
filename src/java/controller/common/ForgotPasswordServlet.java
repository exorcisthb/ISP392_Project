package controller.common;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.*;

@WebServlet("/forgotPassword")
public class ForgotPasswordServlet extends HttpServlet {

    // ⚠️ Tạm thời dùng dữ liệu giả thay thế database
    private static final Set<String> validEmails = new HashSet<>(Arrays.asList(
        "user@example.com", "admin@gmail.com"
    ));

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        if (validEmails.contains(email)) {
            // Gửi mã xác minh hoặc mã hóa ID người dùng
            HttpSession session = request.getSession();
            session.setAttribute("resetEmail", email);

            // Chuyển hướng đến trang đổi mật khẩu
            response.sendRedirect(request.getContextPath() + "/views/common/reset_password.jsp");
        } else {
            // Email không đúng, quay lại trang quên mật khẩu
            request.setAttribute("error", "Email không tồn tại trong hệ thống.");
            request.getRequestDispatcher("/views/common/forgot_password.jsp").forward(request, response);
        }
    }
}
