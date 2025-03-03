package net.codejava.javaee.exchangeagency;

import weka.classifiers.Classifier;
import weka.core.DenseInstance;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.converters.ConverterUtils.DataSource;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;


public class PredictServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String brand = request.getParameter("brand");
        String features = request.getParameter("features");

        try {
            // Load the model
            Classifier classifier;
            try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(getServletContext().getRealPath("item_listings.model")))) {
                classifier = (Classifier) ois.readObject();
            }

            // Load the dataset structure
            DataSource source = new DataSource(getServletContext().getRealPath("item_listings.arff"));
            Instances data = source.getDataSet();
            data.setClassIndex(data.numAttributes() - 1);

            // Create an instance with the provided input
            Instance instance = new DenseInstance(data.numAttributes());
            instance.setDataset(data);

            instance.setValue(data.attribute("Item Name"), name);

            // Handle Item Brand to match the ARFF nominal values
            if (data.attribute("Item Brand").indexOfValue(brand) != -1) {
                instance.setValue(data.attribute("Item Brand"), brand);
            } else {
                throw new Exception("Invalid Item Brand: " + brand);
            }

            instance.setValue(data.attribute("Item Features"), features);

            // Classify the instance
            double labelIndex = classifier.classifyInstance(instance);
            String predictedClass = data.classAttribute().value((int) labelIndex);

            // Redirect to ProductForm.jsp with the predicted category
            response.sendRedirect("ProductForm.jsp?predictedCategory=" + predictedClass);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error predicting category: " + e.getMessage());
            request.getRequestDispatcher("predict.jsp").forward(request, response);
        }
    }
}
