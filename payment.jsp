<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser == null) { response.sendRedirect("login.jsp"); return; }

    String item  = request.getParameter("item")  != null ? request.getParameter("item")  : "Food Item";
    String price = request.getParameter("price") != null ? request.getParameter("price") : "0";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment - FoodZone</title>
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Segoe UI',sans-serif; background:#f8f9fa; display:flex; justify-content:center; align-items:center; min-height:100vh; padding:20px; }
        .card { background:white; padding:40px; border-radius:16px; box-shadow:0 8px 30px rgba(0,0,0,0.1); width:100%; max-width:480px; }
        h2 { text-align:center; color:#2f3542; margin-bottom:25px; }

        /* Order Summary */
        .summary { background:#fff5f5; border:1px solid #ffd0d0; border-radius:10px; padding:20px; margin-bottom:25px; }
        .summary h4 { color:#ff4757; margin-bottom:12px; }
        .summary-row { display:flex; justify-content:space-between; margin-bottom:8px; color:#555; font-size:15px; }
        .summary-row.total { font-weight:bold; font-size:17px; color:#2f3542; border-top:1px solid #ffd0d0; padding-top:10px; margin-top:5px; }

        /* Payment Methods */
        .payment-methods { margin-bottom:25px; }
        .payment-methods h4 { color:#2f3542; margin-bottom:12px; }
        .method-option { display:flex; align-items:center; gap:12px; padding:14px; border:2px solid #eee; border-radius:10px; margin-bottom:10px; cursor:pointer; transition:0.2s; }
        .method-option:hover { border-color:#ff4757; background:#fff5f5; }
        .method-option input[type="radio"] { accent-color:#ff4757; width:18px; height:18px; }
        .method-option label { cursor:pointer; font-size:15px; color:#333; font-weight:500; }
        .method-icon { font-size:1.5rem; }

        /* Card Form (shown on UPI/Card select) */
        .card-form { display:none; background:#f9f9f9; padding:15px; border-radius:8px; margin-top:10px; }
        .form-group { margin-bottom:12px; }
        .form-group label { font-size:13px; color:#555; font-weight:600; display:block; margin-bottom:5px; }
        .form-group input { width:100%; padding:10px; border:1px solid #ddd; border-radius:6px; font-size:14px; }

        .pay-btn { width:100%; background:#ff4757; color:white; border:none; padding:15px; border-radius:10px; font-size:18px; font-weight:bold; cursor:pointer; transition:0.3s; }
        .pay-btn:hover { background:#c0392b; }

        .back-link { display:block; text-align:center; margin-top:15px; color:#888; text-decoration:none; font-size:14px; }
        .back-link:hover { color:#ff4757; }
    </style>
</head>
<body>
<div class="card">
    <h2>💳 Checkout</h2>

    <!-- Order Summary -->
    <div class="summary">
        <h4>🛒 Order Summary</h4>
        <div class="summary-row"><span>Item</span><span><%= item %></span></div>
        <div class="summary-row"><span>Quantity</span><span>1</span></div>
        <div class="summary-row"><span>Delivery Charge</span><span>₹30</span></div>
        <div class="summary-row total">
            <span>Total Payable</span>
            <span>₹<%= (Integer.parseInt(price) + 30) %></span>
        </div>
    </div>

    <!-- Payment Form -->
    <form action="PlaceOrderServlet" method="POST" onsubmit="return validatePayment()">
        <input type="hidden" name="foodItem"   value="<%= item %>"/>
        <input type="hidden" name="quantity"   value="1"/>
        <input type="hidden" name="totalPrice" value="<%= (Integer.parseInt(price) + 30) %>"/>
        <input type="hidden" name="paymentMethod" id="selectedMethod" value="Cash on Delivery"/>

        <div class="payment-methods">
            <h4>💰 Select Payment Method</h4>

            <div class="method-option" onclick="selectMethod('Cash on Delivery', this)">
                <span class="method-icon">💵</span>
                <input type="radio" name="method" value="cod" checked/>
                <label>Cash on Delivery</label>
            </div>

            <div class="method-option" onclick="selectMethod('UPI', this)">
                <span class="method-icon">📱</span>
                <input type="radio" name="method" value="upi"/>
                <label>UPI Payment</label>
                <div class="card-form" id="upiForm">
                    <div class="form-group">
                        <label>UPI ID:</label>
                        <input type="text" id="upiId" placeholder="yourname@upi"/>
                    </div>
                </div>
            </div>

            <div class="method-option" onclick="selectMethod('Credit/Debit Card', this)">
                <span class="method-icon">💳</span>
                <input type="radio" name="method" value="card"/>
                <label>Credit / Debit Card</label>
                <div class="card-form" id="cardForm">
                    <div class="form-group">
                        <label>Card Number:</label>
                        <input type="text" id="cardNum" placeholder="1234 5678 9012 3456" maxlength="19"/>
                    </div>
                    <div style="display:flex; gap:10px;">
                        <div class="form-group" style="flex:1">
                            <label>Expiry:</label>
                            <input type="text" placeholder="MM/YY" maxlength="5"/>
                        </div>
                        <div class="form-group" style="flex:1">
                            <label>CVV:</label>
                            <input type="password" placeholder="***" maxlength="3"/>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <button type="submit" class="pay-btn">✅ Confirm & Pay ₹<%= (Integer.parseInt(price) + 30) %></button>
    </form>

    <a href="dashboard.jsp" class="back-link">← Back to Menu</a>
</div>

<script>
    function selectMethod(name, el) {
        document.getElementById('selectedMethod').value = name;
        // Hide all card forms
        document.querySelectorAll('.card-form').forEach(f => f.style.display = 'none');
        // Show relevant form
        if (name === 'UPI')                document.getElementById('upiForm').style.display  = 'block';
        if (name === 'Credit/Debit Card')  document.getElementById('cardForm').style.display = 'block';
    }

    function validatePayment() {
        const method = document.getElementById('selectedMethod').value;
        if (method === 'UPI' && !document.getElementById('upiId').value.trim()) {
            alert('Please enter your UPI ID'); return false;
        }
        if (method === 'Credit/Debit Card' && document.getElementById('cardNum').value.length < 16) {
            alert('Please enter a valid card number'); return false;
        }
        return true;
    }
</script>
</body>
</html>
