package com.popcornpedia.common.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class LoginCheckInterceptor implements HandlerInterceptor {

	// 게시판 관련 요청 중 로그인 확인이 필요한 요청은 사전에 인터셉터로 처리
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		if(session.getAttribute("user") != null) {
			System.out.println("[LoginInterceptor] 로그인 확인");
			return true;
		}
		else {
			System.out.println("[LoginInterceptor] 로그인 상태 아님");
			// ajax 요청인지 확인
			if(isAjaxRequest(request)){
				System.out.println("[LoginInterceptor] ajax 요청임");
				// 해당 뷰 페이지에서 401 error 처리하는 ajax 코드 필요
				response.sendError(401);
				return false;
			} else{
				System.out.println("[LoginInterceptor] ajax 요청 아님");
				response.setContentType("text/html; charset=UTF-8");
	            PrintWriter out = response.getWriter();
	            out.println("<script>alert('로그인이 필요합니다.'); location.href='/user/login';</script>");
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
		}else{
			return false;
		}
	}
}
