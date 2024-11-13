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
	
	//관리자용 회원 추가 입력 Form으로 가기
	@RequestMapping(value = "/admin/memberForm")
	public ModelAndView goMemberForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("/admin/memberForm");
	}

	
	//관리자용 멤버 추가하기
	@RequestMapping(value="/admin/insertMember.do", method = RequestMethod.POST)
	public ModelAndView insertMember(@ModelAttribute("memberInfo") MemberDTO memberDTO, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setCharacterEncoding("utf-8");
		memberService.insertMember(memberDTO);
		ModelAndView mav = new ModelAndView("redirect:/admin/listMember.do");
		return mav;
	}

	
	//전체 회원 조회하기
	@RequestMapping(value = "/admin/listMember.do")
	public ModelAndView selectAllMember(@RequestParam(defaultValue = "1") int num) throws Exception {
		int postNum = 15;
		makePagingDTO page = new makePagingDTO(num, memberService.countMember(), postNum);
		int total = memberService.countMember();

		List memberlist = memberService.selectPageMember(page.getDisplayPost(), page.getPostNum());
				
		ModelAndView mav = new ModelAndView();
		mav.addObject("membersList",memberlist);
		mav.addObject("page", page);
		mav.addObject("selectPageNum", num);
		mav.addObject("total", total);
		mav.setViewName("admin/listMember");
		return mav;
	}

	
	//멤버 수정 페이지로 이동
	@RequestMapping(value = "/admin/updateMemberForm.do")
	public ModelAndView updateMemberForm(@RequestParam("member_id") String member_id, HttpServletRequest request, HttpServletResponse response) throws Exception{
		MemberDTO memberDTO = memberService.selectOneMember(member_id);
		ModelAndView mav = new ModelAndView();
		request.setAttribute("memberDTO", memberDTO);
		mav.setViewName("/admin/memberForm");
		System.out.println("수정 페이지로 이동하기");
		return mav;
	}
	
	
	//멤버 정보 수정하기 (관리자용)
	@RequestMapping(value = "/admin/updateMember.do")
	public ModelAndView updateMember(@ModelAttribute("memberInfo") MemberDTO memberDTO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		memberService.updateMember(memberDTO);
		ModelAndView mav = new ModelAndView("redirect:/admin/listMember.do");
		return mav;
	}


	//멤버 삭제하기 (관리자용)
	@RequestMapping(value = "/admin/deleteMember.do")
	public ModelAndView deleteMember(@RequestParam("member_id") String member_id,  HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		int result = memberService.deleteMember(member_id);
		ModelAndView mav = new ModelAndView("redirect:/admin/listMember.do");
		return mav;
	}

	
	//멤버 검색하기 (관리자용)
	@RequestMapping(value="/admin/searchMember.do")
	public ModelAndView searchMember(@RequestParam("searchType") String searchType, @RequestParam("keyword") String keyword, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
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



}
