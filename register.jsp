<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register - FoodZone</title>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Segoe UI',sans-serif; background:#f7f9fa; display:flex; justify-content:center; align-items:center; height:100vh; }
        .card { background:white; padding:40px; border-radius:12px; box-shadow:0 4px 20px rgba(0,0,0,0.1); width:360px; }
        h2 { text-align:center; color:#333; margin-bottom:25px; }
        .form-group { margin-bottom:15px; }
        label { font-size:13px; color:#555; font-weight:600; display:block; margin-bottom:6px; }
        input { width:100%; padding:10px; border:1px solid #ddd; border-radius:6px; font-size:14px; }
        input:focus { border-color:#ff4757; outline:none; }
        .btn { width:100%; background:#ff4757; color:white; border:none; padding:12px; border-radius:6px; font-size:16px; font-weight:bold; cursor:pointer; margin-top:5px; }
        .btn:hover { background:#c0392b; }
        .footer { text-align:center; margin-top:20px; font-size:14px; color:#666; }
        .footer a { color:#ff4757; text-decoration:none; font-weight:bold; }
        .alert-error { background:#ffe0e0; color:#c0392b; padding:10px; border-radius:6px; margin-bottom:15px; font-size:14px; text-align:center; }
    </style>
</head>
<body>
    <div class="card">
        <h2>🍕 Create Account</h2>
        <% if ("failed".equals(request.getParameter("error"))) { %>
            <div class="alert-error">❌ Registration failed. Email may already exist.</div>
        <% } %>
        <form action="RegisterServlet" method="POST">
            <div class="form-group">
                <label>Full Name:</label>
                <input type="text" name="name" placeholder="Enter your name" required/>
            </div>
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" placeholder="Enter your email" required/>
            </div>
            <div class="form-group">
                <label>Password:</label>
                <input type="password" name="password" placeholder="Create a password" required/>
            </div>
            <div class="form-group">
                <label>Phone:</label>
                <input type="text" name="phone" placeholder="Enter phone number" required/>
            </div>
            <button type="submit" class="btn">Register</button>
        </form>
        <div class="footer">Already have an account? <a href="login.jsp">Login</a></div>
    </div>
</body>
</html>
