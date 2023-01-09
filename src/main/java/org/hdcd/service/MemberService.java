package org.hdcd.service;

import java.util.List;

import org.hdcd.domain.Member;

public interface MemberService {
	
	public int countAll() throws Exception;
	
	public void setupAdmin(Member member) throws Exception;

	public void register(Member member) throws Exception;
	
	public Member read(Long userNo) throws Exception;

	public void modify(Member member) throws Exception;

	public void remove(Long userNo) throws Exception;

	public List<Member> list() throws Exception;
	
	public int getCoin(Long userNo) throws Exception;
	
}
