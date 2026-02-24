package com.oceanview.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Fetch the current session
        HttpSession session = request.getSession(false); // false means "don't create a new one if none exists"

        // 2. Destroy it
        if (session != null) {
            session.invalidate();
        }

        // 3. Redirect to Login Page
        response.sendRedirect("login.jsp");
    }
}