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

@WebServlet("/addReceptionist")
public class AddReceptionistServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fName = request.getParameter("firstName");
        String lName = request.getParameter("lastName");
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String empId = request.getParameter("employeeId");
        String shift = request.getParameter("shift");

        String sql = "INSERT INTO users (first_name, last_name, username, password, email, phone, employee_id, shift, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'RECEPTIONIST')";

        try (Connection con = DBConnection.getConnection(); PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setString(1, fName);
            pst.setString(2, lName);
            pst.setString(3, user);
            pst.setString(4, pass);
            pst.setString(5, email);
            pst.setString(6, phone);
            pst.setString(7, empId);
            pst.setString(8, shift);
            pst.executeUpdate();
            response.sendRedirect("manager/addReceptionist.jsp?msg=success");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manager/addReceptionist.jsp?error=true");
        }
    }
}