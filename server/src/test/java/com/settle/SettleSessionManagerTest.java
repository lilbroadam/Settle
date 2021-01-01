package com.settle;

import java.util.List;
import org.junit.After;
import org.junit.Before;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

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
        String code2 = SettleSessionManager.joinSettleSession(code1, user2);
        Assert.assertEquals(code1, code2);

        List<User> users = SettleSessionManager.getUsers(code1);
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

        String code2 = SettleSessionManager.joinSettleSession(differentCode, user2);
        Assert.assertEquals(code2, null);
    }
}