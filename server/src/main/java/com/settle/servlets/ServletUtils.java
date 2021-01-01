package com.settle.servlets;

import com.google.gson.JsonParser;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.util.stream.Collectors;

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
}
