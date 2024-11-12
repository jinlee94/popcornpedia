package com.popcornpedia.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.popcornpedia.board.dto.BoardDTO;
import com.popcornpedia.member.dto.MemberDTO;

public interface UserController {
	public ModelAndView selectMyReviews(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;
	public ModelAndView myPage(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView selectMyArticles(@RequestParam("num") int num, HttpSession session) throws Exception;
	public ModelAndView selectUserArticles(@RequestParam("num") int num, @RequestParam("member_id")String member_id, String nickname) throws Exception;
	public ModelAndView myInfo(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView updateMyInfo(@ModelAttribute("memberDTO") MemberDTO memberDTO, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception;
	public ModelAndView myProfile(HttpServletRequest request, HttpServletResponse Response) throws Exception;
	public ModelAndView updateMyProfile(@RequestParam("memberImgName") MultipartFile file, @ModelAttribute("memberDTO") MemberDTO memberDTO, 
										@RequestParam(value="deleteFile", required=false, defaultValue="false") boolean deleteFile,
										HttpSession session) throws Exception;
	public ModelAndView myStarRating(HttpServletRequest request, HttpServletResponse Response, HttpSession session) throws Exception;
	public ModelAndView userStarRating(@RequestParam("member_id") String member_id) throws Exception;
	public ModelAndView myTaste(String nickname) throws Exception;
	public ModelAndView userPage(String nickname) throws Exception;
	public int countMyReviews(HttpSession session) throws Exception;
	public double avgMyStarRating(HttpSession session) throws Exception;
	public int countMyArticles(HttpSession session)throws Exception;
	public String updateEmail(@RequestBody HashMap<String, Object> emailMap, HttpSession session) throws Exception;
	public int countMyWishMovie(HttpSession session) throws Exception;
}
