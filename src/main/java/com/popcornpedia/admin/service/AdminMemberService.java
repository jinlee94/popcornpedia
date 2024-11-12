package com.popcornpedia.admin.service;

import java.util.HashMap;
import java.util.List;

import com.popcornpedia.member.dto.MemberDTO;

public interface AdminMemberService {

	public int insertMember(MemberDTO memberDTO) throws Exception;
	public int updateMember(MemberDTO memberDTO) throws Exception;
	public MemberDTO selectOneMember(String member_id) throws Exception;
	public int deleteMember(String member_id) throws Exception;
	public List searchMember(MemberDTO searchDTO) throws Exception;
	public int countMember();
	public List selectPageMember(int displayPost, int postNum);
	
}
