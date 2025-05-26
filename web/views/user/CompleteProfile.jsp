<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complete Profile</title>
    <style>
        body {
            background: url('https://via.placeholder.com/1500x1000.png?text=Background') no-repeat center center fixed;
            background-size: cover;
            font-family: Arial, sans-serif;
            color: white;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .container {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .form-box {
            width: 100%;
            max-width: 400px;
            text-align: center;
        }
        .form-box h2 {
            font-size: 2rem;
            margin-bottom: 20px;
        }
        .form-box input, .form-box select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: none;
            border-radius: 25px;
            background: rgba(255, 255, 255, 0.8);
        }
        .form-box button {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 25px;
            background: #d1d5db;
            cursor: pointer;
        }
        .form-box button:hover {
            background: #b1b5b9;
        }
        .error {
            color: red;
            background: white;
            padding: 10px;
            border-radius: 5px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-box">
            <h2>Complete Your Profile</h2>
            <form action="${pageContext.request.contextPath}/CompleteProfileController" method="POST">
                <input type="text" name="fullName" placeholder="Full Name" value="${requestScope.fullName}">
                <input type="date" name="dob" value="${requestScope.dob}" required>
                <select name="gender" required>
                    <option value="" disabled ${requestScope.gender == null ? 'selected' : ''}>Gender</option>
                    <option value="Nam" ${requestScope.gender == 'Nam' ? 'selected' : ''}>Nam</option>
                    <option value="Nữ" ${requestScope.gender == 'Nữ' ? 'selected' : ''}>Nữ</option>
                    <option value="Khác" ${requestScope.gender == 'Khác' ? 'selected' : ''}>Khác</option>
                </select>
                <input type="text" name="phone" placeholder="Phone" value="${requestScope.phone}" required>
                <input type="text" name="address" placeholder="Address" value="${requestScope.address}">
                <c:if test="${sessionScope.user.role == 'doctor' || sessionScope.user.role == 'nurse'}">
                    <input type="text" name="specialization" placeholder="Specialization" value="${requestScope.specialization}" required>
                </c:if>
                <c:if test="${sessionScope.user.role == 'patient'}">
                    <input type="text" name="medicalHistory" placeholder="Medical History" value="${requestScope.medicalHistory}">
                </c:if>
                <button type="submit">Submit</button>
            </form>

            <c:if test="${not empty requestScope.error}">
                <div class="error">${requestScope.error}</div>
            </c:if>
        </div>
    </div>
</body>
</html>