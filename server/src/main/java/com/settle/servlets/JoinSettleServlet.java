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
import com.settle.User;

@WebServlet("/joinsettle")
public class JoinSettleServlet extends HttpServlet {
    private final String PARAM__HOST_NAME = "hostName";
    private final String PARAM_DEFAULT_OPTION = "defaultOption";
    private final String PARAM_CUSTOM_ALLOWED = "customAllowed";
    private final String DEFAULT_OPTION_MOVIES = "movies";
    private final String DEFAULT_OPTION_RESTAURANTS = "restaurants";
    private final String DEFAULT_OPTION_CUSTOM = "custom";
    private final String RESPONSE_NEW_SETTLE_CODE = "newSettleCode";

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Parse request parameters
        String userName = ""; // TODO
        String userId = ""; // TODO
        String joinSettleCode = ""; // TODO

        // Do request
        User user = new User(userId, userName);
        String responseCode = SettleSessionManager.joinSettleSession(joinSettleCode, user);

        // Build response
        if (responseCode == joinSettleCode) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else { 
            StringBuffer sb = new StringBuffer();
            sb.append("{");
            sb.append("\"error\": \"Invalid Settle code\"");
            sb.append("}");
            String json = sb.toString();

            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json");
            response.getWriter().println(json);
        }
    }
}
