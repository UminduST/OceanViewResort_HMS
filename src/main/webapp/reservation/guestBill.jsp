<%@ page import="com.oceanview.model.Reservation" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("userId") == null) { response.sendRedirect("../login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Guest Invoice</title>
    <style>
        body { font-family: 'Courier New', Courier, monospace; background-color: #eee; padding: 40px; }
        .invoice-box { background: white; max-width: 600px; margin: auto; padding: 30px; border: 1px solid #ddd; box-shadow: 0 0 10px rgba(0,0,0,0.15); }
        .header { text-align: center; border-bottom: 2px solid #333; padding-bottom: 20px; margin-bottom: 20px; }
        .details p { margin: 5px 0; font-size: 16px; }
        .total-section { border-top: 2px solid #333; padding-top: 15px; margin-top: 15px; font-size: 1.4em; font-weight: bold; text-align: right; color: #28a745; }
        .btn-print { background: #007bff; color: white; border: none; padding: 12px 25px; cursor: pointer; display: block; margin: 20px auto; font-size: 16px; border-radius: 5px; }
        .back-link { display: block; text-align: center; color: #555; text-decoration: none; }
        @media print { .btn-print, .back-link { display: none; } body { background: white; padding: 0; } .invoice-box { box-shadow: none; border: none; } }
    </style>
</head>
<body>

<%
    Reservation r = (Reservation) request.getAttribute("reservation");
    Long nights = (Long) request.getAttribute("nights");

    // Safety check just in case someone visits the page without going through the servlet
    if(r == null) { response.sendRedirect("viewMyReservations.jsp"); return; }
%>

<div class="invoice-box">
    <div class="header">
        <h1>🌊 Ocean View Resort</h1>
        <p>OFFICIAL GUEST INVOICE</p>
    </div>

    <div class="details">
        <p><strong>Reservation ID:</strong> #<%= r.getReservationId() %></p>
        <p><strong>Room:</strong> <%= r.getRoomNumber() %> (<%= r.getRoomType() %>)</p>
        <p><strong>Status:</strong> <%= r.getStatus() %></p>
        <hr>
        <p><strong>Check-In Date:</strong> <%= r.getCheckIn() %></p>
        <p><strong>Check-Out Date:</strong> <%= r.getCheckOut() %></p>
        <p><strong>Stay Duration:</strong> <%= nights %> Nights</p>
    </div>

    <div class="total-section">
        Total Amount: $<%= r.getTotalAmount() %>
    </div>
</div>

<button onclick="window.print()" class="btn-print">🖨 Print Invoice</button>
<a href="viewMyReservations.jsp" class="back-link">⬅ Back to My Bookings</a>

</body>
</html>