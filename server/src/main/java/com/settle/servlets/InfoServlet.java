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

@WebServlet("/info")
public class InfoServlet extends HttpServlet {
    
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Parse request parameters
        String[] parameters = ServletUtils.getAndVerifyParameters(request, response);
        if (parameters == null)
            return;
        String settleCode = parameters[0];
        String userId = parameters[1];

        // Build response
        SettleSession settleSession = SettleSessionManager.getSettleSession(settleCode);
        JsonObject jsonObject = new JsonObject();

        // Add users to response
        JsonArray jsonArray = new JsonArray();
        for (User user : settleSession.getUsers())
            jsonArray.add(user.getName());
        jsonObject.add("users", jsonArray);

        // Add Settle state to response
        SettleSession.SettleState state = settleSession.getSettleState();
        jsonObject.addProperty("state", state.name().toLowerCase());

        // Add Settle options to response
        List<String> optionPool = settleSession.getOptionPool();
        jsonArray = new JsonArray();
        for (String option : optionPool)
            jsonArray.add(option);
        jsonObject.add("optionPool", jsonArray);
        
        String json = (new Gson()).toJson(jsonObject);

        response.setContentType("application/json");
        response.getWriter().println(json);
    }
}
