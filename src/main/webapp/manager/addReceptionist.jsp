<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hire Receptionist</title>
    <style>
        body { font-family: sans-serif; background-color: #f4f7f6; display: flex; justify-content: center; padding-top: 40px; }
        .form-box { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); width: 400px; text-align: center; }
        input, select { width: 90%; padding: 10px; margin: 10px 0; border: 1px solid #ccc; border-radius: 5px; }
        button { background-color: #343a40; color: white; border: none; padding: 12px; width: 100%; border-radius: 5px; cursor: pointer; font-size: 16px; margin-top: 10px;}
        button:hover { background-color: #ffc107; color: black; font-weight: bold; }
    </style>
</head>
<body>
<div class="form-box">
    <h2>👔 Hire Receptionist</h2>
    <% if ("success".equals(request.getParameter("msg"))) { %>
    <p style="color: green; font-weight: bold;">Receptionist hired successfully!</p>
    <% } %>
    <form action="../addReceptionist" method="post">
        <input type="text" name="firstName" placeholder="First Name" required>
        <input type="text" name="lastName" placeholder="Last Name" required>
        <input type="text" name="email" placeholder="Email Address" required>
        <input type="text" name="phone" placeholder="Phone Number" required>
        <input type="text" name="employeeId" placeholder="Employee ID (e.g., EMP-001)" required>
        <select name="shift" required>
            <option value="Morning">Morning Shift (8AM - 4PM)</option>
            <option value="Evening">Evening Shift (4PM - 12AM)</option>
            <option value="Night">Night Shift (12AM - 8AM)</option>
        </select>
        <input type="text" name="username" placeholder="Create Username" required>
        <input type="password" name="password" placeholder="Create Password" required>
        <button type="submit">Save Employee Account</button>
    </form>
    <br><a href="../dashboard/managerDashboard.jsp" style="text-decoration: none; color: #555;">⬅ Back to Dashboard</a>
</div>
</body>
</html>