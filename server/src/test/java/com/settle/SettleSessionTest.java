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
    private SettleSession settle;

    @Before
    public void beforeTest() {
        settle = new SettleSession(settleCode, hostUser, settleType, customAllowed);
    }

    @Test
    public void testGetSettleCode() {
        Assert.assertEquals(settle.getSettleCode(), settleCode);
    }

    @Test
    public void testGetSettleType() {
        Assert.assertEquals(settle.getSettleType(), settleType);
    }

    @Test
    public void testCustomAllowed() {
        Assert.assertEquals(settle.getCustomChoicesAllowed(), customAllowed);
    }

    @Test
    public void testAddGetOptions() {
        String option1 = "option1";
        String option2 = "option2";

        Assert.assertEquals(settle.getOptionPool().size(), 0);

        settle.addOption(option1);
        Assert.assertEquals(settle.getOptionPool().size(), 1);
        Assert.assertEquals(settle.getOptionPool().get(0), option1);

        settle.addOption(option2);
        Assert.assertEquals(settle.getOptionPool().size(), 2);
        Assert.assertEquals(settle.getOptionPool().get(1), option2);
    }

}
