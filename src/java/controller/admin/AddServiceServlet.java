/*
 * Document   : AddServiceServlet
 * Created on : May 23, 2025
 * Author     : Grok
 */
package controller.admin;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.entity.Services;
import model.service.Services_Service;

@WebServlet(name = "AddServiceServlet", urlPatterns = {"/AddServiceServlet", "/admin/addService"})
public class AddServiceServlet extends HttpServlet {

    private Services_Service servicesService;

    @Override
    public void init() throws ServletException {
        servicesService = new Services_Service();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
    request.setCharacterEncoding("UTF-8");
        // Display the add service form
        request.getRequestDispatcher("/views/admin/AddService.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
    request.setCharacterEncoding("UTF-8");

        // Retrieve form parameters
        String serviceName = request.getParameter("serviceName");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String status = request.getParameter("status");

        // Store form values for redisplay on error
        request.setAttribute("serviceName", serviceName);
        request.setAttribute("description", description);
        request.setAttribute("price", priceStr);
        request.setAttribute("status", status);

        // Validate required fields
        String errorMessage = validateInput(serviceName, priceStr, status);
        if (errorMessage != null) {
            System.out.println("Validation failed: " + errorMessage + " at " + LocalDateTime.now() + " +07");
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("/views/admin/AddService.jsp").forward(request, response);
            return;
        }

        // Convert and validate price
        double price;
        try {
            price = Double.parseDouble(priceStr);
            if (price < 0) {
                throw new NumberFormatException("Price cannot be negative");
            }
        } catch (NumberFormatException e) {
            System.out.println("Invalid price format: " + priceStr + " at " + LocalDateTime.now() + " +07");
            request.setAttribute("error", "Giá dịch vụ không hợp lệ.");
            request.getRequestDispatcher("/views/admin/AddService.jsp").forward(request, response);
            return;
        }

        // Validate status
        status = status.trim();
        if (!status.equalsIgnoreCase("Active") && !status.equalsIgnoreCase("Inactive") && !status.equalsIgnoreCase("Discontinued")) {
            System.out.println("Invalid status value: " + status + " at " + LocalDateTime.now() + " +07");
            request.setAttribute("error", "Trạng thái không hợp lệ. Chỉ chấp nhận 'Active', 'Inactive', hoặc 'Discontinued'.");
            request.getRequestDispatcher("/views/admin/AddService.jsp").forward(request, response);
            return;
        }
        status = status.equalsIgnoreCase("Active") ? "Active" : (status.equalsIgnoreCase("Inactive") ? "Inactive" : "Discontinued");

        try {
            HttpSession session = request.getSession();
            Integer createdBy = (Integer) session.getAttribute("adminId");
            if (createdBy == null) {
                createdBy = 35; // Default to AdminID 1 (ensure this exists in Admins table)
                System.out.println("AdminID not found in session, using default: " + createdBy + " at " + LocalDateTime.now() + " +07");
                // Ensure adminId is set in the session during admin login
            }

            // Create service object
            Services service = new Services();
            service.setServiceName(serviceName);
            service.setDescription(description != null ? description.trim() : "");
            service.setPrice(price);
            service.setStatus(status);

            System.out.println("Attempting to add service: ServiceName=" + serviceName + ", Price=" + price + ", Status=" + status + ", CreatedBy=" + createdBy + " at " + LocalDateTime.now() + " +07");
            servicesService.addService(service, createdBy);
            System.out.println("Service added successfully: ServiceName=" + serviceName + " at " + LocalDateTime.now() + " +07");

            // Set success message and redirect
            session.setAttribute("successMessage", "Thêm dịch vụ thành công!");
            response.sendRedirect(request.getContextPath() + "/ViewServiceServlet");
        } catch (IllegalArgumentException e) {
            System.out.println("Validation error: " + e.getMessage() + " at " + LocalDateTime.now() + " +07");
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/views/admin/AddService.jsp").forward(request, response);
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage() + ", SQLState: " + e.getSQLState() + ", ErrorCode: " + e.getErrorCode() + " at " + LocalDateTime.now() + " +07");
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/AddService.jsp").forward(request, response);
        }
    }

    private String validateInput(String serviceName, String priceStr, String status) {
        if (serviceName == null || serviceName.trim().isEmpty()) {
            return "Vui lòng điền tên dịch vụ.";
        }
        if (priceStr == null || priceStr.trim().isEmpty()) {
            return "Vui lòng điền giá dịch vụ.";
        }
        if (status == null || status.trim().isEmpty()) {
            return "Vui lòng chọn trạng thái.";
        }
        return null;
    }
}