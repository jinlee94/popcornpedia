package com.popcornpedia.admin.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.popcornpedia.admin.dao.AdminMemberDAO;
import com.popcornpedia.member.dto.MemberDTO;

@Service("AdminMemberService")
public class AdminMemberServiceImpl implements AdminMemberService{

	@Autowired
	private AdminMemberDAO memberDAO;
	
	//회원 추가
	@Override
	public int insertMember(MemberDTO memberDTO) throws Exception {
		int result = memberDAO.insertMember(memberDTO);
		return result;
	}

	//수정하기 위해 회원 1명 선택하기
	@Override
	public MemberDTO selectOneMember(String member_id) throws Exception {
		MemberDTO memberDTO = memberDAO.selectOneMember(member_id);
		return memberDTO;
	}
	//회원 정보 수정
	@Override
	public int updateMember(MemberDTO memberDTO) throws Exception {
		int result = memberDAO.updateMember(memberDTO);
		return result;
	}
	//회원 삭제
	@Override
	public int deleteMember(String member_id) throws Exception {
		int result = memberDAO.deleteMember(member_id);
		return result;
	}
	//회원 검색
	@Override
	public List searchMember(MemberDTO searchDTO) throws Exception {
		List memberlist = memberDAO.searchMember(searchDTO);
		return memberlist;
	}
	@Override
	public int countMember() {
		return memberDAO.countMember();
	}
	@Override
	public List selectPageMember(int displayPost, int postNum) {
		return memberDAO.selectPageMember(displayPost, postNum);
	}



	
}
