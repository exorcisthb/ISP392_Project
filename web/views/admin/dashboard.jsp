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
            background-color: #f3f4f6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .search-container {
            max-width: 800px; /* Giữ chiều dài thanh tìm kiếm */
            width: 100%;
            margin: 20px 0;
            position: relative;
        }
        .search-container input {
            width: 100%;
            padding: 10px 40px 10px 12px; /* Padding phải để chừa chỗ cho biểu tượng */
            border: 1px solid #d1d5db;
            border-radius: 6px;
            outline: none;
            transition: border-color 0.3s;
        }
        .search-container input:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.2);
        }
        .search-icon {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 1.2rem;
            color: #6b7280;
            pointer-events: none; /* Ngăn chặn click vào biểu tượng */
        }
        .action-card {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            max-width: 500px;
            width: 100%;
            margin: 0 auto; /* Đảm bảo căn giữa */
        }
        .action-card h3 {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 16px;
            text-align: center;
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
        }
        .btn-green {
            background-color: #10b981;
        }
        .btn-green:hover {
            background-color: #059669;
        }
        .container {
            display: flex;
            flex-direction: column;
            align-items: center; /* Đảm bảo nội dung trong container căn giữa */
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
                    class="w-full p-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500"
                    value="<%= request.getParameter("query") != null ? request.getParameter("query") : "" %>"
                />
                <span class="search-icon">🔍</span>
            </form>
        </div>
        <!-- Header with User Menu -->
        <div class="flex justify-end mb-6 w-full">
            <div class="relative">
                <button id="userMenuBtn" class="flex items-center space-x-2 bg-gray-200 p-2 rounded-full hover:bg-gray-300 focus:outline-none">
                    <span class="text-gray-700">👤</span>
                </button>
                <div id="userMenu" class="absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-lg hidden z-10">
                    <a href="#" class="block px-4 py-2 text-gray-700 hover:bg-gray-100" onclick="viewProfile()">View Profile</a>
                    <a href="#" class="block px-4 py-2 text-gray-700 hover:bg-gray-100" onclick="editProfile()">Edit Profile</a>
                    <a href="${pageContext.request.contextPath}/LogoutServlet" class="block px-4 py-2 text-gray-700 hover:bg-gray-100" onclick="signOut()">Sign Out</a>
                </div>
            </div>
        </div>
        <!-- Action Buttons -->
        <div class="action-card">
            <h3>Dental Clinic Management</h3>
            <a href="ViewPatients.jsp" class="btn-green">View Patients</a>
            <a href="ViewEmployees.jsp" class="btn-green">View Employees</a>
            <a href="ViewServices.jsp" class="btn-green">View Services</a>
            <a href="ViewAppointments.jsp" class="btn-green">View Appointment List</a>
        </div>
    </div>
    <script>
        const userMenuBtn = document.getElementById('userMenuBtn');
        const userMenu = document.getElementById('userMenu');
        userMenuBtn.addEventListener('click', function() {
            userMenu.classList.toggle('hidden');
        });
        function viewProfile() { alert('View Profile!'); }
        function editProfile() { alert('Edit Profile!'); }
       
    </script>
</body>
</html>