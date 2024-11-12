package com.popcornpedia.member.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.popcornpedia.member.dto.MemberDTO;

@Repository("memberDAO")
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSession sqlSession;
	
	// 회원 기본 CRUD
	@Override
	public int insertMember(MemberDTO memberDTO) throws DataAccessException {
		return sqlSession.insert("mapper.member.insertMember", memberDTO);
	}

	@Override
	public int updateMember(MemberDTO memberDTO) throws DataAccessException {
		// 마이페이지 회원정보 수정 기능 만들면서 다시 체크하기
		return sqlSession.update("mapper.member.updateMember", memberDTO);
	}

	@Override
	public int deleteMember(String member_id) throws DataAccessException {
		return sqlSession.delete("mapper.member.deleteMember", member_id);
	}

	// 중복검사
	@Override
	public int checkDuplicateId(String member_id) throws DataAccessException {
		return sqlSession.selectOne("mapper.member.checkDuplicateId", member_id);
	}
	
	@Override
	public int checkDuplicateEmail(String email) throws DataAccessException {
		return sqlSession.selectOne("mapper.member.checkDuplicateEmail", email);
	}

	@Override
	public int checkDuplicateNickname(String nickname) throws DataAccessException {
		return sqlSession.selectOne("mapper.member.checkDuplicateNickname", nickname);
	}

	// 아이디, 패스워드로 로그인한 회원 정보 가져오기
	@Override
	public MemberDTO selectMemberByIdAndPwd(HashMap<String, Object> loginMap) throws DataAccessException {
		return sqlSession.selectOne("mapper.member.selectMemberByIdAndPwd", loginMap);
	}

	// 이메일 인증 관련
	@Override
	public String getEmailById(String member_id) throws DataAccessException {
		return sqlSession.selectOne("mapper.member.getEmailById", member_id);
	}
	@Override
	public int setEmailVerified(String member_id) throws DataAccessException {
		return sqlSession.update("mapper.member.setEmailVerified", member_id);
	}
	@Override
	public int setEmailNotVerified(String member_id) throws DataAccessException {
		return sqlSession.update("mapper.member.setEmailNotVerified", member_id);
	}

	// 아이디, 비밀번호 찾기 관련
	@Override
	public String getIdByEmail(String email) throws DataAccessException {
		return sqlSession.selectOne("mapper.member.getIdByEmail", email);
	}

	@Override
	public int isMemberExistByIdAndEmail(HashMap<String, Object> memberMap) throws DataAccessException {
		return sqlSession.selectOne("mapper.member.isMemberExistByIdAndEmail", memberMap);
	}

	@Override
	public int resetPwdById(MemberDTO memberDTO) throws DataAccessException {
		return sqlSession.update("mapper.member.resetPwdById", memberDTO);
	}
}
