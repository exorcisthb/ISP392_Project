package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.entity.Users;
import model.service.UserService;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "EditEmployeeServlet", urlPatterns = {"/EditEmployeeServlet"})
public class EditEmployeeServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userIDParam = request.getParameter("id");
        if (userIDParam != null && !userIDParam.isEmpty()) {
            try {
                int userID = Integer.parseInt(userIDParam);
                Users employee = userService.getEmployeeByID(userID);
                if (employee != null) {
                    request.setAttribute("employee", employee);
                    request.getRequestDispatcher("/views/admin/editDoctor.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Không tìm thấy nhân viên để chỉnh sửa.");
                    request.getRequestDispatcher("/views/admin/editDoctor.jsp").forward(request, response);
                }
            } catch (NumberFormatException | SQLException e) {
                request.setAttribute("error", "Lỗi khi tải thông tin nhân viên: " + e.getMessage());
                request.getRequestDispatcher("/views/admin/editDoctor.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "ID không hợp lệ.");
            request.getRequestDispatcher("/views/admin/editDoctor.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userID = Integer.parseInt(request.getParameter("userID"));
        String fullName = request.getParameter("fullName");
        String gender = request.getParameter("gender");
        String specialization = request.getParameter("specialization");
        String dobStr = request.getParameter("dob");

        java.sql.Date dob = java.sql.Date.valueOf(dobStr);

        Users employee = new Users();
        employee.setUserID(userID);
        employee.setFullName(fullName);
        employee.setGender(gender);
        employee.setSpecialization(specialization);
        employee.setDob(dob);
        employee.setStatus("Active"); // Set status to "Active" by default

        try {
            boolean updated = userService.UpdateEmployee(employee);
            if (updated) {
                System.out.println("Employee updated successfully: " + employee.getUserID() + ", Name: " + employee.getFullName());
                response.sendRedirect(request.getContextPath() + "/ViewEmployeeServlet");
            } else {
                System.out.println("Employee update failed for ID: " + employee.getUserID());
                request.setAttribute("error", "Không thể cập nhật thông tin nhân viên.");
                request.getRequestDispatcher("/views/admin/editDoctor.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            System.out.println("SQLException during employee update: " + e.getMessage());
            request.setAttribute("error", "Lỗi khi cập nhật thông tin nhân viên: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/editDoctor.jsp").forward(request, response);
        }
    }
}