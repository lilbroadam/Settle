package com.settle;

import java.lang.Runnable;
import java.lang.Thread;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Set;
import java.util.HashSet;
import com.settle.SettleSession;
import com.settle.SettleSessionCodeManager;
import com.settle.User;

public class SettleSessionManager {

    private static String sessionManagerThreadName = "Settle Session Manager";
    private static Thread sessionManagerThread = null;
    private static boolean stopRequested = false;
    private static final Object lock = new Object();
    private static Map<String, SettleSession> settleSessionsMap = new HashMap<>();
    private static final Object settleSessionMapLock = new Object();

    public static class SettleSessionManagerRunnable implements Runnable {

        @Override
        public void run() {
            java.lang.System.out.println("SettleSessionManagerRunnable.run()");

            while (!stopRequested) {
                try {
                    // Thread.sleep(1000);
                    sessionManagerThread.sleep(2000);
                    System.out.println(".");
                } catch (Exception e) {
                    java.lang.System.out.println(e);
                }
            }

            java.lang.System.out.println("Ending SettleSessionManagerRunnable");
        }
    }

    // Start the Settle Session Manager if it isn't already running
    public static void startSessionManager() {
        synchronized(lock) {
            java.lang.System.out.println("SettleSessionManager.startSessionManager()");

            if (sessionManagerThread != null)
                java.lang.System.out.println("Recovered thread: " + sessionManagerThread);
            else
                java.lang.System.out.println("Recovered thread: " + "null");

            if (!isSessionManagerRunning()) {
                Runnable sessionManagerRunnable = new SettleSessionManagerRunnable();
                sessionManagerThread = new Thread(sessionManagerRunnable, sessionManagerThreadName);
                sessionManagerThread.start();
                System.out.println("\tsessionManagerThread started = " + sessionManagerThread.getId());
            } else {
                System.out.println("Session Manager already running = " + sessionManagerThread.getId());
            }
        }
    }

    // Stop the Settle Session Manager as soon as it can.
    public static void requestStopSessionManager() {
        synchronized(lock) {
            stopRequested = true;
            java.lang.System.out.println("SettleSessionManager stop requested");
        }
    }

    // Return true if the Settle Session Manager is running, false if it isn't
    public static boolean isSessionManagerRunning() {
        synchronized(lock) {
            System.out.println("SessionManager.isSessionManagerRunning()");
            if (sessionManagerThread != null) {
                System.out.println("\tsessionManagerThread = " + sessionManagerThread);
                System.out.println("\tsessionManagerThread.isAlive() = " + sessionManagerThread.isAlive());
            } else {
                System.out.println("\tsessionManagerThread = " + "null");
                System.out.println("\tsessionManagerThread.isAlive() = " + "null");
            }
            
            return sessionManagerThread != null && sessionManagerThread.isAlive();
        }
    }

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
