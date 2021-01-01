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
    private final String PARAM_HOST_NAME = "hostName";
    private final String PARAM_DEFAULT_OPTION = "defaultOption";
    private final String PARAM_CUSTOM_ALLOWED = "customAllowed";
    private final String DEFAULT_OPTION_MOVIES = "movies";
    private final String DEFAULT_OPTION_RESTAURANTS = "restaurants";
    private final String DEFAULT_OPTION_CUSTOM = "custom";
    private final String RESPONSE_NEW_SETTLE_CODE = "newSettleCode";

    @Override
    public void init() {
        // SettleSessionManager.startSessionManager();
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // boolean isRunning = SettleSessionManager.isSessionManagerRunning();

        // Parse request parameters
        String hostName = request.getParameter(PARAM_HOST_NAME);
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
        String settleCode = SettleSessionManager.createSettleSession(hostUser, settleType, customChoicesAllowed);

        // Build response
        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty(RESPONSE_NEW_SETTLE_CODE, settleCode);
        String json = (new Gson()).toJson(jsonObject);
        
        response.setContentType("application/json");
        response.getWriter().println(json);
    }
}
