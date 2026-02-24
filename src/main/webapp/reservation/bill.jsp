<%@ page import="com.oceanview.model.Reservation" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Guest Invoice</title>
    <style>
        body { font-family: 'Courier New', Courier, monospace; background-color: #eee; padding: 40px; }
        .invoice-box { background: white; max-width: 600px; margin: auto; padding: 30px; border: 1px solid #ddd; box-shadow: 0 0 10px rgba(0,0,0,0.15); }
        .header { text-align: center; border-bottom: 2px solid #333; padding-bottom: 20px; margin-bottom: 20px; }
        .details { margin-bottom: 20px; }
        .details p { margin: 5px 0; }
        .total-section { border-top: 2px solid #333; padding-top: 10px; font-size: 1.2em; font-weight: bold; text-align: right; }
        .print-btn { background: #007bff; color: white; border: none; padding: 10px 20px; cursor: pointer; display: block; margin: 20px auto; width: 100px; text-align: center; text-decoration: none; }
        @media print { .print-btn { display: none; } body { background: white; } }
    </style>
</head>
<body>

<%
    Reservation r = (Reservation) request.getAttribute("reservation");
    Long nights = (Long) request.getAttribute("nights");
    Double price = (Double) request.getAttribute("pricePerNight");
    Double total = (Double) request.getAttribute("totalBill");
%>

<div class="invoice-box">
    <div class="header">
        <h1>🌊 Ocean View Resort</h1>
        <p>OFFICIAL INVOICE</p>
    </div>

    <div class="details">
        <p><strong>Bill To:</strong> <%= r.getGuestName() %></p>
        <p><strong>Reservation ID:</strong> #<%= r.getReservationId() %></p>
        <p><strong>Room Type:</strong> <%= r.getRoomType() %></p>
        <hr>
        <p>Check-In: <%= r.getCheckIn() %></p>
        <p>Check-Out: <%= r.getCheckOut() %></p>
        <p>Stay Duration: <%= nights %> Nights</p>
        <p>Rate per Night: $<%= price %></p>
    </div>

    <div class="total-section">
        Total Amount: $<%= total %>
    </div>
</div>

<button onclick="window.print()" class="print-btn">🖨 Print</button>
<br>
<center><a href="../dashboard/receptionistDashboard.jsp">Back to Dashboard</a></center>

</body>
</html>