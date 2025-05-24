<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bảng Điều Khiển Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            background: linear-gradient(135deg, #d1fae5, #a7f3d0);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .search-container {
            max-width: 800px;
            width: 100%;
            margin: 20px 0;
            position: relative;
        }
        .search-container input {
            width: 100%;
            padding: 10px 40px 10px 12px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            outline: none;
            transition: border-color 0.3s;
            background-color: #ffffff;
        }
        .search-container input:focus {
            border-color: #10b981;
            box-shadow: 0 0 0 2px rgba(16, 185, 129, 0.2);
        }
        .search-icon {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 1.2rem;
            color: #6b7280;
            pointer-events: none;
        }
        .action-card {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 100%;
            margin: 0 auto;
            border: 2px solid #10b981; /* Added green border */
        }
        .action-card h3 {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 16px;
            text-align: center;
            color: #2c3e50;
        }
        .action-card a {
            display: block;
            width: 100%;
            padding: 10px;
            margin-bottom: 8px;
            border-radius: 4px;
            text-align: center;
            color: white;
            text-decoration: none;
            background-color: #10b981;
            transition: background-color 0.3s ease;
        }
        .action-card a:hover {
            background-color: #059669;
        }
        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .user-menu-btn {
            background-color: #10b981;
            color: white;
            padding: 8px 16px;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }
        .user-menu-btn:hover {
            background-color: #059669;
        }
        .user-menu {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .user-menu a {
            color: #2c3e50;
            padding: 10px 16px;
            display: block;
            transition: background-color 0.3s ease;
        }
        .user-menu a:hover {
            background-color: #d1fae5;
        }
    </style>
</head>
<body>
    <div class="container mx-auto p-4">
        <!-- Search Bar -->
        <div class="search-container">
            <form action="admin_dashboard.jsp" method="GET">
                <input
                    type="text"
                    name="query"
                    placeholder="Search for staff, services, patients..."
                    class="w-full p-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-green-500"
                    value="<%= request.getParameter("query") != null ? request.getParameter("query") : "" %>"
                />
                <span class="search-icon">🔍</span>
            </form>
        </div>
        <!-- Header with User Menu -->
        <div class="flex justify-end mb-6 w-full">
            <div class="relative">
                <button id="userMenuBtn" class="user-menu-btn flex items-center space-x-2">
                    <span>👤</span>
                </button>
                <div id="userMenu" class="user-menu absolute right-0 mt-2 w-48 hidden z-10">
                    <a href="${pageContext.request.contextPath}/AdminProfileController" class="block">View Profile</a>
                    <a href="${pageContext.request.contextPath}/EditProfileAdminController" class="block">Edit Profile</a>
                    <a href="${pageContext.request.contextPath}/LogoutServlet" class="block">Sign Out</a>
                </div>
            </div>
        </div>
        <!-- Action Buttons -->
        <div class="action-card">
            <h3>Dental Clinic Management</h3>
            <a href="${pageContext.request.contextPath}/ViewPatientServlet" class="btn-green">View Patients</a>
            <a href="${pageContext.request.contextPath}/ViewEmployeeServlet" class="btn-green">View Employees</a>
            <a href="${pageContext.request.contextPath}/ViewServiceServlet" class="btn-green">View Services</a>
            <a href="ViewAppointments.jsp" class="btn-green">View Appointment List</a>
        </div>
    </div>
    <script>
        const userMenuBtn = document.getElementById('userMenuBtn');
        const userMenu = document.getElementById('userMenu');
        userMenuBtn.addEventListener('click', function() {
            userMenu.classList.toggle('hidden');
        });
    </script>
</body>
</html>