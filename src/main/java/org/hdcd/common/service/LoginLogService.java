package org.hdcd.common.service;

import java.util.List;

import org.hdcd.common.domain.LoginLog;

public interface LoginLogService {

	public void register(LoginLog loginLog) throws Exception;

	public List<LoginLog> list() throws Exception;

}
