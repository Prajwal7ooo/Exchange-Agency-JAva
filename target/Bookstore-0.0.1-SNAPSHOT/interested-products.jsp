<%@ page import="java.util.List" %>
<%@ page import="net.codejava.javaee.exchangeagency.Product" %>
<%@ page import="net.codejava.javaee.exchangeagency.ProductDAO" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .cart-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
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
                    <a class="nav-link" href="Producthome.jsp">My Sells</a>
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
        <h1>Interested Products</h1>
        <div class="cart-container">
            <%
                // JDBC connection parameters
                String jdbcURL = "jdbc:mysql://localhost:3306/exchange_agency";
                String jdbcUsername = "root";
                String jdbcPassword = "PssK@16-24";
                
                // Create an instance of ProductDAO
                ProductDAO productDAO = new ProductDAO(jdbcURL, jdbcUsername, jdbcPassword);
                
                // Get the list of interested products for a specific user (assuming userId is 1 for this example)
                int userId = 1; // Change this as per your requirements
                List<Product> productList = null;
                
                try {
                    productList = productDAO.listInterestedProducts(userId);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                
                // Loop through the list and display each product
                if (productList != null) {
                    for (Product product : productList) {
                        String base64Image = "";
                        try {
                            base64Image = productDAO.getBase64Image(product.getId());
                        } catch (SQLException | IOException e) {
                            e.printStackTrace();
                        }
            %>
            <div class="cart-item">
                <div class="cart-item-content">
                    <h2><%= product.getName() %></h2>
                    <p><strong>Category:</strong> <%= product.getCategory() %></p>
                    <% if (!base64Image.isEmpty()) { %>
                    <img src="data:image/jpeg;base64,<%= base64Image %>" alt="<%= product.getName() %>">
                    <% } else { %>
                    <p>No image available</p>
                    <% } %>
                    <!-- Remove Button -->
                    <form action="remove-item" method="post" style="display:inline;">
                        <input type="hidden" name="productId" value="<%= product.getId() %>">
                        <button type="submit" class="btn btn-danger">Remove</button>
                    </form>
                </div>
            </div>
            <% 
                    }
                } else {
            %>
            <p>No products found.</p>
            <% } %>
        </div>
    </div>
    <%@include file="/includes/footer.jsp"%>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
