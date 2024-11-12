package com.popcornpedia.member.service;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import com.popcornpedia.member.dao.MemberDAO;
import com.popcornpedia.member.dto.MemberDTO;

@Service("memberService")
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public int insertMember(MemberDTO memberDTO) throws DataAccessException {
		return memberDAO.insertMember(memberDTO);
		// [TODO] 이메일 인증 요청 필요
	}

	@Override
	public int updateMember(MemberDTO memberDTO) throws DataAccessException {
		return memberDAO.updateMember(memberDTO);
	}

	@Override
	public int deleteMember(String member_id) throws DataAccessException {
		return memberDAO.deleteMember(member_id);
	}

	@Override
	public int checkDuplicateId(String member_id) throws DataAccessException {
		return memberDAO.checkDuplicateId(member_id);
	}

	@Override
	public int checkDuplicateEmail(String email) throws Exception {
		return memberDAO.checkDuplicateEmail(email);
	}

	@Override
	public int checkDuplicateNickname(String nickname) throws DataAccessException {
		return memberDAO.checkDuplicateNickname(nickname);
	}
	
	// 로그인
	@Override
	public MemberDTO checkLogin(HashMap<String, Object> loginMap) throws DataAccessException {
		// 아이디, 비밀번호 전달해 회원 DTO return
		MemberDTO userDTO = memberDAO.selectMemberByIdAndPwd(loginMap);
		return userDTO;
	}

	// 이메일 인증 관련
	@Override
	public String getEmailById(String member_id) throws DataAccessException {
		return memberDAO.getEmailById(member_id);
	}
	@Override
	public int setEmailVerified(String member_id) throws DataAccessException {
		return memberDAO.setEmailVerified(member_id);
	}

	// 아이디, 비밀번호 찾기 관련
	@Override
	public String getIdByEmail(String email) throws DataAccessException {
		return memberDAO.getIdByEmail(email);
	}

	@Override
	public int isMemberExistByIdAndEmail(HashMap<String, Object> memberMap) throws DataAccessException {
		return memberDAO.isMemberExistByIdAndEmail(memberMap);
	}

	@Override
	public int resetPwdById(MemberDTO memberDTO) throws DataAccessException {
		return memberDAO.resetPwdById(memberDTO);
	}
}
