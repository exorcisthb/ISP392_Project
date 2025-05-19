<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Receptionist Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">
    <div class="container mx-auto p-6">
        <!-- Header with User Menu -->
        <div class="flex justify-end mb-6">
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

        <!-- Main Dashboard -->
        <h1 class="text-3xl font-bold mb-6 text-center">Receptionist Dashboard</h1>

        <!-- Buttons -->
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <button id="viewBookingListsBtn" class="bg-blue-500 text-white p-3 rounded-lg hover:bg-blue-600 transition duration-200">
                View Booking Lists
            </button>
            <button id="invoiceBtn" class="bg-green-500 text-white p-3 rounded-lg hover:bg-green-600 transition duration-200">
                Invoice
            </button>
        </div>
    </div>

    <!-- JavaScript for interactions -->
    <script>
        // Toggle user menu
        const userMenuBtn = document.getElementById('userMenuBtn');
        const userMenu = document.getElementById('userMenu');
        userMenuBtn.addEventListener('click', function() {
            userMenu.classList.toggle('hidden');
        });

        // Close menu when clicking outside
        document.addEventListener('click', function(event) {
            if (!userMenuBtn.contains(event.target) && !userMenu.contains(event.target)) {
                userMenu.classList.add('hidden');
            }
        });

        // Button functions (placeholder)
        document.getElementById('viewBookingListsBtn').addEventListener('click', function() {
            alert('Chức năng View Booking Lists sẽ được mở. (Chưa triển khai)');
        });

        document.getElementById('invoiceBtn').addEventListener('click', function() {
            alert('Chức năng Invoice sẽ được mở. (Chưa triển khai)');
        });

        // Menu item functions
        function viewProfile() {
            alert('Xem thông tin profile. (Chưa triển khai)');
        }

        function editProfile() {
            alert('Chỉnh sửa profile. (Chưa triển khai)');
        }



    </script>
</body>
</html>