<%@ page import="com.oceanview.util.DBConnection" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Manage All Users</title>
  <style>
    body { font-family: sans-serif; background-color: #f4f7f6; padding: 20px; }
    .table-container { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); max-width: 900px; margin: auto; }
    table { width: 100%; border-collapse: collapse; margin-top: 15px; }
    th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
    th { background-color: #343a40; color: white; }
    .btn-delete { background-color: #dc3545; color: white; border: none; padding: 6px 12px; cursor: pointer; border-radius: 3px; text-decoration: none; }
    .btn-delete:hover { background-color: #c82333; }
    .badge-guest { background-color: #007bff; color: white; padding: 4px 8px; border-radius: 10px; font-size: 12px; }
    .badge-staff { background-color: #6f42c1; color: white; padding: 4px 8px; border-radius: 10px; font-size: 12px; }
  </style>
</head>
<body>
<div class="table-container">
  <h2 style="text-align: center;">🛡️ User Directory</h2>

  <% if ("deleted".equals(request.getParameter("msg"))) { %>
  <p style="color: green; text-align: center;">User permanently removed.</p>
  <% } else if ("hasBooking".equals(request.getParameter("error"))) { %>
  <p style="color: red; text-align: center; font-weight: bold;">Cannot delete! User is tied to financial/booking records.</p>
  <% } %>

  <table>
    <tr>
      <th>ID</th>
      <th>Name</th>
      <th>Username</th>
      <th>Role</th>
      <th>Employee Info</th>
      <th>Action</th>
    </tr>
    <%
      try (Connection con = DBConnection.getConnection();
           Statement st = con.createStatement();
           // This query deliberately excludes Managers!
           ResultSet rs = st.executeQuery("SELECT * FROM users WHERE role != 'MANAGER' ORDER BY role ASC")) {

        while (rs.next()) {
          String role = rs.getString("role");
    %>
    <tr>
      <td><%= rs.getInt("user_id") %></td>
      <td><%= rs.getString("first_name") %> <%= rs.getString("last_name") %></td>
      <td><%= rs.getString("username") %></td>
      <td>
        <span class="<%= role.equals("GUEST") ? "badge-guest" : "badge-staff" %>"><%= role %></span>
      </td>
      <td><%= role.equals("RECEPTIONIST") ? rs.getString("employee_id") + " (" + rs.getString("shift") + ")" : "N/A" %></td>
      <td>
        <a href="../deleteUser?id=<%= rs.getInt("user_id") %>" class="btn-delete" onclick="return confirm('WARNING: Are you sure you want to delete this account?');">🗑️ Delete</a>
      </td>
    </tr>
    <%      }
    } catch (Exception e) { e.printStackTrace(); }
    %>
  </table>
  <br>
  <center><a href="../dashboard/managerDashboard.jsp" style="text-decoration: none; color: #555;">⬅ Back to Dashboard</a></center>
</div>
</body>
</html>