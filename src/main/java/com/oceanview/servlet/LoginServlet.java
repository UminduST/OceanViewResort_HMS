// Updated login logic for role-based redirection
package com.oceanview.servlet;

import com.oceanview.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        // We check the real database now!
        String sql = "SELECT user_id, first_name, role FROM users WHERE username = ? AND password = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, user);
            pst.setString(2, pass);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                // Get data from database
                int userId = rs.getInt("user_id");
                String dbRole = rs.getString("role");
                String firstName = rs.getString("first_name");

                // Start Session
                HttpSession session = request.getSession();
                session.setAttribute("username", firstName);
                session.setAttribute("role", dbRole);
                session.setAttribute("userId", userId);

                // Redirect based on exact database role
                if ("GUEST".equals(dbRole)) {
                    response.sendRedirect("dashboard/guestDashboard.jsp");
                } else if ("RECEPTIONIST".equals(dbRole)) {
                    response.sendRedirect("dashboard/receptionistDashboard.jsp");
                } else if ("MANAGER".equals(dbRole)) {
                    response.sendRedirect("dashboard/managerDashboard.jsp");
                }
            } else {
                // Invalid credentials
                response.sendRedirect("login.jsp?error=true");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=db");
        }
    }
}