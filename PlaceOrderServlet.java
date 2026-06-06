package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.Order;
import model.User;
import dao.OrderDAO;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Session check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("user");

        String foodItem     = request.getParameter("foodItem");
        int quantity        = Integer.parseInt(request.getParameter("quantity"));
        double totalPrice   = Double.parseDouble(request.getParameter("totalPrice"));
        String paymentMethod = request.getParameter("paymentMethod");

        Order order = new Order(currentUser, foodItem, quantity, totalPrice, paymentMethod);

        OrderDAO orderDAO = new OrderDAO();
        if (orderDAO.placeOrder(order)) {
            response.sendRedirect("myorders.jsp?success=true");
        } else {
            response.sendRedirect("payment.jsp?error=failed");
        }
    }
}
