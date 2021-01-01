package com.settle.servlets;

import com.google.gson.JsonParser;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.util.stream.Collectors;

public class ServletUtils {

    public static String getBody(HttpServletRequest request) throws IOException {
        return request.getReader().lines().collect(Collectors.joining());
    }

    public static String getJsonProperty(String json, String property) {
        return JsonParser.parseString(json).getAsJsonObject().get(property).toString();
    }
}