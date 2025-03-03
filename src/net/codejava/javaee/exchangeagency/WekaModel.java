package net.codejava.javaee.exchangeagency;
import weka.classifiers.Classifier;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.converters.ArffLoader;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;

public class WekaModel {

    public static void main(String[] args) {
        try {
            // Load the model
            File modelFile = new File("item_listings.model");
            Classifier classifier;
            try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(modelFile))) {
                classifier = (Classifier) ois.readObject();
            }

            // Load the dataset
            ArffLoader loader = new ArffLoader();
            loader.setFile(new File("item_listings.arff")); // Convert CSV to ARFF if needed
            Instances data = loader.getDataSet();
            data.setClassIndex(data.numAttributes() - 1);

            // Create an instance to classify
            Instance instance = data.instance(0); // Example with first instance
            double label = classifier.classifyInstance(instance);

            System.out.println("Predicted class label: " + label);
        } catch (IOException e) {
            System.err.println("Error loading model or dataset file: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            System.err.println("Class not found: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
