package com.settle;

// An object to keep track of a Settle session
public class SettleSession {

    private String settleCode;

    // Create a Settle session with settle code settleCode
    public SettleSession(String settleCode) {
        this.settleCode = settleCode;
    }

    public String getSettleCode() {
        return settleCode;
    }
}
