package controller.common;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.service.UserService;

/**
 *
 * @author ADMIN
 */
@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        int userId = (int) request.getSession().getAttribute("userId");
        String oldPass = request.getParameter("oldPassword");
        String newPass = request.getParameter("newPassword");
        UserService service = new UserService();
        boolean success = service.changePassword(userId, oldPass, newPass);
        if (success) {
            request.setAttribute("message", "Password changed successfully.");
        } else {
            request.setAttribute("message", "Old password incorrect.");
        }
        request.getRequestDispatcher("views/changePassword.jsp").forward(request, response);
    }
}
