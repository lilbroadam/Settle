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

    // Join a User to a Settle session. 
    // Return the settleCode if user was added to the session, return null if not.
    public static String joinSettleSession(String settleCode, User user) {
        synchronized(settleSessionMapLock) {
            SettleSession session = settleSessionsMap.get(settleCode);
            if (session != null) {
                session.addUser(user);
                return settleCode;
            } else {
                // TODO throw custom exception
                return null;
            }
        }
    }

    public static void addOption(String settleCode, String option) {
        synchronized(settleSessionMapLock) {
            SettleSession session = settleSessionsMap.get(settleCode);
            session.addOption(option);
        }
    }

    // Return a List of Users in the given Settle session, return null if session not found
    public static List<User> getUsers(String settleCode) {
        synchronized(settleSessionMapLock) {
            SettleSession session = settleSessionsMap.get(settleCode);
            if (session != null) {
                return session.getUsers();
            } else {
                return null;
            }
        }
    }

    // Return the current state of the Settle session.
    public static SettleSession.SettleState getSettleState(String settleCode) {
        synchronized(settleSessionMapLock) {
            return settleSessionsMap.get(settleCode).getSettleState();
        }
    }

    // Return the option pool of the given Settle session
    public static List<String> getOptionPool(String settleCode) {
        synchronized(settleSessionMapLock) {
            return settleSessionsMap.get(settleCode).getOptionPool();
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
