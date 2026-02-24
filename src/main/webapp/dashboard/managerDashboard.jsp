<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    if (session.getAttribute("userId") == null || !"MANAGER".equals(session.getAttribute("role"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manager Dashboard</title>
    <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>🌊</text></svg>">
    <style>
        body { font-family: sans-serif; background-color: #eef2f3; margin: 0; }
        .header { background-color: #343a40; color: white; padding: 20px; text-align: center; border-bottom: 4px solid #ffc107; }
        .container { padding: 20px; display: flex; gap: 20px; justify-content: center; flex-wrap: wrap; max-width: 1000px; margin: auto; }
        .card { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); width: 250px; text-align: center; }
        .btn { display: inline-block; padding: 10px 15px; margin-top: 10px; text-decoration: none; color: white; border-radius: 5px; background-color: #343a40; transition: 0.3s; width: 80%; }
        .btn:hover { background-color: #ffc107; color: black; font-weight: bold; }
        .logout { float: right; margin-top: -40px; margin-right: 20px; color: #ffc107; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>
<div class="header">
    <h1>Manager Dashboard - <%= session.getAttribute("username") %></h1>
    <a href="../logout" class="logout">Logout ➜</a>
</div>

<div class="container">
    <div class="card">
        <h3>🏗️ Add Room</h3>
        <p>Expand the hotel with new rooms.</p>
        <a href="../manager/addRoom.jsp" class="btn">Create Room</a>
    </div>

    <div class="card">
        <h3>👔 Hire Staff</h3>
        <p>Create Receptionist accounts.</p>
        <a href="../manager/addReceptionist.jsp" class="btn">Add Receptionist</a>
    </div>

    <div class="card">
        <h3>🛡️ Manage Users</h3>
        <p>View and delete system users.</p>
        <a href="../manager/manageUsers.jsp" class="btn">User Directory</a>
    </div>

    <div class="card">
        <h3>🛏️ Manage Rooms</h3>
        <p>View and update room statuses.</p>
        <a href="../receptionist/updateRoomStatus.jsp" class="btn">Room Status</a>
    </div>

    <div class="card">
        <h3>📈 Billing Reports</h3>
        <p>Search and print any invoice.</p>
        <a href="../manager/managerReport.jsp" class="btn">View Reports</a>
    </div>
</div>
</body>
</html>