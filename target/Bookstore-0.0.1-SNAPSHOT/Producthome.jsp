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
    <title>Product List</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .card-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }

        .card {
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 16px;
            width: 300px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin: 20px; /* Added margin to create gap between cards */
        }

        .card img {
            max-width: 100%;
            border-radius: 8px;
        }

        .card-content {
            margin-top: 12px;
        }

        .card-actions {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-top: 12px;
        }

        .btn {
            display: inline-block;
            padding: 10px 15px;
            font-size: 14px;
            color: #fff;
            background-color: #007bff;
            text-align: center;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .navbar {
            background-color: #007bff;
            padding: 15px;
        }

        .navbar a {
            color: #fff;
            margin-right: 15px;
        }

        .container {
            padding-top: 80px;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <a class="navbar-brand" href="#">Mary Exchange Agency</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="product-list">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="interested-products.jsp">Cart</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="Login.jsp">Logout</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <h1 class="text-center">Product List</h1>
        <div class="text-right mb-3">
            <a href="predict.jsp" class="btn btn-primary">Sell Product</a>
        </div>
        <div class="card-container">
            <%
                List<Product> listProduct = (List<Product>) request.getAttribute("listProduct");
                ProductDAO productDAO = new ProductDAO("jdbc:mysql://localhost:3306/exchange_agency", "root", "PssK@16-24"); // update with your database credentials
                if (listProduct != null) {
                    for (Product product : listProduct) {
                        String base64Image = "";
                        try {
                            base64Image = productDAO.getBase64Image(product.getId());
                        } catch (SQLException | IOException e) {
                            e.printStackTrace();
                        }
            %>
            <div class="card">
                <img src="data:image/jpeg;base64,<%= base64Image %>" alt="<%= product.getName() %>">
                <div class="card-content">
                    <h2><%= product.getName() %></h2>
                    <p><strong>Category:</strong> <%= product.getCategory() %></p>
                    <p><strong>Brand:</strong> <%= product.getBrand() %></p>
                    <p><strong>Model:</strong> <%= product.getModel() %></p>
                    <p><strong>Description:</strong> <%= product.getDescription() %></p>
                    <p><strong>Price:</strong> $<%= product.getPrice() %></p>
                </div>
                <div class="card-actions">
                    <a href="edit?id=<%= product.getId() %>" class="btn btn-warning">Edit</a>
                    <a href="delete?id=<%= product.getId() %>" class="btn btn-danger" onclick="return confirm('Are you sure?');">Delete</a>
                    <form action="cart" method="post" style="display:inline;">
                        <input type="hidden" name="productId" value="<%= product.getId() %>">
                        <button type="submit" class="btn btn-success">Add to Cart</button>
                    </form>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <p>No products found.</p>
            <%
                }
            %>
        </div>
    </div>
    <%@include file="/includes/footer.jsp"%>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
