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

    private static synchronized String next() {
        String sessionCode = nextSessionCode;

        // Set the next session code
        StringBuffer stringBuffer = new StringBuffer();
        char[] chars = nextSessionCode.toCharArray();
        int index = chars.length - 1;
        boolean isChanged = false;
        while(index >= 0) {
            if (chars[index] != 'z') {
                chars[index]++;
                isChanged = true;
                break;
            } else {
                chars[index] = 'a';
                index--;
            }
        }
        // check if reached max number of current code length
        if (isChanged) {
            for (char c : chars)
                stringBuffer.append(c);
        } else {
            stringBuffer = new StringBuffer();
            for(int i = 0; i < chars.length + 1; i++)
                stringBuffer.append('a');
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
