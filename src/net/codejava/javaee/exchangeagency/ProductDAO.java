package net.codejava.javaee.exchangeagency;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

public class ProductDAO {
    private String jdbcURL;
    private String jdbcUsername;
    private String jdbcPassword;
    private Connection jdbcConnection;

    public ProductDAO(String jdbcURL, String jdbcUsername, String jdbcPassword) {
        this.jdbcURL = jdbcURL;
        this.jdbcUsername = jdbcUsername;
        this.jdbcPassword = jdbcPassword;
    }

    protected void connect() throws SQLException {
        if (jdbcConnection == null || jdbcConnection.isClosed()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                throw new SQLException(e);
            }
            jdbcConnection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        }
    }

    protected void disconnect() throws SQLException {
        if (jdbcConnection != null && !jdbcConnection.isClosed()) {
            jdbcConnection.close();
        }
    }

    public String getBase64Image(int id) throws SQLException, IOException {
        String sql = "SELECT image FROM product WHERE id = ?";
        connect();

        PreparedStatement statement = jdbcConnection.prepareStatement(sql);
        statement.setInt(1, id);
        ResultSet resultSet = statement.executeQuery();

        String base64Image = "";
        if (resultSet.next()) {
            Blob imgBlob = resultSet.getBlob("image");
            if (imgBlob != null) {
                InputStream inputStream = imgBlob.getBinaryStream();
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
                byte[] imageBytes = outputStream.toByteArray();
                base64Image = Base64.getEncoder().encodeToString(imageBytes);
            }
        }

        resultSet.close();
        statement.close();
        disconnect();

        return base64Image;
    }

    // Existing methods ...

    public boolean insertProduct(Product product) throws SQLException {
        String sql = "INSERT INTO product (category, name, brand, model, description, price, image) VALUES (?, ?, ?, ?, ?, ?, ?)";
        connect();

        PreparedStatement statement = jdbcConnection.prepareStatement(sql);
        statement.setString(1, product.getCategory());
        statement.setString(2, product.getName());
        statement.setString(3, product.getBrand());
        statement.setString(4, product.getModel());
        statement.setString(5, product.getDescription());
        statement.setFloat(6, product.getPrice());
        statement.setBytes(7, product.getImage());

        boolean rowInserted = statement.executeUpdate() > 0;
        statement.close();
        disconnect();
        return rowInserted;
    }

    public boolean updateProduct(Product product) throws SQLException {
        String sql = "UPDATE product SET category = ?, name = ?, brand = ?, model = ?, description = ?, price = ?, image = ? WHERE id = ?";
        connect();

        PreparedStatement statement = jdbcConnection.prepareStatement(sql);
        statement.setString(1, product.getCategory());
        statement.setString(2, product.getName());
        statement.setString(3, product.getBrand());
        statement.setString(4, product.getModel());
        statement.setString(5, product.getDescription());
        statement.setFloat(6, product.getPrice());
        statement.setBytes(7, product.getImage());
        statement.setInt(8, product.getId());

        boolean rowUpdated = statement.executeUpdate() > 0;
        statement.close();
        disconnect();
        return rowUpdated;
    }

    public Product getProduct(int id) throws SQLException {
        Product product = null;
        String sql = "SELECT * FROM product WHERE id = ?";

        connect();

        PreparedStatement statement = jdbcConnection.prepareStatement(sql);
        statement.setInt(1, id);

        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {
            String category = resultSet.getString("category");
            String name = resultSet.getString("name");
            String brand = resultSet.getString("brand");
            String model = resultSet.getString("model");
            String description = resultSet.getString("description");
            float price = resultSet.getFloat("price");
            byte[] image = resultSet.getBytes("image");

            product = new Product(id, category, name, brand, model, description, price, image);
        }

        resultSet.close();
        statement.close();
        disconnect();

        return product;
    }

    public List<Product> listAllProducts() throws SQLException {
        List<Product> listProduct = new ArrayList<>();

        String sql = "SELECT * FROM product";

        connect();

        Statement statement = jdbcConnection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);

        while (resultSet.next()) {
            int id = resultSet.getInt("id");
            String category = resultSet.getString("category");
            String name = resultSet.getString("name");
            String brand = resultSet.getString("brand");
            String model = resultSet.getString("model");
            String description = resultSet.getString("description");
            float price = resultSet.getFloat("price");
            byte[] image = resultSet.getBytes("image");

            Product product = new Product(id, category, name, brand, model, description, price, image);
            listProduct.add(product);
        }

        resultSet.close();
        statement.close();
        disconnect();

        return listProduct;
    }

    public boolean deleteProduct(Product product) throws SQLException {
        String sql = "DELETE FROM product WHERE id = ?";

        connect();

        PreparedStatement statement = jdbcConnection.prepareStatement(sql);
        statement.setInt(1, product.getId());

        boolean rowDeleted = statement.executeUpdate() > 0;
        statement.close();
        disconnect();
        return rowDeleted;
    }

    public void addInterest(int userId, int productId) throws SQLException {
        String sql = "INSERT INTO interest (user_id, product_id) VALUES (?, ?)";
        connect();

        PreparedStatement statement = jdbcConnection.prepareStatement(sql);
        statement.setInt(1, userId);
        statement.setInt(2, productId);

        statement.executeUpdate();
        statement.close();
        disconnect();
    }

    public void removeInterest(int userId, int productId) throws SQLException {
        String sql = "DELETE FROM interest WHERE user_id = ? AND product_id = ?";
        connect();

        PreparedStatement statement = jdbcConnection.prepareStatement(sql);
        statement.setInt(1, userId);
        statement.setInt(2, productId);

        statement.executeUpdate();
        statement.close();
        disconnect();
    }
    
    public byte[] getProductImage(int productId) throws SQLException {
        String sql = "SELECT image FROM product WHERE id = ?";
        connect();
        PreparedStatement statement = jdbcConnection.prepareStatement(sql);
        statement.setInt(1, productId);
        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {
            return resultSet.getBytes("image");
        }
        disconnect();
        return null;
    }
    
    public void addProductToInterest(int userId, int productId) throws SQLException {
        String sql = "INSERT INTO interest (user_id, product_id) VALUES (?, ?)";
        connect();

        PreparedStatement statement = jdbcConnection.prepareStatement(sql);
        statement.setInt(1, userId);
        statement.setInt(2, productId);

        statement.executeUpdate();

        statement.close();
        disconnect();
    }

    
    public void addToCart(int userId, int productId) throws SQLException {
        String sql = "INSERT INTO interest (user_id, product_id) VALUES (?, ?)";
        connect();
        PreparedStatement statement = jdbcConnection.prepareStatement(sql);
        statement.setInt(1, userId);
        statement.setInt(2, productId);
        statement.executeUpdate();
        disconnect();
    }
    
    public List<Product> getCartItems(int userId) throws SQLException {
        List<Product> listProduct = new ArrayList<>();

        String sql = "SELECT p.* FROM product p INNER JOIN interest i ON p.id = i.product_id WHERE i.user_id = ?";
        connect();

        PreparedStatement statement = jdbcConnection.prepareStatement(sql);
        statement.setInt(1, userId);

        ResultSet resultSet = statement.executeQuery();

        while (resultSet.next()) {
            int id = resultSet.getInt("id");
            String category = resultSet.getString("category");
            String name = resultSet.getString("name");
            String brand = resultSet.getString("brand");
            String model = resultSet.getString("model");
            String description = resultSet.getString("description");
            float price = resultSet.getFloat("price");
            byte[] image = resultSet.getBytes("image");

            Product product = new Product(id, category, name, brand, model, description, price, image);
            listProduct.add(product);
        }

        resultSet.close();
        statement.close();
        disconnect();

        return listProduct;
    }

    

    public List<Product> listInterestedProducts(int userId) throws SQLException {
        List<Product> listProduct = new ArrayList<>();

        String sql = "SELECT p.* FROM product p INNER JOIN interest i ON p.id = i.product_id WHERE i.user_id = ?";
        connect();

        PreparedStatement statement = jdbcConnection.prepareStatement(sql);
        statement.setInt(1, userId);

        ResultSet resultSet = statement.executeQuery();

        while (resultSet.next()) {
            int id = resultSet.getInt("id");
            String category = resultSet.getString("category");
            String name = resultSet.getString("name");
            String brand = resultSet.getString("brand");
            String model = resultSet.getString("model");
            String description = resultSet.getString("description");
            float price = resultSet.getFloat("price");
            byte[] image = resultSet.getBytes("image");

            Product product = new Product(id, category, name, brand, model, description, price, image);
            listProduct.add(product);
        }

        resultSet.close();
        statement.close();
        disconnect();

        return listProduct;
    }
    
    public void removeProductFromCart(int productId, int userId) throws SQLException {
        String sql = "DELETE FROM interest WHERE user_id = ? AND product_id = ?";
        
        try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            statement.setInt(2, productId);
            statement.executeUpdate();
        }
    }
}
