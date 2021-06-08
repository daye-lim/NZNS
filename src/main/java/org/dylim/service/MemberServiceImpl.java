package org.dylim.service;

import org.dylim.domain.memberVO;
import org.dylim.domain.member_bVO;
import org.dylim.domain.member_iVO;
import org.dylim.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper membermapper;
	
	@Override
	public void m_register(member_iVO member) throws Exception {
		membermapper.m_register(member);		
	}

	@Override
	public int idCheck(String id) throws Exception {
		return membermapper.idCheck(id);
	}
	

	@Override
	public memberVO Login(memberVO Allmember) throws Exception {
		return membermapper.Login(Allmember);
	}

	@Override
	public void b_register(member_bVO b_member) throws Exception {
		membermapper.b_register(b_member);
		
	}

	@Override
	public member_iVO readMember(String id, String password) throws Exception {	
		return membermapper.readMember(id, password);
	}

	@Override
	public member_bVO readAgent(String id, String password) throws Exception {
		return membermapper.readAgent(id, password);
	}

	@Override
	public void updateAgent(member_bVO b_member) throws Exception {
				membermapper.updateAgent(b_member);
			}

	@Override
	public void updateMember(member_iVO member) throws Exception {
		    	membermapper.updateMember(member);
		
	}

	@Override
	public void deleteMember(String id) throws Exception {
				membermapper.deleteMember(id);		
	}

	@Override
	public void deleteAgent(String id) throws Exception {
				membermapper.deleteAgent(id);
	}




}
