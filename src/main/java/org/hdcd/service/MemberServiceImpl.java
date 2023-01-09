package org.hdcd.service;

import java.util.List;

import org.hdcd.domain.Member;
import org.hdcd.domain.MemberAuth;
import org.hdcd.mapper.MemberMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class MemberServiceImpl implements MemberService {

	private final MemberMapper mapper;
	
	@Override
	public int countAll() throws Exception {
		return mapper.countAll();
	}
	
	@Transactional
	@Override
	public void setupAdmin(Member member) throws Exception {
		mapper.create(member);
		
		MemberAuth memberAuth = new MemberAuth();

		memberAuth.setUserNo(member.getUserNo());
		memberAuth.setAuth("ROLE_ADMIN");

		mapper.createAuth(memberAuth);
	}
	
	@Transactional
	@Override
	public void register(Member member) throws Exception {
		mapper.create(member);
		
		MemberAuth memberAuth = new MemberAuth();

		memberAuth.setUserNo(member.getUserNo());
		memberAuth.setAuth("ROLE_MEMBER");

		mapper.createAuth(memberAuth);
	}

	@Override
	public Member read(Long userNo) throws Exception {
		return mapper.read(userNo);
	}

	@Transactional
	@Override
	public void modify(Member member) throws Exception {
		mapper.update(member);

		long userNo = member.getUserNo();

		mapper.deleteAuth(userNo);

		List<MemberAuth> authList = member.getAuthList();

		for (int i = 0; i < authList.size(); i++) {
			MemberAuth memberAuth = authList.get(i);

			String auth = memberAuth.getAuth();

			if (auth == null) {
				continue;
			}

			if (auth.trim().length() == 0) {
				continue;
			}

			memberAuth.setUserNo(userNo);

			mapper.createAuth(memberAuth);
		}
	}

	@Transactional
	@Override
	public void remove(Long userNo) throws Exception {
		mapper.deleteAuth(userNo);

		mapper.delete(userNo);
	}

	@Override
	public List<Member> list() throws Exception {
		return mapper.list();
	}

	@Override
	public int getCoin(Long userNo) throws Exception {
		Member member = mapper.read(userNo);
		
		return member.getCoin();
	}
	
}
