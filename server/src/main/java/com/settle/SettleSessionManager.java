package com.settle;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Set;
import java.util.HashSet;
import com.settle.SettleSession;
import com.settle.SettleSessionCodeManager;
import com.settle.User;

public class SettleSessionManager {

    private static Map<String, SettleSession> settleSessionsMap = new HashMap<>();
    private static final Object settleSessionMapLock = new Object();

    // TODO change to return a SettleSesion object
    // Create a Settle session and return it's session code
    public static String createSettleSession(
            User hostUser, SettleSession.SettleType settleType, boolean customChoicesAllowed) {

        synchronized(settleSessionMapLock) {
            String newSessionCode = SettleSessionCodeManager.generateSettleSessionCode();

            SettleSession session = 
                new SettleSession(newSessionCode, hostUser, settleType, customChoicesAllowed);
            settleSessionsMap.put(newSessionCode, session);

            return newSessionCode;
        }
    }

    // Return the SettleSession associated with the given Settle code,
    // return null if the SettleSession doesn't exist.
    public static SettleSession getSettleSession(String settleCode) {
        synchronized(settleSessionMapLock) {
            return settleSessionsMap.get(settleCode);
        }
    }

    // Return true if a Settle session with the given Settle code exists, false if not.
    public static boolean settleSessionExists(String settleCode) {
        synchronized(settleSessionMapLock) {
            return settleSessionsMap.get(settleCode) != null;
        }
    }

    private static void printSettleSessions() {
        synchronized(settleSessionMapLock) {
            java.lang.System.out.println("Settle sessions:");
            for (String settleCode: settleSessionsMap.keySet()) {
                java.lang.System.out.println("\t" + settleCode);
            }
        }
    }
}
