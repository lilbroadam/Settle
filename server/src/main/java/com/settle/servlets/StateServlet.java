package com.settle.servlets;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.settle.SettleSessionManager;
import com.settle.SettleSession;

@WebServlet("/state")
public class StateServlet extends HttpServlet {

    @Override
    public void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Parse request parameters
        String[] parameters = ServletUtils.getAndVerifyParameters(request, response);
        if (parameters == null)
            return;
        String settleCode = parameters[0];
        String userId = parameters[1];
        String bodyJson = ServletUtils.getBody(request);
        String setStateString = ServletUtils.getJsonProperty(bodyJson, "setState");

        // Do request
        SettleSession settle = SettleSessionManager.getSettleSession(settleCode);
        SettleSession.SettleState setState;
        if (setStateString.equalsIgnoreCase(SettleSession.SettleState.LOBBY.name()))
            setState = SettleSession.SettleState.LOBBY;
        else if (setStateString.equalsIgnoreCase(SettleSession.SettleState.SETTLING.name()))
            setState = SettleSession.SettleState.SETTLING;
        else if (setStateString.equalsIgnoreCase(SettleSession.SettleState.COMPLETE.name()))
            setState = SettleSession.SettleState.COMPLETE;
        else {
            ServletUtils.setErrorJsonResponse(response, HttpServletResponse.SC_BAD_REQUEST,
                "Could not convert \"" + setStateString + "\" to a Settle State");
            return;
        }
        settle.setSettleState(setState);

        // Build response
        String json = (new Gson()).toJson(settle.toJson());
        response.setContentType("application/json");
        response.getWriter().println(json);
    }

    
}
