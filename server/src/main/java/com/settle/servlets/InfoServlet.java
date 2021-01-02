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
        JsonObject jsonObject = new JsonObject();

        // Add users to response
        JsonArray usersArray = new JsonArray();
        for (User user : SettleSessionManager.getUsers(settleCode))
            usersArray.add(user.getName());
        jsonObject.add("users", usersArray);

        // Add settle state to response
        SettleSession.SettleState state = SettleSessionManager.getSettleState(settleCode);
        jsonObject.addProperty("state", state.name().toLowerCase());

        String json = (new Gson()).toJson(jsonObject);
        // response.setContentType("application/json");
        response.setContentType("text/html");
        response.getWriter().println(json);
    }
}
