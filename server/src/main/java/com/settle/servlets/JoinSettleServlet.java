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

@WebServlet("/joinsettle")
public class JoinSettleServlet extends HttpServlet {
    private final String PARAM_USER_NAME = "userName";
    private final String PARAM_USER_ID = "userId";
    private final String PARAM_DEFAULT_OPTION = "defaultOption";
    private final String PARAM_CUSTOM_ALLOWED = "customAllowed";
    private final String DEFAULT_OPTION_MOVIES = "movies";
    private final String DEFAULT_OPTION_RESTAURANTS = "restaurants";
    private final String DEFAULT_OPTION_CUSTOM = "custom";
    private final String RESPONSE_NEW_SETTLE_CODE = "newSettleCode";

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Parse request parameters
        String bodyJson = ServletUtils.getBody(request);

        String userName = ServletUtils.getJsonProperty(bodyJson, PARAM_USER_NAME);
        String userId = ServletUtils.getJsonProperty(bodyJson, PARAM_USER_ID);
        String joinSettleCode = ServletUtils.getJsonProperty(bodyJson, "joinSettleCode");

        if (!SettleSessionManager.settleSessionExists(joinSettleCode)) {
            ServletUtils.setErrorJsonResponse(
                response, HttpServletResponse.SC_BAD_REQUEST, "Invalid Settle code");
            return;
        }

        // Do request
        User user = new User(userId, userName);
        SettleSessionManager.getSettleSession(joinSettleCode).addUser(user);
    }
}
