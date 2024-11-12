package com.popcornpedia.member.dao;

import java.util.HashMap;

import org.springframework.dao.DataAccessException;

import com.popcornpedia.member.dto.MemberDTO;

public interface MemberDAO {
	// 회원 기본 CRUD
	public int insertMember(MemberDTO memberDTO) throws DataAccessException;
	public int updateMember(MemberDTO memberDTO) throws DataAccessException;
	public int deleteMember(String member_id) throws DataAccessException;
	
	// 중복검사
	public int checkDuplicateId(String member_id) throws DataAccessException;
	public int checkDuplicateEmail(String email) throws DataAccessException;
	public int checkDuplicateNickname(String nickname) throws DataAccessException;
	
	// 로그인 관련
	public MemberDTO selectMemberByIdAndPwd(HashMap<String, Object> loginMap) throws DataAccessException;
	
	// 이메일 인증 관련
	public String getEmailById(String member_id) throws DataAccessException;
	public int setEmailVerified(String member_id) throws DataAccessException;
	public int setEmailNotVerified(String member_id) throws DataAccessException;
	
	// 아이디, 비밀번호 찾기 관련
	public String getIdByEmail(String email) throws DataAccessException;
	public int isMemberExistByIdAndEmail(HashMap<String, Object> memberMap) throws DataAccessException;
	public int resetPwdById(MemberDTO memberDTO) throws DataAccessException;
}
