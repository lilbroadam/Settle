package com.settle.servlets;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.settle.SettleSessionManager;
import com.settle.SettleSession;
import com.settle.User;

@WebServlet("/options")
public class OptionsServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String settleCode = request.getParameter("settleCode");
        String userId = request.getParameter("userId");
        if (settleCode == null || userId == null) {
            ServletUtils.setErrorJsonResponse(response, HttpServletResponse.SC_BAD_REQUEST,
                "1 or more query parameters are missing");
            return;
        }

        // Verify settle code
        if (!SettleSessionManager.settleSessionExists(settleCode)) {
            ServletUtils.setErrorJsonResponse(response, HttpServletResponse.SC_BAD_REQUEST,
                "The requested Settle session does not exist");
            return;
        }

        // TODO Verify that the user is part of the Settle

        // Build response
        JsonArray optionsArray = new JsonArray();
        for (String option : SettleSessionManager.getOptionPool(settleCode))
            optionsArray.add(option);
        JsonObject jsonObject = new JsonObject();
        jsonObject.add("optionPool", optionsArray);
        String json = (new Gson()).toJson(jsonObject);

        // response.setContentType("application/json");
        response.setContentType("text/html");
        response.getWriter().println(json);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
    }
}
