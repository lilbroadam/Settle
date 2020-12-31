package com.settle;

// An object to keep track of a Settle session
public class SettleSession {

    public enum SettleType { 
        CUSTOM,
        MOVIES,
        RESTAURANTS
    }

    private String settleCode;
    private String hostName;
    private SettleType settleType;
    private boolean customChoicesAllowed;

    // Create a Settle session with settle code settleCode
    public SettleSession(String settleCode, String hostName,
            SettleType settleType, boolean customChoicesAllowed) {

        this.settleCode = settleCode;
        this.hostName = hostName;
        this.settleType = settleType;
        this.customChoicesAllowed = customChoicesAllowed;
    }

    public SettleType getSettleType() {
        return settleType;
    }

    public boolean getCustomChoicesAllowed() {
        return customChoicesAllowed;
    }

    public String getSettleCode() {
        return settleCode;
    }
}
