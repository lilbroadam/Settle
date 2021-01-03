package com.settle.servlets;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.settle.SettleSessionManager;
import com.settle.SettleSession;
import com.settle.User;

@WebServlet("/createsettle")
public class CreateSettleServlet extends HttpServlet {
    private final String PARAM_USER_NAME = "userName";
    private final String PARAM_USER_ID = "userId";
    private final String PARAM_DEFAULT_OPTION = "defaultOption";
    private final String PARAM_CUSTOM_ALLOWED = "customAllowed";
    private final String DEFAULT_OPTION_MOVIES = "movies";
    private final String DEFAULT_OPTION_RESTAURANTS = "restaurants";
    private final String DEFAULT_OPTION_CUSTOM = "custom";
    private final String RESPONSE_NEW_SETTLE_CODE = "newSettleCode";

    // TODO delete
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Parse request parameters
        String hostName = request.getParameter(PARAM_USER_NAME);
        String hostId = "id123"; // TODO request.getParameter();
        String defaultOption = request.getParameter(PARAM_DEFAULT_OPTION);
        String customAllowedString = request.getParameter(PARAM_CUSTOM_ALLOWED);
        SettleSession.SettleType settleType = SettleSession.SettleType.CUSTOM;
        boolean customChoicesAllowed = false;
        if (defaultOption.equals(DEFAULT_OPTION_MOVIES)) // TODO change to switch/case
            settleType = SettleSession.SettleType.MOVIES;
        else if (defaultOption.equals(DEFAULT_OPTION_RESTAURANTS))
            settleType = SettleSession.SettleType.RESTAURANTS;
        else if (defaultOption.equals(DEFAULT_OPTION_CUSTOM))
            settleType = SettleSession.SettleType.CUSTOM;
        else {
            // TODO
        }
        if (!customAllowedString.equals("true") && !customAllowedString.equals("false")) {
            // TODO
        } else
            customChoicesAllowed = customAllowedString.equals("true") ? true : false;

        // Do request
        User hostUser = new User(hostId, hostName);
        String settleCode = 
            SettleSessionManager.createSettleSession(hostUser, settleType, customChoicesAllowed);

        // Build response
        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty(RESPONSE_NEW_SETTLE_CODE, settleCode);
        String json = (new Gson()).toJson(jsonObject);
        
        response.setContentType("application/json");
        response.getWriter().println(json);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Parse request parameters
        String bodyJson = ServletUtils.getBody(request);

        String hostName = ServletUtils.getJsonProperty(bodyJson, PARAM_USER_NAME);
        String hostId = ServletUtils.getJsonProperty(bodyJson, PARAM_USER_ID);
        String defaultOption = ServletUtils.getJsonProperty(bodyJson, PARAM_DEFAULT_OPTION);
        String customAllowedString = ServletUtils.getJsonProperty(bodyJson, PARAM_CUSTOM_ALLOWED);

        SettleSession.SettleType settleType = SettleSession.SettleType.CUSTOM;
        boolean customChoicesAllowed = false;
        if (defaultOption.equals(DEFAULT_OPTION_MOVIES)) // Convert defaultOption into a SettleSession.SettleType
            settleType = SettleSession.SettleType.MOVIES;
        else if (defaultOption.equals(DEFAULT_OPTION_RESTAURANTS))
            settleType = SettleSession.SettleType.RESTAURANTS;
        else if (defaultOption.equals(DEFAULT_OPTION_CUSTOM))
            settleType = SettleSession.SettleType.CUSTOM;
        else {
            // TODO
            response.getWriter()
                .println("error when parsing defaultOption. Received: " + defaultOption);
        }
        if (customAllowedString.equals(true + "")) // Convert customAllowedString into a boolean
            customChoicesAllowed = true;
        else if (customAllowedString.equals(false + ""))
            customChoicesAllowed = false;
        else {
            // TODO
            response.getWriter()
                .println("error when parsing customAllowed. Received: " + customAllowedString);
        }

        // Do request
        User hostUser = new User(hostId, hostName);
        String settleCode = 
            SettleSessionManager.createSettleSession(hostUser, settleType, customChoicesAllowed);

        // Build response
        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty(RESPONSE_NEW_SETTLE_CODE, settleCode);
        String json = (new Gson()).toJson(jsonObject);
        
        response.setContentType("application/json");
        response.getWriter().println(json);
    }
}
