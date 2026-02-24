<%-- Added Guest Registration page with validation --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Ocean View Resort - Guest Registration</title>
  <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>🌊</text></svg>">
  <style>
    body { font-family: sans-serif; background-color: #00a8ff; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
    .register-container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.2); width: 350px; text-align: center; }
    input { width: 90%; padding: 10px; margin: 10px 0; border: 1px solid #ccc; border-radius: 5px; }
    button { background-color: #007bff; color: white; border: none; padding: 12px; width: 100%; border-radius: 5px; cursor: pointer; font-size: 16px; margin-top: 10px;}
    button:hover { background-color: #0056b3; }
    .login-link { display: block; margin-top: 15px; text-decoration: none; color: #555; }
  </style>
</head>
<body>
<div class="register-container">
  <h2>🏨 Join Ocean View</h2>
  <% if ("error".equals(request.getParameter("msg"))) { %>
  <p style="color: red;">Registration failed. Username might be taken.</p>
  <% } %>
  <form action="register" method="post" onsubmit="return validatePassword()">
    <input type="text" name="firstName" placeholder="First Name" required>
    <input type="text" name="lastName" placeholder="Last Name" required>
    <input type="email" name="email" placeholder="Email Address" required>
    <input type="text" name="phone" placeholder="Phone Number" required>
    <input type="text" name="username" placeholder="Choose a Username" required>
    <input type="password" id="pwd" name="password" placeholder="Create Password" required>
    <input type="password" id="confirmPwd" name="confirmPassword" placeholder="Confirm Password" required>
    <button type="submit">Register as Guest</button>
  </form>

  <script>
    function validatePassword() {
      var pass = document.getElementById("pwd").value;
      var confirmPass = document.getElementById("confirmPwd").value;
      if (pass !== confirmPass) {
        alert("Passwords do not match!");
        return false; // Stops the form from submitting
      }
      return true; // Allows the form to submit
    }
  </script>
  <a href="login.jsp" class="login-link">Already have an account? Login here.</a>
</div>
</body>
</html>