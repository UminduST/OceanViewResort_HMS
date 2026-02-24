<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Guest Help Center</title>
  <style>
    body { font-family: sans-serif; background-color: #f4f7f6; padding: 30px; }
    .help-box { background: white; padding: 30px; border-radius: 10px; max-width: 600px; margin: auto; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
    h3 { color: #007bff; }
    .back-btn { display: inline-block; margin-top: 20px; padding: 10px 20px; background: #6c757d; color: white; text-decoration: none; border-radius: 5px; }
  </style>
</head>
<body>
<div class="help-box">
  <h2>❓ How to use the Guest System</h2>

  <h3>1. How to book a room?</h3>
  <p>Go to your dashboard and click <b>"New Booking"</b>. Select an available room from the dropdown list, choose your check-in and check-out dates, and click Confirm.</p>

  <h3>2. How to view my reservations?</h3>
  <p>Click <b>"View Details"</b> under the 'My Bookings' card on your dashboard. This will show all your past and current reservations.</p>

  <h3>3. How to print my bill?</h3>
  <p>Go to your reservations list (see step 2). Click the green <b>"📄 Bill"</b> button next to the reservation. Once the invoice loads, click the blue "Print Invoice" button.</p>

  <a href="dashboard/guestDashboard.jsp" class="back-btn">⬅ Back to Dashboard</a>
</div>
</body>
</html>