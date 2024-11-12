package com.popcornpedia.common.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.popcornpedia.member.dto.MemberDTO;

@Component
public class VerifiedEmailCheckInterceptor implements HandlerInterceptor {

	// 게시판 관련 요청 중 이메일 인증 확인이 필요한 요청은 사전에 인터셉터로 처리 (로그인 확인, 사용자 대조 이후 실행됨)
	// 게시글 작성/수정창이동/수정/삭제 , 댓글 작성/수정/삭제
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		MemberDTO userDTO = (MemberDTO) session.getAttribute("user");
		boolean email_verified = userDTO.isEmail_verified(); // 이메일 인증 여부 확인
		
		if(email_verified) {
			System.out.println("[EmailInterceptor] 이메일 인증됨");
			return true;
		}
		else {
			System.out.println("[EmailInterceptor] 이메일 인증 안됨");
			// ajax 요청인지 확인
			if(isAjaxRequest(request)){
				System.out.println("[EmailInterceptor] ajax 요청임");
				// 해당 뷰 페이지에서 400 error 처리하는 ajax 코드 필요
				response.sendError(400);
				return false;
			} else{
				System.out.println("[EmailInterceptor] ajax 요청 아님");
				response.setContentType("text/html; charset=UTF-8");
	            PrintWriter out = response.getWriter();
	            out.println("<script>alert('이메일 인증을 완료해주세요.');location.href=document.referrer;</script>");
	            out.flush();
	            return false;
			}
		}
	}

	// Ajax 요청인지 체크하는 메소드
	private boolean isAjaxRequest(HttpServletRequest request) {
		String header = request.getHeader("x-requested-with");
		if ("XMLHttpRequest".equals(header)){
			return true;
		}
		else {
			return false;
		}
	}
}
