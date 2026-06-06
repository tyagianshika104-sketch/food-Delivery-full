<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User, model.Order, dao.OrderDAO, java.util.List, java.text.SimpleDateFormat" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) { response.sendRedirect("login.jsp"); return; }

    OrderDAO orderDAO = new OrderDAO();
    List<Order> orders = orderDAO.getOrdersByUser(currentUser.getId());
    long totalOrders  = orderDAO.getTotalOrdersByUser(currentUser.getId());
    double totalSpent = orderDAO.getTotalSpentByUser(currentUser.getId());

    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, hh:mm a");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Orders - FoodZone</title>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Segoe UI',sans-serif; background:#f8f9fa; }
        .navbar { background:#ff4757; color:white; padding:15px 30px; display:flex; justify-content:space-between; align-items:center; }
        .navbar h2 { font-size:1.5rem; }
        .nav-links a { color:white; text-decoration:none; margin-left:15px; font-weight:600; padding:8px 14px; border-radius:5px; background:rgba(255,255,255,0.15); }
        .nav-links a:hover { background:rgba(255,255,255,0.3); }

        .container { padding:30px; max-width:900px; margin:0 auto; }

        /* Summary bar */
        .summary-bar { display:flex; gap:20px; margin-bottom:30px; }
        .sum-card { background:white; flex:1; padding:20px; border-radius:12px; box-shadow:0 2px 10px rgba(0,0,0,0.07); text-align:center; border-top:4px solid #ff4757; }
        .sum-card .num { font-size:2rem; font-weight:bold; color:#ff4757; }
        .sum-card .lbl { color:#888; font-size:13px; margin-top:4px; }

        /* Orders table */
        .section-title { font-size:1.3rem; color:#2f3542; margin-bottom:15px; }
        .orders-table { width:100%; border-collapse:collapse; background:white; border-radius:12px; overflow:hidden; box-shadow:0 2px 10px rgba(0,0,0,0.07); }
        .orders-table th { background:#ff4757; color:white; padding:14px 16px; text-align:left; font-size:14px; }
        .orders-table td { padding:14px 16px; border-bottom:1px solid #f0f0f0; font-size:14px; color:#444; }
        .orders-table tr:last-child td { border-bottom:none; }
        .orders-table tr:hover td { background:#fff5f5; }

        .badge { padding:4px 12px; border-radius:20px; font-size:12px; font-weight:bold; }
        .badge-paid      { background:#d4edda; color:#155724; }
        .badge-pending   { background:#fff3cd; color:#856404; }
        .badge-delivered { background:#cce5ff; color:#004085; }

        .empty-state { text-align:center; padding:60px 20px; color:#888; }
        .empty-state .icon { font-size:4rem; margin-bottom:15px; }

        .alert-success { background:#d4edda; color:#155724; padding:12px 20px; border-radius:8px; margin-bottom:20px; }
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

    <% if ("true".equals(request.getParameter("success"))) { %>
        <div class="alert-success">✅ Order placed successfully! Your food is on the way 🚀</div>
    <% } %>

    <h2 style="margin-bottom:20px; color:#2f3542;">📦 My Orders</h2>

    <!-- Summary -->
    <div class="summary-bar">
        <div class="sum-card">
            <div class="num"><%= totalOrders %></div>
            <div class="lbl">Total Orders</div>
        </div>
        <div class="sum-card">
            <div class="num">₹<%= String.format("%.0f", totalSpent) %></div>
            <div class="lbl">Total Spent</div>
        </div>
        <div class="sum-card">
            <div class="num"><%= currentUser.getName() %></div>
            <div class="lbl">Account Name</div>
        </div>
    </div>

    <!-- Orders List -->
    <div class="section-title">📋 Order History</div>

    <% if (orders == null || orders.isEmpty()) { %>
        <div class="empty-state">
            <div class="icon">🛒</div>
            <p style="font-size:1.2rem; margin-bottom:10px;">No orders yet!</p>
            <p>Go to <a href="dashboard.jsp" style="color:#ff4757;">Menu</a> and place your first order.</p>
        </div>
    <% } else { %>
        <table class="orders-table">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Food Item</th>
                    <th>Qty</th>
                    <th>Amount</th>
                    <th>Payment</th>
                    <th>Status</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody>
                <% int sr = 1; for (Order o : orders) { %>
                <tr>
                    <td><%= sr++ %></td>
                    <td><strong><%= o.getFoodItem() %></strong></td>
                    <td><%= o.getQuantity() %></td>
                    <td><strong>₹<%= String.format("%.0f", o.getTotalPrice()) %></strong></td>
                    <td><%= o.getPaymentMethod() %></td>
                    <td>
                        <span class="badge
                            <%= "Paid".equals(o.getStatus()) ? "badge-paid" :
                                "Delivered".equals(o.getStatus()) ? "badge-delivered" : "badge-pending" %>">
                            <%= o.getStatus() %>
                        </span>
                    </td>
                    <td><%= sdf.format(o.getOrderDate()) %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>

</div>
</body>
</html>
