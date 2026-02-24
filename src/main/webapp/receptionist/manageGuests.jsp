<%@ page import="com.oceanview.util.DBConnection" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Guests</title>
    <style>
        body { font-family: sans-serif; background-color: #f4f7f6; padding: 20px; }
        .table-container { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); max-width: 900px; margin: auto; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #dc3545; color: white; }
        .btn-delete { background-color: #dc3545; color: white; border: none; padding: 6px 12px; cursor: pointer; border-radius: 3px; text-decoration: none; }
        .btn-delete:hover { background-color: #c82333; }
    </style>
</head>
<body>
<div class="table-container">
    <h2 style="text-align: center;">👥 Guest Directory</h2>

    <% if ("deleted".equals(request.getParameter("msg"))) { %>
    <p style="color: green; text-align: center;">Guest account permanently deleted.</p>
    <% } else if ("hasBooking".equals(request.getParameter("error"))) { %>
    <p style="color: red; text-align: center; font-weight: bold;">Cannot delete! This guest has reservation history attached to their account.</p>
    <% } %>

    <table>
        <tr>
            <th>ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Username</th>
            <th>Phone</th>
            <th>Action</th>
        </tr>
        <%
            try (Connection con = DBConnection.getConnection();
                 Statement st = con.createStatement();
                 ResultSet rs = st.executeQuery("SELECT * FROM users WHERE role = 'GUEST' ORDER BY user_id DESC")) {

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("user_id") %></td>
            <td><%= rs.getString("first_name") %></td>
            <td><%= rs.getString("last_name") %></td>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("phone") %></td>
            <td>
                <a href="../deleteGuest?id=<%= rs.getInt("user_id") %>" class="btn-delete" onclick="return confirm('Are you sure you want to delete this guest?');">🗑️ Delete</a>
            </td>
        </tr>
        <%      }
        } catch (Exception e) { e.printStackTrace(); }
        %>
    </table>
    <br>
    <center><a href="../dashboard/receptionistDashboard.jsp" style="text-decoration: none; color: #dc3545;">⬅ Back to Dashboard</a></center>
</div>
</body>
</html>