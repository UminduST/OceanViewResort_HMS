package com.oceanview.servlet;

import com.oceanview.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fName = request.getParameter("firstName");
        String lName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        String sql = "INSERT INTO users (first_name, last_name, email, phone, username, password, role) VALUES (?, ?, ?, ?, ?, ?, 'GUEST')";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, fName);
            pst.setString(2, lName);
            pst.setString(3, email);
            pst.setString(4, phone);
            pst.setString(5, user);
            pst.setString(6, pass); // We will add hashing later for ultimate security

            int rows = pst.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("login.jsp?msg=registered");
            } else {
                response.sendRedirect("guestRegister.jsp?msg=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("guestRegister.jsp?msg=error");
        }
    }
}