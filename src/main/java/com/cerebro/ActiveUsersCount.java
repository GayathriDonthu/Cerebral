/*
 * Created on May 7, 2014
 *
 * Copyright 2013 Optum Insight, Inc. All rights reserved.
 * This file contains CONFIDENTIAL and PROPRIETARY information
 * and should not be distributed without prior written permission.
 */
package com.cerebro;

import java.net.URLClassLoader;
import java.util.Arrays;
import java.util.concurrent.atomic.AtomicInteger;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class ActiveUsersCount implements HttpSessionListener {
	private static AtomicInteger	activeSessions	= new AtomicInteger();

	public void sessionCreated(HttpSessionEvent httpSessionEvent) {
		System.out.println("Active users count: " + activeSessions.get());
		System.out.println("Class path location: "
				+ Arrays.toString(((URLClassLoader) ActiveUsersCount.class.getClassLoader()).getURLs()));
		System.out.println("Resources: "
				+ ActiveUsersCount.class.getClassLoader().getResource(
						ActiveUsersCount.class.getName().replace(".", "/") + ".class"));
		activeSessions.incrementAndGet();
	}

	public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
		System.out.println(activeSessions.get());
		if (activeSessions.get() > 0)
			activeSessions.decrementAndGet();
	}

	public static int getActiveSessions() {
		return activeSessions.get();
	}

}
