package com.oceanview.servlet;

import com.oceanview.dao.RoomDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/updateRoom")
public class UpdateRoomServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("roomType");
        double price = Double.parseDouble(request.getParameter("price"));

        RoomDAO dao = new RoomDAO();
        boolean success = dao.updateRoomPrice(type, price);

        if (success) {
            response.sendRedirect("dashboard/managerDashboard.jsp?msg=PriceUpdated");
        } else {
            response.sendRedirect("dashboard/managerDashboard.jsp?error=Failed");
        }
    }
}