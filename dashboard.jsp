<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User, dao.OrderDAO" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) { response.sendRedirect("login.jsp"); return; }

    OrderDAO orderDAO = new OrderDAO();
    long totalOrders   = orderDAO.getTotalOrdersByUser(currentUser.getId());
    double totalSpent  = orderDAO.getTotalSpentByUser(currentUser.getId());
    String favFood     = orderDAO.getFavoriteFood(currentUser.getId());
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - FoodZone</title>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Segoe UI',Arial,sans-serif; background:#f8f9fa; }

        /* Navbar */
        .navbar { background:#ff4757; color:white; padding:15px 30px; display:flex; justify-content:space-between; align-items:center; }
        .navbar h2 { font-size:1.5rem; }
        .nav-links a { color:white; text-decoration:none; margin-left:15px; font-weight:600; padding:8px 14px; border-radius:5px; background:rgba(255,255,255,0.15); }
        .nav-links a:hover { background:rgba(255,255,255,0.3); }

        .container { padding:30px; max-width:1200px; margin:0 auto; }

        /* Stats Cards */
        .stats-grid { display:grid; grid-template-columns:repeat(3,1fr); gap:20px; margin-bottom:35px; }
        .stat-card { background:white; padding:25px; border-radius:12px; box-shadow:0 2px 10px rgba(0,0,0,0.07); text-align:center; border-left:4px solid #ff4757; }
        .stat-card .icon { font-size:2rem; margin-bottom:8px; }
        .stat-card .number { font-size:2rem; font-weight:bold; color:#ff4757; }
        .stat-card .label { color:#666; font-size:14px; margin-top:4px; }

        /* Menu */
        .section-title { font-size:1.5rem; color:#2f3542; border-bottom:3px solid #ff4757; padding-bottom:10px; margin-bottom:20px; display:inline-block; }
        .menu-grid { display:grid; grid-template-columns:repeat(auto-fill,minmax(260px,1fr)); gap:25px; }
        .food-card { background:white; border-radius:12px; overflow:hidden; box-shadow:0 4px 10px rgba(0,0,0,0.08); transition:0.3s; }
        .food-card:hover { transform:translateY(-5px); box-shadow:0 8px 20px rgba(0,0,0,0.12); }
        .food-img { width:100%; height:160px; object-fit:cover; }
        .food-info { padding:15px; }
        .food-name { font-size:18px; font-weight:bold; color:#2f3542; margin-bottom:6px; }
        .food-desc { font-size:13px; color:#747d8c; margin-bottom:12px; }
        .food-footer { display:flex; justify-content:space-between; align-items:center; }
        .price { font-size:18px; font-weight:bold; color:#ff4757; }
        .order-btn { background:#ff4757; color:white; border:none; padding:8px 16px; border-radius:6px; cursor:pointer; font-weight:bold; text-decoration:none; font-size:14px; }
        .order-btn:hover { background:#c0392b; }
    </style>
</head>
<body>

<div class="navbar">
    <h2>🍕 FoodZone</h2>
    <div class="nav-links">
        <a href="dashboard.jsp">🏠 Home</a>
        <a href="myorders.jsp">📦 My Orders</a>
        <a href="login.jsp">🚪 Logout</a>
    </div>
</div>

<div class="container">

    <!-- Welcome -->
    <div style="margin-bottom:25px;">
        <h3 style="color:#2f3542; font-size:1.3rem;">👋 Welcome back, <span style="color:#ff4757;"><%= currentUser.getName() %></span>!</h3>
        <p style="color:#747d8c; margin-top:5px;">Here's your activity summary</p>
    </div>

    <!-- Stats -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="icon">📦</div>
            <div class="number"><%= totalOrders %></div>
            <div class="label">Total Orders Placed</div>
        </div>
        <div class="stat-card">
            <div class="icon">💰</div>
            <div class="number">₹<%= String.format("%.0f", totalSpent) %></div>
            <div class="label">Total Amount Spent</div>
        </div>
        <div class="stat-card">
            <div class="icon">❤️</div>
            <div class="number" style="font-size:1.1rem; padding-top:8px;"><%= favFood %></div>
            <div class="label">Your Favourite Food</div>
        </div>
    </div>

    <!-- Food Menu -->
    <div>
        <div class="section-title">🍽️ Our Menu</div>
        <div class="menu-grid">

            <div class="food-card">
                <img class="food-img" src="https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400" alt="Pizza"/>
                <div class="food-info">
                    <div class="food-name">Margherita Pizza</div>
                    <div class="food-desc">Classic tomato base with fresh mozzarella and basil.</div>
                    <div class="food-footer">
                        <span class="price">₹299</span>
                        <a href="payment.jsp?item=Margherita+Pizza&price=299" class="order-btn">Order Now</a>
                    </div>
                </div>
            </div>

            <div class="food-card">
                <img class="food-img" src="https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400" alt="Burger"/>
                <div class="food-info">
                    <div class="food-name">Cheese Burger</div>
                    <div class="food-desc">Juicy beef patty with cheddar, lettuce & tomato.</div>
                    <div class="food-footer">
                        <span class="price">₹199</span>
                        <a href="payment.jsp?item=Cheese+Burger&price=199" class="order-btn">Order Now</a>
                    </div>
                </div>
            </div>

            <div class="food-card">
                <img class="food-img" src="https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=400" alt="Biryani"/>
                <div class="food-info">
                    <div class="food-name">Chicken Biryani</div>
                    <div class="food-desc">Aromatic basmati rice cooked with spiced chicken.</div>
                    <div class="food-footer">
                        <span class="price">₹249</span>
                        <a href="payment.jsp?item=Chicken+Biryani&price=249" class="order-btn">Order Now</a>
                    </div>
                </div>
            </div>

            <div class="food-card">
                <img class="food-img" src="https://images.unsplash.com/photo-1626804475297-41608ea09aeb?w=400" alt="Pasta"/>
                <div class="food-info">
                    <div class="food-name">Pasta Arrabbiata</div>
                    <div class="food-desc">Spicy tomato pasta with garlic and fresh herbs.</div>
                    <div class="food-footer">
                        <span class="price">₹179</span>
                        <a href="payment.jsp?item=Pasta+Arrabbiata&price=179" class="order-btn">Order Now</a>
                    </div>
                </div>
            </div>

            <div class="food-card">
                <img class="food-img" src="https://images.unsplash.com/photo-1601050690597-df0568f70950?w=400" alt="Samosa"/>
                <div class="food-info">
                    <div class="food-name">Paneer Tikka</div>
                    <div class="food-desc">Grilled cottage cheese marinated in spicy yogurt.</div>
                    <div class="food-footer">
                        <span class="price">₹149</span>
                        <a href="payment.jsp?item=Paneer+Tikka&price=149" class="order-btn">Order Now</a>
                    </div>
                </div>
            </div>

            <div class="food-card">
                <img class="food-img" src="https://images.unsplash.com/photo-1551024601-bec78aea704b?w=400" alt="Dessert"/>
                <div class="food-info">
                    <div class="food-name">Chocolate Lava Cake</div>
                    <div class="food-desc">Warm chocolate cake with a gooey molten center.</div>
                    <div class="food-footer">
                        <span class="price">₹129</span>
                        <a href="payment.jsp?item=Chocolate+Lava+Cake&price=129" class="order-btn">Order Now</a>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>
