package com.settle;

import java.lang.StringBuffer;
import java.util.Set;
import java.util.HashSet;

public class SettleSessionCodeManager {
    private static Set<String> codesBeingUsed = new HashSet<>();
    private static String nextSessionCode = "aaa";

    public static synchronized String generateSettleSessionCode() {
        String sessionCode = next();
        while (codesBeingUsed.contains(sessionCode)) {
            sessionCode = next();
        }
        codesBeingUsed.add(sessionCode);

        return sessionCode;
    }

    // TODO: make method iterate through supported codes properly
    private static synchronized String next() {
        String sessionCode = nextSessionCode;

        // Set the next session code
        StringBuffer stringBuffer = new StringBuffer();
        char[] chars = nextSessionCode.toCharArray();
        for (char c : chars) {
            c = (char) (c + 1);
            stringBuffer.append(c);
        }
        nextSessionCode = stringBuffer.toString();

        return sessionCode;
    }

    // Call this method when a Settle session is finished so it's code can be reused for
    // other Settle sessions.
    public static synchronized void recycleSettleSessionCode(String sessionCode) {
        codesBeingUsed.remove(sessionCode);
    }
}
