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

@WebServlet("/createsettle")
public class CreateSettleServlet extends HttpServlet {
    private final String NEW_SETTLE_CODE = "newSettleCode";

    @Override
    public void init() {
        // SettleSessionManager.startSessionManager();
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // boolean isRunning = SettleSessionManager.isSessionManagerRunning();
        String settleCode = SettleSessionManager.createSettleSession();

        String json = "";
        try {
            JSONObject jsonBuilder = new JSONObject();
            jsonBuilder.put(NEW_SETTLE_CODE, settleCode);
            json = jsonBuilder.toString();
        } catch (JSONException e) {
            System.out.println("Error while building JSON file.");
            System.out.println(e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }

        // Response with a JSON
        response.setContentType("application/json;");
        response.getWriter().println(json);
    }
}
