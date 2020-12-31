package com.settle;

import java.util.List;
import java.util.ArrayList;

// An object to keep track of a Settle session
public class SettleSession {

    public enum SettleType { 
        CUSTOM,
        MOVIES,
        RESTAURANTS
    }

    private String settleCode;
    private User hostUser;
    private SettleType settleType;
    private boolean customChoicesAllowed;
    private List<User> users = new ArrayList<>();

    // Create a Settle session with settle code settleCode
    public SettleSession(String settleCode, User hostUser, 
            SettleType settleType, boolean customChoicesAllowed) {

        this.settleCode = settleCode;
        this.hostUser = hostUser;
        this.settleType = settleType;
        this.customChoicesAllowed = customChoicesAllowed;

        addUser(hostUser);
    }

    public void addUser(User user) {
        users.add(user);
    }

    public User getHostUser() {
        return hostUser;
    }
    
    public List<User> getUsers() {
        return users;
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
