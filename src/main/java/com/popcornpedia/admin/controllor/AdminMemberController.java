package com.popcornpedia.admin.controllor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.popcornpedia.admin.service.AdminMemberService;
import com.popcornpedia.common.dto.makePagingDTO;
import com.popcornpedia.member.dto.MemberDTO;

@Controller
public class AdminMemberController {

	@Autowired
	private AdminMemberService memberService;
	
	// 멤버 추가 (관리자용)
	@RequestMapping(value="/admin/insertMember.do", method = RequestMethod.POST)
	public ModelAndView insertMember(@ModelAttribute("memberInfo") MemberDTO memberDTO, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("utf-8");
		memberService.insertMember(memberDTO);
		return new ModelAndView("redirect:/admin/listMember");
	}
	
	// 전체 회원 조회
	@RequestMapping(value = "/admin/listMember")
	public ModelAndView selectAllMember(@RequestParam(defaultValue = "1") int num) throws Exception {
		// 페이징 처리
		int postNum = 15; // 한 페이지에 표시할 수
		int total = memberService.countMember()-1; // 전체 멤버 수
		makePagingDTO page = new makePagingDTO(num, total, postNum);
		List memberlist = memberService.selectPageMember(page.getDisplayPost(), page.getPostNum());
				
		ModelAndView mav = new ModelAndView();
		mav.addObject("membersList",memberlist);
		mav.addObject("page", page);
		mav.addObject("selectPageNum", num);
		mav.addObject("total", total);
		mav.setViewName("admin/listMember");
		return mav;
	}
	
	// 멤버 정보 수정 (관리자용)
	@RequestMapping(value = "/admin/updateMember.do")
	public ModelAndView updateMember(@ModelAttribute("memberInfo") MemberDTO memberDTO, 
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		memberService.updateMember(memberDTO);
		return new ModelAndView("redirect:/admin/listMember");
	}

	// 멤버 삭제 (관리자용)
	@RequestMapping(value = "/admin/deleteMember.do")
	public ModelAndView deleteMember(@RequestParam("member_id") String member_id, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		memberService.deleteMember(member_id);
		return new ModelAndView("redirect:/admin/listMember");
	}
	
	// 멤버 검색 (관리자용)
	@RequestMapping(value="/admin/searchMember.do")
	public ModelAndView searchMember(@RequestParam("searchType") String searchType, 
			@RequestParam("keyword") String keyword, 
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		//파라미터 DTO에 담기
		MemberDTO searchDTO = new MemberDTO();
		searchDTO.setSearchType(searchType);
		searchDTO.setKeyword(keyword);
		//비지니스로 넘기기
		List memberlist = memberService.searchMember(searchDTO);
		//받아온 데이터 뷰 페이지로 보내기
		ModelAndView mav = new ModelAndView();
		mav.addObject("membersList",memberlist);
		mav.setViewName("admin/listMember");
		return mav;
	}
	
	// 회원 추가 페이지로 이동
	@RequestMapping(value = "/admin/memberForm")
	public ModelAndView goMemberForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("/admin/memberForm");
	}
	
	// 멤버 수정 페이지로 이동
	@RequestMapping(value = "/admin/updateMemberForm.do")
	public ModelAndView goUpdateMemberForm(@RequestParam("member_id") String member_id, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		MemberDTO memberDTO = memberService.selectOneMember(member_id);
		ModelAndView mav = new ModelAndView();
		request.setAttribute("memberDTO", memberDTO);
		mav.setViewName("/admin/memberForm");
		System.out.println("수정 페이지로 이동하기");
		return mav;
	}



}
