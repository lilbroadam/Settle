package com.settle;

import org.junit.After;
import org.junit.Before;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

@RunWith(JUnit4.class)
public class SettleSessionTest {

    private String settleCode = "aaa";
    private User hostUser = new User("id123", "First Last");
    private SettleSession.SettleType settleType = SettleSession.SettleType.CUSTOM;
    private boolean customAllowed = false;
    private SettleSession session;

    @Before
    public void beforeTest() {
        session = new SettleSession(settleCode, hostUser, settleType, customAllowed);
    }

    @Test
    public void testGetSettleCode() {
        Assert.assertEquals(session.getSettleCode(), settleCode);
    }

    @Test
    public void testGetSettleType() {
        Assert.assertEquals(session.getSettleType(), settleType);
    }

    @Test
    public void testCustomAllowed() {
        Assert.assertEquals(session.getCustomChoicesAllowed(), customAllowed);
    }

}