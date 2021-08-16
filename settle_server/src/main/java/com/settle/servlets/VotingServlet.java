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
import com.settle.servlets.ServletUtils;

@WebServlet("/voting")
public class VotingServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Parse request parameters
        String[] parameters = ServletUtils.getAndVerifyParameters(request, response);
        if (parameters == null)
            return;
        String settleCode = parameters[0];
        String userId = parameters[1];
        String bodyJson = ServletUtils.getBody(request);
        String voteOption = ServletUtils.getJsonProperty(bodyJson, "voteOption");
        boolean userFinished = ServletUtils.getJsonProperty(bodyJson, "userDone").equalsIgnoreCase("true");
        
        // Do request
        SettleSession settleSession = SettleSessionManager.getSettleSession(settleCode);
        if (userFinished){
            settleSession.userFinished(userId);
        } else {
            settleSession.submitVote(voteOption);
        }
        
        // Build response
        String json = (new Gson()).toJson(settleSession.toJson());
        response.setContentType("application/json");
        response.getWriter().println(json);
    }

}
