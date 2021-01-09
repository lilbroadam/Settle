package com.settle;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonPrimitive;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.Random;

// An object to keep track of a Settle session
public class SettleSession {

    public enum SettleType { CUSTOM, MOVIES, RESTAURANTS }
    public enum SettleState { LOBBY, SETTLING, COMPLETE }

    private final String settleCode;
    private final SettleType settleType;
    private final boolean customChoicesAllowed;
    private final User hostUser;
    private SettleState settleState;
    private List<User> users;
    private List<String> options;
    private Map<String, Integer> voteMap;
    private String settleResult;

    private int usersDone;
    private List<String> finishedUsers;
    
    // Create a Settle session with settle code settleCode
    public SettleSession(String settleCode, User hostUser, 
            SettleType settleType, boolean customChoicesAllowed) {

        this.settleCode = settleCode;
        this.hostUser = hostUser;
        this.settleType = settleType;
        this.customChoicesAllowed = settleType == SettleType.CUSTOM ? true : customChoicesAllowed;
        this.settleState = SettleState.LOBBY;
        this.users = new ArrayList<>();
        this.options = new ArrayList<>();
        this.voteMap = new HashMap<>();

        this.usersDone = 0;
        //this.finishedUsers = new ArrayList<>();

        addUser(hostUser);
    }

    // Add a User to this Settle
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

                options.add(option);
            }
        }
    }

    // TODO change so that SettleState can't move backwards
    public void setSettleState(SettleState state) {
        synchronized (this) {
            settleState = state;
        }
    }

    public void submitVote(String voteOption) {
        synchronized (this) {
            if (settleState == SettleState.SETTLING) {
                Integer i = voteMap.get(voteOption);
                if (i == null)
                    voteMap.put(voteOption, 1);
                else
                    voteMap.put(voteOption, i + 1);
            } else {
                // TODO Reject request
            }
        }
    }

    public void userFinished(String user){
        //finishedUsers.add(user);
        usersDone++;

        if (usersDone == users.size()){
            settleResult = evaluateResult();
        }
    }

    public String getSettleCode() {
        synchronized (this) {
            return settleCode;
        }
    }

    public SettleType getSettleType() {
        synchronized (this) {
            return settleType;
        }
    }

    public boolean getCustomChoicesAllowed() {
        synchronized (this) {
            return customChoicesAllowed;
        }
    }

    public SettleState getSettleState() {
        synchronized (this) {
            return settleState;
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

    // TODO change from String to custom objects
    public List<String> getOptions() {
        synchronized (this) {
            return options;
        }
    }

    public String evaluateResult() {
        List<String> results = new ArrayList<>();
        int mostVotes = Integer.MIN_VALUE;
        for (Map.Entry<String,Integer> entry : voteMap.entrySet()){
            if (entry.getValue() > mostVotes){
                results.clear();
                mostVotes = entry.getValue();
                results.add(entry.getKey());
            } else if (entry.getValue() == mostVotes){
                results.add(entry.getKey()); 
            }
        }
        return results.get((int)(Math.random() * (results.size() - 0 + 1)));
    }
    
    public JsonPrimitive getSettleCodeJson() {
        synchronized (this) {
            return new JsonPrimitive(settleCode);
        }
    }

    public JsonPrimitive getSettleTypeJson() {
        synchronized (this) {
            return new JsonPrimitive(settleType.name().toLowerCase());
        }
    }

    public JsonPrimitive getCustomChoicesAllowedJson() {
        synchronized (this) {
            return new JsonPrimitive(customChoicesAllowed);
        }
    }

    public JsonPrimitive getSettleStateJson() {
        synchronized (this) {
            return new JsonPrimitive(settleState.name().toLowerCase());
        }
    }

    public JsonArray getUsersJson() {
        synchronized (this) {
            JsonArray jsonArray = new JsonArray();
            for (User user : users)
                jsonArray.add(user.getName());
            return jsonArray;
        }
    }

    public JsonArray getOptionsJson() {
        synchronized (this) {
            JsonArray jsonArray = new JsonArray();
            for (String option : options)
                jsonArray.add(option);
            return jsonArray;
        }
    }

    public JsonPrimitive getResultJson() {
        synchronized (this) {
            return new JsonPrimitive(settleResult == null ? "" : settleResult);
        }
    }

    public JsonObject toJson() {
        synchronized (this) {
            JsonObject jsonObject = new JsonObject();
            jsonObject.add("settleCode", getSettleCodeJson());
            jsonObject.add("settleType", getSettleTypeJson());
            jsonObject.add("customAllowed", getCustomChoicesAllowedJson());
            jsonObject.add("settleState", getSettleStateJson());
            jsonObject.add("users", getUsersJson());
            jsonObject.add("options", getOptionsJson());
            jsonObject.add("result", getResultJson());

            return jsonObject;
        }
    }

}
