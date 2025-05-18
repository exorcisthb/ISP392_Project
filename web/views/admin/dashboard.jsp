
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Healthcare Dashboard</title>
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
            max-width: 500px;
            width: 100%;
            margin: 20px 0;
        }
        .action-card {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .action-card h3 {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 16px;
        }
        .action-card button, .action-card a {
            display: block;
            width: 100%;
            padding: 10px;
            margin-bottom: 8px;
            border-radius: 4px;
            text-align: center;
            color: white;
            text-decoration: none;
        }
        .btn-blue { background-color: #3b82f6; }
        .btn-blue:hover { background-color: #2563eb; }
        .btn-yellow { background-color: #f59e0b; }
        .btn-yellow:hover { background-color: #d97706; }
        .btn-green { background-color: #10b981; }
        .btn-green:hover { background-color: #059669; }
        .btn-red { background-color: #ef4444; }
        .btn-red:hover { background-color: #dc2626; }
    </style>
</head>
<body>
    <div class="container mx-auto p-4">
        <!-- Search Bar -->
        <div class="search-container">
            <form action="dashboard.jsp" method="GET">
                <input
                    type="text"
                    name="query"
                    placeholder="Search admins, patients, services, employees..."
                    class="w-full p-2 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500"
                    value="<%= request.getParameter("query") != null ? request.getParameter("query") : "" %>"
                />
            </form>
        </div>

        <!-- Search Results -->
        <%
            String query = request.getParameter("query");
            if (query != null && !query.trim().isEmpty()) {
                // Mock data
                List<Map<String, String>> results = new ArrayList<>();
                
                // Mock admins
                Map<String, String> admin1 = new HashMap<>();
                admin1.put("type", "Admin");
                admin1.put("name", "John Doe");
                admin1.put("email", "john@example.com");
                Map<String, String> admin2 = new HashMap<>();
                admin2.put("type", "Admin");
                admin2.put("name", "Jane Smith");
                admin2.put("email", "jane@example.com");

                // Mock patients
                Map<String, String> patient1 = new HashMap<>();
                patient1.put("type", "Patient");
                patient1.put("name", "Alice Brown");
                patient1.put("medicalId", "P001");
                Map<String, String> patient2 = new HashMap<>();
                patient2.put("type", "Patient");
                patient2.put("name", "Bob Wilson");
                patient2.put("medicalId", "P002");

                // Mock services
                Map<String, String> service1 = new HashMap<>();
                service1.put("type", "Service");
                service1.put("name", "General Checkup");
                service1.put("price", "50");
                Map<String, String> service2 = new HashMap<>();
                service2.put("type", "Service");
                service2.put("name", "X-Ray");
                service2.put("price", "100");

                // Mock employees
                Map<String, String> employee1 = new HashMap<>();
                employee1.put("type", "Employee");
                employee1.put("name", "Dr. Emily Davis");
                employee1.put("role", "Doctor");
                Map<String, String> employee2 = new HashMap<>();
                employee2.put("type", "Employee");
                employee2.put("name", "Nurse Tom Clark");
                employee2.put("role", "Nurse");

                // Mock search logic
                List<Map<String, String>> allData = Arrays.asList(
                    admin1, admin2, patient1, patient2, service1, service2, employee1, employee2
                );
                for (Map<String, String> item : allData) {
                    if (item.get("name").toLowerCase().contains(query.toLowerCase()) ||
                        (item.get("email") != null && item.get("email").toLowerCase().contains(query.toLowerCase())) ||
                        (item.get("medicalId") != null && item.get("medicalId").toLowerCase().contains(query.toLowerCase())) ||
                        (item.get("role") != null && item.get("role").toLowerCase().contains(query.toLowerCase()))) {
                        results.add(item);
                    }
                }
        %>
        <div class="mb-6 bg-white p-4 rounded-lg shadow">
            <h2 class="text-lg font-semibold mb-2">Search Results</h2>
            <ul class="space-y-2">
                <% for (Map<String, String> result : results) { %>
                    <li class="border-b py-2">
                        <span class="font-medium"><%= result.get("type") %></span>: <%= result.get("name") %>
                        <% if (result.get("email") != null) { %> (<%= result.get("email") %>)<% } %>
                        <% if (result.get("medicalId") != null) { %> (<%= result.get("medicalId") %>)<% } %>
                        <% if (result.get("price") != null) { %> ($<%= result.get("price") %>)<% } %>
                        <% if (result.get("role") != null) { %> (<%= result.get("role") %>)<% } %>
                    </li>
                <% } %>
            </ul>
        </div>
        <% } %>

        <!-- Action Buttons -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            <!-- Admin Actions -->
            <div class="action-card">
                <h3>Admin Actions</h3>
                <a href="addAdmin.jsp" class="btn-blue">Add Admin</a>
                <a href="editAdmin.jsp" class="btn-yellow">Edit Admin</a>
                <a href="viewAdmin.jsp" class="btn-green">View Admin Profile</a>
            </div>

            <!-- Patient Actions -->
            <div class="action-card">
                <h3>Patient Actions</h3>
                <a href="addPatient.jsp" class="btn-blue">Add Patient</a>
                <a href="editPatient.jsp" class="btn-yellow">Edit Patient</a>
                <a href="viewPatient.jsp" class="btn-green">View Patient Detail</a>
            </div>

            <!-- Service Actions -->
            <div class="action-card">
                <h3>Service Actions</h3>
                <a href="addService.jsp" class="btn-blue">Add Service</a>
                <a href="updateService.jsp" class="btn-yellow">Update Service</a>
                <button onclick="alert('Delete Service clicked')" class="btn-red">Delete Service</button>
            </div>

            <!-- Employee Actions -->
            <div class="action-card">
                <h3>Employee Actions</h3>
                <a href="addEmployee.jsp" class="btn-blue">Add Employee</a>
                <a href="updateEmployee.jsp" class="btn-yellow">Update Employee</a>
                <button onclick="alert('Delete Employee clicked')" class="btn-red">Delete Employee</button>
            </div>
        </div>
    </div>

    <script>
        // Minimal JS for demo alerts (replace with JSP redirects if needed)
        function triggerAlert(action) {
            alert(action + ' clicked');
        }
    </script>
</body>
</html>
