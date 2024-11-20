package com.popcornpedia.admin.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.popcornpedia.member.dto.MemberDTO;

@Repository("AdminMemberDAO")
public class AdminMemberDAOImpl implements AdminMemberDAO{
	
	@Autowired
	private SqlSession sqlsession;

	
	//전체 회원수
	@Override
	public int countMember() {
		int total = sqlsession.selectOne("mapper.member.countMember");
		return total;
	}

	//전체 회원 조회
	@Override
	public List selectPageMember(int displayPost, int postNum) {
		HashMap data = new HashMap();
		data.put("displayPost", displayPost);
		data.put("postNum", postNum);
		return sqlsession.selectList("mapper.member.selectPageMember", data);
	}

	//회원 추가하기
	@Override
	public int insertMember(MemberDTO memberDTO) throws Exception {
		int result = sqlsession.insert("mapper.member.insertMember", memberDTO);
		return result;
	}

	//회원 1명만 선택
	@Override
	public MemberDTO selectOneMember(String member_id) throws Exception {
		MemberDTO memberDTO = new MemberDTO();
		memberDTO = sqlsession.selectOne("mapper.member.selectOneMember", member_id);
		return memberDTO;
	}

	//회원 정보 수정하기
	@Override
	public int updateMember(MemberDTO memberDTO) throws Exception {
		int result = sqlsession.insert("mapper.member.updateMember", memberDTO);
		System.out.println("쿼리 결과 : " + result);
		return result;
	}

	//회원 삭제하기
	@Override
	public void deleteMember(String member_id) throws Exception {
		sqlsession.delete("mapper.member.deleteMember", member_id);
	}


	//회원 검색하기
	@Override
	public List searchMember(MemberDTO memberDTO) throws Exception {
		List memberlist=  sqlsession.selectList("mapper.member.selectSearchMember", memberDTO);
		return memberlist;
	}

	

	
}
