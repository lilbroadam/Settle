package com.settle.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.sling.commons.json.JSONObject;
import org.apache.sling.commons.json.JSONException;
import com.settle.SettleSessionManager;
import com.settle.SettleSession;

@WebServlet("/createsettle")
public class CreateSettleServlet extends HttpServlet {
    private final String PARAM__HOST_NAME = "hostName";
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

        SettleSession.SettleType settleType = SettleSession.SettleType.CUSTOM;
        boolean customChoicesAllowed = false;

        String hostName = request.getParameter(PARAM__HOST_NAME);
        String defaultOption = request.getParameter(PARAM_DEFAULT_OPTION);
        String customAllowedString = request.getParameter(PARAM_CUSTOM_ALLOWED);
        if (defaultOption.equals(DEFAULT_OPTION_MOVIES))
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

        String settleCode = SettleSessionManager.createSettleSession(hostName, settleType, customChoicesAllowed);

        String json = "";
        try {
            JSONObject jsonBuilder = new JSONObject();
            jsonBuilder.put(RESPONSE_NEW_SETTLE_CODE, settleCode);
            json = jsonBuilder.toString();
        } catch (JSONException e) {
            System.out.println("Error while building JSON file.");
            System.out.println(e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }

        // Response with a JSON
        response.setContentType("application/json");
        response.getWriter().println(json);
    }
}
