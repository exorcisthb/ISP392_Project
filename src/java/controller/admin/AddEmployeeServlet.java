/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.service.UserService;

/**
 *
 * @author exorc
 */
public class AddEmployeeServlet extends HttpServlet {
   private UserService userService;
   @Override
    public void init() throws ServletException {
        userService = new UserService();
    }
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddEmployeeServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddEmployeeServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } finally {
            out.close();
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ form
            String emailOrUsername = request.getParameter("emailOrUsername");
            String fullName = request.getParameter("fullName");
            String specialization = request.getParameter("specialization");
            String phone = request.getParameter("phone");
            String dobStr = request.getParameter("dob");
            String gender = request.getParameter("gender");
            String address = request.getParameter("address");
            int adminId = Integer.parseInt(request.getParameter("adminId"));

            // Gọi UserService để cập nhật nhân viên
            userService.addEmployee(emailOrUsername, fullName, specialization, phone, dobStr, gender, address, adminId);

            // Thành công
            request.getSession().setAttribute("message", "Cập nhật thông tin nhân viên thành công!");
            response.sendRedirect("employee_list.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi cập nhật nhân viên: " + e.getMessage());
            request.getRequestDispatcher("add_employee.jsp").forward(request, response);
        }
    }
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
