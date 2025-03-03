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


public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;

    public void init() {
        String jdbcURL = getServletContext().getInitParameter("jdbcURL");
        String jdbcUsername = getServletContext().getInitParameter("jdbcUsername");
        String jdbcPassword = getServletContext().getInitParameter("jdbcPassword");

        productDAO = new ProductDAO(jdbcURL, jdbcUsername, jdbcPassword);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Ensure a session exists
        if (session != null) {
            // Hardcode userId for testing
            Integer userId = 1;

            try {
                int productId = Integer.parseInt(request.getParameter("productId"));
                System.out.println("Adding product ID " + productId + " to cart for user ID " + userId);
                productDAO.addToCart(userId, productId);
                response.sendRedirect("product-list");
            } catch (NumberFormatException e) {
                System.out.println("Invalid product ID format: " + e.getMessage());
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID format");
            } catch (SQLException e) {
                e.printStackTrace();
                throw new ServletException("Database error: " + e.getMessage());
            }
        } else {
            response.sendRedirect("login");
        }
    }
}
