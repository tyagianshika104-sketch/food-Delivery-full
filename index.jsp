<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FoodZone - Fast & Delicious</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)),
                        url('https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=1000')
                        no-repeat center center/cover;
            height: 100vh; display: flex; justify-content: center;
            align-items: center; color: white; text-align: center;
        }
        .hero { background: rgba(0,0,0,0.5); padding: 50px; border-radius: 15px; backdrop-filter: blur(5px); }
        h1 { font-size: 3rem; color: #ffbe33; margin-bottom: 10px; }
        p  { font-size: 1.2rem; margin-bottom: 30px; }
        .btn-group { display: flex; justify-content: center; gap: 20px; }
        .btn { padding: 12px 35px; font-size: 18px; font-weight: bold; border-radius: 30px; text-decoration: none; transition: 0.3s; }
        .btn-login    { background: #ffbe33; color: #222; border: 2px solid #ffbe33; }
        .btn-login:hover { background: transparent; color: #ffbe33; }
        .btn-register { background: transparent; color: white; border: 2px solid white; }
        .btn-register:hover { background: white; color: black; }
    </style>
</head>
<body>
    <div class="hero">
        <h1>🍕 FoodZone</h1>
        <p>Freshly made meals delivered straight to your doorstep.</p>
        <div class="btn-group">
            <a href="login.jsp" class="btn btn-login">Sign In</a>
            <a href="register.jsp" class="btn btn-register">Create Account</a>
        </div>
    </div>
</body>
</html>
