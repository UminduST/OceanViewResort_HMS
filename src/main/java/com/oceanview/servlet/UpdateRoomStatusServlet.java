package com.oceanview.servlet;

import com.oceanview.dao.RoomDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/updateRoomStatus")
public class UpdateRoomStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        String status = request.getParameter("status");

        RoomDAO dao = new RoomDAO();
        dao.updateRoomStatus(roomId, status); // We already built this method in Step 3!

        response.sendRedirect("receptionist/updateRoomStatus.jsp?msg=updated");
    }
}