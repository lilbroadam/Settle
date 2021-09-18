package com.settle.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/template")
public class TemplateServlet extends HttpServlet {

    // Optional method to initialize variables before servlet starts handling HTTP requests.
    @Override
    public void init() {
        
    }

    // Handle HTTP GET requests
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Respond with HTML
        response.setContentType("text/html");
        response.getWriter().println("This is the template servlet responding with HTML");

        // Response with a JSON
        // response.setContentType("application/json");
        // String json = <json-formatted string>;
        // response.getWriter().println(json);
    }

    // Handle HTTP POST requests
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        
    }
}
