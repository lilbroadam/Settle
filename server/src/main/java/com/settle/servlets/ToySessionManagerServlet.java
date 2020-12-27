package com.settle.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.sling.commons.json.JSONObject;
import com.settle.SettleSessionManager;

@WebServlet("/toysessionmanager")
public class ToySessionManagerServlet extends HttpServlet {
    final String JOIN_SETTLE_CODE = "joinSettleCode";

    @Override
    public void init() {
        SettleSessionManager.startSessionManager();
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        java.lang.System.out.println("/toysessionmanager.doGet()");
        boolean isRunning = SettleSessionManager.isSessionManagerRunning();
        String sessionCode = SettleSessionManager.createSettleSession();

        response.setContentType("text/html;");
        response.getWriter().println("/toysessionmanager GET");
        response.getWriter().println("SettleSessionManager.isSessionManagerRunning(): " + isRunning);
        response.getWriter().println("Your session code is: " + sessionCode);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        System.out.println(request.getParameter(JOIN_SETTLE_CODE));
    }
}
