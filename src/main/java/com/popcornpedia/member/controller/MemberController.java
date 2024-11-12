package com.popcornpedia.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.popcornpedia.member.dto.MemberDTO;

public interface MemberController {
	// 회원 기본 CRUD
	public ModelAndView formMember() throws Exception;
	public ModelAndView insertMember(@ModelAttribute MemberDTO memberDTO) throws Exception;
	
	// 중복검사
	public int checkDuplicateField(String field, String value) throws Exception;
	
	// 로그인창 이동
	public ModelAndView formLogin() throws Exception;
	
	// 로그인 요청
	public ResponseEntity<String> checkLogin(@RequestBody HashMap<String, Object> loginMap, HttpSession session) throws Exception;
	
	// 로그아웃 요청
	public ModelAndView checkLogout(HttpSession session) throws Exception;
	
	// 인증 메일 보내기 요청
	public ResponseEntity<String> sendVerificationEmail(@RequestBody HashMap<String, Object> emailMap) throws Exception;
	
	// 이메일 인증 확인
	public ModelAndView verifyEmail(@RequestParam("code") String code, @RequestParam("id") String member_id, HttpSession session) throws Exception;
	
	// 이메일 바로 인증 처리하기(테스트)
	public ModelAndView verifyEmailTest(@RequestParam("id") String member_id, HttpSession session) throws Exception;
	
	// 아이디, 비밀번호 찾기
	public String findId(@RequestBody HashMap<String, Object> memberMap) throws Exception;
	public ResponseEntity<String> findPwd(@RequestBody HashMap<String, Object> memberMap) throws Exception;
	public ModelAndView formResetPwd(@RequestParam("id") String member_id) throws Exception;
	public ModelAndView resetPwd(@ModelAttribute MemberDTO memberDTO) throws Exception;
}
