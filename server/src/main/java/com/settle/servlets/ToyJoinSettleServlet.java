package com.settle.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.settle.SettleSessionManager;
import com.settle.servlets.ServletUtils;

@WebServlet("/toyjoinsettle")
public class ToyJoinSettleServlet extends HttpServlet {
    final String JOIN_SETTLE_CODE = "joinSettleCode";

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        java.lang.System.out.println("/toyjoinsettle.doGet()");
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String bodyJson = ServletUtils.getBody(request);
        String joinCode = ServletUtils.getJsonProperty(bodyJson, JOIN_SETTLE_CODE);
        
        response.setContentType("text/html");
        response.getWriter().println("extracted settle code: " + joinCode);
    }
}
