<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - FoodZone</title>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Segoe UI',sans-serif; background:#f7f9fa; display:flex; justify-content:center; align-items:center; height:100vh; }
        .card { background:white; padding:40px; border-radius:12px; box-shadow:0 4px 20px rgba(0,0,0,0.1); width:340px; text-align:center; }
        h2 { margin-bottom:25px; color:#333; }
        .form-group { margin-bottom:15px; text-align:left; }
        label { font-size:13px; color:#555; font-weight:600; display:block; margin-bottom:6px; }
        input { width:100%; padding:10px; border:1px solid #ddd; border-radius:6px; font-size:14px; }
        input:focus { border-color:#ff4757; outline:none; }
        .btn { width:100%; background:#ff4757; color:white; border:none; padding:12px; border-radius:6px; font-size:16px; font-weight:bold; cursor:pointer; margin-top:10px; }
        .btn:hover { background:#c0392b; }
        .footer { margin-top:20px; font-size:14px; color:#666; }
        .footer a { color:#ff4757; text-decoration:none; font-weight:bold; }
        .alert-error   { background:#ffe0e0; color:#c0392b; padding:10px; border-radius:6px; margin-bottom:15px; font-size:14px; }
        .alert-success { background:#d4edda; color:#155724; padding:10px; border-radius:6px; margin-bottom:15px; font-size:14px; }
    </style>
</head>
<body>
    <div class="card">
        <h2>🔐 Sign In</h2>
        <% if ("invalid".equals(request.getParameter("error"))) { %>
            <div class="alert-error">❌ Invalid email or password.</div>
        <% } %>
        <% if ("true".equals(request.getParameter("registered"))) { %>
            <div class="alert-success">✅ Registered! Please login.</div>
        <% } %>
        <form action="LoginServlet" method="POST">
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" placeholder="Enter email" required/>
            </div>
            <div class="form-group">
                <label>Password:</label>
                <input type="password" name="password" placeholder="Enter password" required/>
            </div>
            <button type="submit" class="btn">Login</button>
        </form>
        <div class="footer">New user? <a href="register.jsp">Register here</a></div>
    </div>
</body>
</html>
