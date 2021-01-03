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

    public enum SettleState {
        LOBBY,
        SETTLING,
        COMPLETE
    }

    private String settleCode;
    private User hostUser;
    private SettleType settleType;
    private SettleState settleState;
    private boolean customChoicesAllowed;
    private List<User> users = new ArrayList<>();
    private List<String> optionPool = new ArrayList<>();

    // Create a Settle session with settle code settleCode
    public SettleSession(String settleCode, User hostUser, 
            SettleType settleType, boolean customChoicesAllowed) {

        this.settleCode = settleCode;
        this.hostUser = hostUser;
        this.settleType = settleType;
        this.settleState = SettleState.LOBBY;
        this.customChoicesAllowed = customChoicesAllowed;

        addUser(hostUser);
    }

    public void addUser(User user) {
        synchronized (this) {
            users.add(user);
        }
    }

    public void addOption(String option) {
        synchronized (this) {
            // Options can only be added when in the lobby state
            if (settleState == SettleState.LOBBY) {
                // TODO check for duplicated

                optionPool.add(option);
            }
        }
    }

    public void setSettleState(SettleState state) {
        synchronized (this) {
            settleState = state;
        }
    }

    public User getHostUser() {
        synchronized (this) {
            return hostUser;
        }
    }
    
    public List<User> getUsers() {
        synchronized (this) {
            return users;
        }
    }

    public SettleType getSettleType() {
        synchronized (this) {
            return settleType;
        }
    }

    public SettleState getSettleState() {
        synchronized (this) {
            return settleState;
        }
    }

    // TODO change from String to custom objects
    public List<String> getOptionPool() {
        synchronized (this) {
            return optionPool;
        }
    }

    public boolean getCustomChoicesAllowed() {
        synchronized (this) {
            return customChoicesAllowed;
        }
    }

    public String getSettleCode() {
        synchronized (this) {
            return settleCode;
        }
    }
}
