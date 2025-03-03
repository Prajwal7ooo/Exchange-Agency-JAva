package net.codejava.javaee.exchangeagency;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class InterestedProductsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private InterestDAO interestDAO;

    public void init() {
        String jdbcURL = getServletContext().getInitParameter("jdbcURL");
        String jdbcUsername = getServletContext().getInitParameter("jdbcUsername");
        String jdbcPassword = getServletContext().getInitParameter("jdbcPassword");
        interestDAO = new InterestDAO(jdbcURL, jdbcUsername, jdbcPassword);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hardcoded user ID
        int userId = 1;

        try {
            List<Product> products = interestDAO.getInterestProducts(userId);
            request.setAttribute("cartItems", products);
            request.getRequestDispatcher("interested-products.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage());
        }
    }
    
    public class RemoveItemServlet extends HttpServlet {
        private static final long serialVersionUID = 1L;

        // JDBC connection parameters
        private String jdbcURL = "jdbc:mysql://localhost:3306/exchange_agency";
        private String jdbcUsername = "root";
        private String jdbcPassword = "PssK@16-24";

        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            int productId = Integer.parseInt(request.getParameter("productId"));

            // Create an instance of ProductDAO
            ProductDAO productDAO = new ProductDAO(jdbcURL, jdbcUsername, jdbcPassword);

            try {
                // Remove product from user's cart
                productDAO.removeProductFromCart(productId, 1); // assuming userId is 1
            } catch (SQLException e) {
                e.printStackTrace();
            }

            // Redirect to the same page to refresh the list
            response.sendRedirect("interested-products.jsp");
        }
    }
}
