<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Predict Item Category</title>
    <%@ include file="/includes/head.jsp" %>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .btn {
            padding: 10px 15px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .result-container {
            margin-top: 20px;
        }

        .error {
            color: red;
        }

        .success {
            color: green;
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
    <script>
        function printValues() {
            var name = document.getElementById('name').value;
            var brand = document.getElementById('brand').value;
            var features = document.getElementById('features').value;
            console.log("Item Name: " + name);
            console.log("Item Brand: " + brand);
            console.log("Item Features: " + features);
        }

        document.addEventListener('DOMContentLoaded', function() {
            var form = document.querySelector('form');
            form.addEventListener('submit', function(event) {
                printValues();
            });
        });
    </script>
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
        <h1>Predict Item Category</h1>
        <div class="form-container">
            <form action="predict" method="post">
                <div class="form-group">
                    <label for="name">Item Name</label>
                    <input type="text" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="brand">Item Brand</label>
                    <input type="text" id="brand" name="brand" required>
                </div>
                <div class="form-group">
                    <label for="features">Item Features</label>
                    <textarea id="features" name="features" rows="4" required></textarea>
                </div>
                <button type="submit" class="btn">Predict Category</button>
            </form>

            <div class="result-container">
                <% if (request.getAttribute("prediction") != null) { %>
                    <p class="success">Predicted Category: <%= request.getAttribute("prediction") %></p>
                <% } else if (request.getAttribute("error") != null) { %>
                    <p class="error"><%= request.getAttribute("error") %></p>
                <% } %>
            </div>
        </div>
    </div>
    <%@ include file="/includes/footer.jsp" %>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
