package net.codejava.javaee.exchangeagency;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException; 

@WebServlet("/productImage")
public class ProductImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;

    public void init() {
        String jdbcURL = getServletContext().getInitParameter("jdbcURL");
        String jdbcUsername = getServletContext().getInitParameter("jdbcUsername");
        String jdbcPassword = getServletContext().getInitParameter("jdbcPassword");

        productDAO = new ProductDAO(jdbcURL, jdbcUsername, jdbcPassword);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            // Get the Base64 encoded image string from ProductDAO
            String base64Image = productDAO.getBase64Image(id);

            if (base64Image != null && !base64Image.isEmpty()) {
                response.setContentType("text/plain");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(base64Image);
            } else {
                // Handle the case where the image is not found or empty
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
}
