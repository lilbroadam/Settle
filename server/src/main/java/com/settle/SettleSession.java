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

    private final String settleCode;
    private final User hostUser;
    private final SettleType settleType;
    private final boolean customChoicesAllowed;
    private SettleState settleState;
    private List<User> users;
    private List<String> optionPool;

    // Create a Settle session with settle code settleCode
    public SettleSession(String settleCode, User hostUser, 
            SettleType settleType, boolean customChoicesAllowed) {

        this.settleCode = settleCode;
        this.hostUser = hostUser;
        this.settleType = settleType;
        this.customChoicesAllowed = customChoicesAllowed;

        this.settleState = SettleState.LOBBY;
        this.users = new ArrayList<>();
        this.optionPool = new ArrayList<>();

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
