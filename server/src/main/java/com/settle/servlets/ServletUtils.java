package com.settle.servlets;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.util.stream.Collectors;
import com.settle.SettleSessionManager;

public class ServletUtils {

    // Given a HttpServletRequest, return the body of the request as a String
    public static String getBody(HttpServletRequest request) throws IOException {
        return request.getReader().lines().collect(Collectors.joining());
    }

    // Given a JSON in String format, return the given property in the JSON as a String.
    // If the property is a String, return the property without quotations in the String.
    public static String getJsonProperty(String json, String property) {
        property = JsonParser.parseString(json).getAsJsonObject().get(property).toString();

        if (property.charAt(0) == '"')
            property = property.substring(1);
        if (property.charAt(property.length() - 1) == '"')
            property = property.substring(0, property.length() - 1);

        return property;
    }

    // Set the status code and body error message of the given HttpServletResponse.
    public static void setErrorJsonResponse(
            HttpServletResponse response, int statusCode, String errorMessage) throws IOException {
        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("error", errorMessage);
        String json = (new Gson()).toJson(jsonObject);

        response.setStatus(statusCode);
        response.setContentType("application/json");
        response.getWriter().println(json);
    }

    // Return a String array of length 2 with the Settle code in index 0 and the user ID in index 1.
    // If either query parameter is missing, the requested Settle code doesn't exist, or the given 
    // user ID is not apart of the given Settle, return null and set the error message response.
    public static String[] getAndVerifyParameters(
            HttpServletRequest request, HttpServletResponse response) throws IOException {
        String settleCode = request.getParameter("settleCode");
        String userId = request.getParameter("userId");
        if (settleCode == null || userId == null) {
            ServletUtils.setErrorJsonResponse(response, HttpServletResponse.SC_BAD_REQUEST,
                "1 or more query parameters are missing");
            return null;
        }

        // Verify settle code
        if (!SettleSessionManager.settleSessionExists(settleCode)) {
            ServletUtils.setErrorJsonResponse(response, HttpServletResponse.SC_BAD_REQUEST,
                "The requested Settle session does not exist");
            return null;
        }

        // TODO Verify that the user is part of the Settle

        return new String[]{settleCode, userId};
    }
}
