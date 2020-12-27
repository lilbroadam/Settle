package com.settle;

import java.lang.Runnable;
import java.lang.Thread;
import java.util.Set;

public class SettleSessionManager {

    private static String sessionManagerThreadName = "Settle Session Manager";
    private static Thread sessionManagerThread = null;
    private static boolean stopRequested = false;
    private static final Object lock = new Object();

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

    public static void requestStopSessionManager() {
        synchronized(lock) {
            stopRequested = true;
            java.lang.System.out.println("SettleSessionManager stop requested");
        }
    }

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
}
