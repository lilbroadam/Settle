package com.settle;

import java.util.List;
import org.junit.After;
import org.junit.Before;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;
import com.settle.SettleSession;

@RunWith(JUnit4.class)
public class SettleSessionManagerTest {

    private SettleSession.SettleType settleType = SettleSession.SettleType.CUSTOM;
    private boolean customAllowed = true;
    private User user1 = new User("id1", "User 1");
    private User user2 = new User("id2", "User 2");

    @Test
    public void testCreateSettleSession() {
        String code = SettleSessionManager.createSettleSession(user1, settleType, customAllowed);
        Assert.assertNotEquals(code, null);
    }

    @Test
    public void testMultipleCreateSettleSession() {
        String code1 = SettleSessionManager.createSettleSession(user1, settleType, customAllowed);
        String code2 = SettleSessionManager.createSettleSession(user1, settleType, customAllowed);
        String code3 = SettleSessionManager.createSettleSession(user1, settleType, customAllowed);

        Assert.assertNotEquals(code1, code2);
        Assert.assertNotEquals(code1, code3);
        Assert.assertNotEquals(code2, code3);
    }

    @Test
    public void testJoinSettleSession() {
        String code1 = SettleSessionManager.createSettleSession(user1, settleType, customAllowed);
        SettleSession settleSession = SettleSessionManager.getSettleSession(code1);
        settleSession.addUser(user2);

        List<User> users = settleSession.getUsers();
        Assert.assertEquals(users.contains(user1), true);
        Assert.assertEquals(users.contains(user2), true);
        Assert.assertEquals(users.size(), 2);
    }

    @Test
    public void TestJoinSettleSessionNotExists() {
        String code1 = SettleSessionManager.createSettleSession(user1, settleType, customAllowed);
        char[] chars = code1.toCharArray();
        chars[0]++;
        String differentCode = new String(chars);

        SettleSession settleSession = SettleSessionManager.getSettleSession(differentCode);
        Assert.assertEquals(settleSession == null, true);

        Assert.assertEquals(SettleSessionManager.settleSessionExists(differentCode), false);
    }
}