package com.settle;

import org.junit.After;
import org.junit.Before;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

@RunWith(JUnit4.class)
public class UserTest {

    private String userId = "abc123";
    private String userName = "First Last";
    private User user;

    @Before
    public void beforeTest() {
        user = new User(userId, userName);
    }

    @Test
    // Test getting user's ID
    public void testGetUserId() {
        Assert.assertEquals(user.getId(), userId);
    }

    @Test
    // Test getting user's name
    public void testGetUserName() {
        Assert.assertEquals(user.getName(), userName);
    }

}