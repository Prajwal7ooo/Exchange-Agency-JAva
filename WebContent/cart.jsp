<%@ page import="java.util.List" %>
<%@ page import="net.codejava.javaee.exchangeagency.Product" %>
<%@ page import="net.codejava.javaee.exchangeagency.ProductDAO" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart</title>
    <%@ include file="/includes/head.jsp" %>
    <style>
        .cart-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .cart-item {
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 16px;
            width: 300px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .cart-item img {
            max-width: 100%;
            border-radius: 8px;
        }

        .cart-item-content {
            margin-top: 12px;
        }
    </style>
</head>
<body>
    <%@ include file="/includes/navbar.jsp" %>
    <div class="container">
        <h1>Shopping Cart</h1>
        <div class="cart-container">
            <%
                // Initialize ProductDAO
                String jdbcURL = "jdbc:mysql://localhost:3306/exchange_agency"; // Update with your database credentials
                String jdbcUsername = "root"; // Update with your database username
                String jdbcPassword = "PssK@16-24"; // Update with your database password
                ProductDAO productDAO = new ProductDAO(jdbcURL, jdbcUsername, jdbcPassword);

                // Get the list of products from the request attribute
                List<Product> cartItems = (List<Product>) request.getAttribute("cartItems");
                if (cartItems != null && !cartItems.isEmpty()) {
                    for (Product product : cartItems) {
                        String base64Image = "";
                        try {
                            // Fetch the image as base64
                            base64Image = productDAO.getBase64Image(product.getId());
                        } catch (SQLException | IOException e) {
                            e.printStackTrace();
                        }
            %>
            <div class="cart-item">
                <img src="data:image/jpeg;base64,<%= base64Image %>" alt="<%= product.getName() %>">
                <div class="cart-item-content">
                    <h2><%= product.getName() %></h2>
                    <p><strong>Category:</strong> <%= product.getCategory() %></p>
                    <p><strong>Brand:</strong> <%= product.getBrand() %></p>
                    <p><strong>Model:</strong> <%= product.getModel() %></p>
                    <p><strong>Description:</strong> <%= product.getDescription() %></p>
                    <p><strong>Price:</strong> $<%= product.getPrice() %></p>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <p>Your cart is empty.</p>
            <%
                }
            %>
        </div>
    </div>
    <%@ include file="/includes/footer.jsp" %>
</body>
</html>
