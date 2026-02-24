<%-- Finalized styling for Login interface --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ocean View Resort - Login</title>
    <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>🌊</text></svg>">
    <style>
        body { font-family: sans-serif; background-color: #00a8ff; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .login-container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.2); width: 300px; text-align: center; }
        input { width: 90%; padding: 10px; margin: 10px 0; border: 1px solid #ccc; border-radius: 5px; }
        button { background-color: #007bff; color: white; border: none; padding: 12px; width: 100%; border-radius: 5px; cursor: pointer; font-size: 16px; margin-top: 10px;}
        button:hover { background-color: #0056b3; }
        .error { color: red; font-size: 14px; margin-bottom: 10px; }
        .success { color: green; font-size: 14px; margin-bottom: 10px; }
        .register-link { display: block; margin-top: 15px; text-decoration: none; color: #555; font-size: 14px; }
        .register-link:hover { color: #007bff; }
    </style>
</head>
<body>
<div class="login-container">
    <h2>🌊 Ocean View Resort</h2>

    <% if ("true".equals(request.getParameter("error"))) { %>
    <div class="error">Invalid username or password!</div>
    <% } else if ("registered".equals(request.getParameter("msg"))) { %>
    <div class="success">Registration successful! Please login.</div>
    <% } %>

    <form action="login" method="post">
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>

        <button type="submit">Login</button>
    </form>

    <a href="guestRegister.jsp" class="register-link">New Guest? Register Here</a>
</div>
</body>
</html>