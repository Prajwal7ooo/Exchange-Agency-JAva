<%@ page import="net.codejava.javaee.exchangeagency.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Form</title>
    <%@ include file="/includes/head.jsp" %>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
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
            padding-top: 80px; /* Adjusted to account for the fixed navbar */
        }
        .form-container {
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .form-container label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        .form-container input,
        .form-container textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007BFF;
            color: #fff;
            text-align: center;
            text-decoration: none;
            border-radius: 4px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .image-preview {
            margin-top: 10px;
            max-width: 200px;
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
        <h1 class="text-center"><%= (request.getAttribute("product") != null) ? "Edit Product" : "Add New Product" %></h1>
        
        <div class="form-container">
            <form action="<%= (request.getAttribute("product") != null) ? "update" : "insert" %>" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="<%= (request.getAttribute("product") != null) ? ((Product) request.getAttribute("product")).getId() : "" %>" />
                
                <div class="form-group">
                    <label for="category">Category:</label>
                    <input type="text" id="category" name="category" value="<%= request.getParameter("predictedCategory") != null ? request.getParameter("predictedCategory") : (request.getAttribute("product") != null ? ((Product) request.getAttribute("product")).getCategory() : "") %>" required />
                </div>
                
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" value="<%= request.getParameter("name") != null ? request.getParameter("name") : (request.getAttribute("product") != null ? ((Product) request.getAttribute("product")).getName() : "") %>" required />
                </div>

                <div class="form-group">
                    <label for="brand">Brand:</label>
                    <input type="text" id="brand" name="brand" value="<%= request.getParameter("brand") != null ? request.getParameter("brand") : (request.getAttribute("product") != null ? ((Product) request.getAttribute("product")).getBrand() : "") %>" required />
                </div>

                <div class="form-group">
                    <label for="model">Model:</label>
                    <input type="text" id="model" name="model" value="<%= (request.getAttribute("product") != null) ? ((Product) request.getAttribute("product")).getModel() : "" %>" required />
                </div>

                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea id="description" name="description" rows="4" required><%= (request.getAttribute("product") != null) ? ((Product) request.getAttribute("product")).getDescription() : "" %></textarea>
                </div>

                <div class="form-group">
                    <label for="price">Price:</label>
                    <input type="number" id="price" name="price" step="0.01" value="<%= (request.getAttribute("product") != null) ? ((Product) request.getAttribute("product")).getPrice() : "" %>" required />
                </div>
                
                <div class="form-group">
                    <label for="image">Image:</label>
                    <input type="file" id="image" name="image" />
                    <% 
                        Product product = (Product) request.getAttribute("product");
                        if (product != null && product.getImage() != null) {
                    %>
                    <div class="image-preview">
                        <img src="<%= product.getImage() %>" alt="Product Image" />
                    </div>
                    <% 
                        }
                    %>
                </div>

                <button type="submit" class="btn"><%= (request.getAttribute("product") != null) ? "Update Product" : "Add Product" %></button>
            </form>
        </div>
    </div>
    <%@ include file="/includes/footer.jsp" %>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
