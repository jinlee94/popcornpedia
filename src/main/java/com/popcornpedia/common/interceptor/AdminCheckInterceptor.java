package com.popcornpedia.common.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import com.popcornpedia.member.dto.MemberDTO;

public class AdminCheckInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		MemberDTO userDTO = (MemberDTO) session.getAttribute("user");
		String user_id = userDTO.getMember_id(); // 접속중인 사용자 id
		if(user_id.equals("admin")) {
			return true;
		}
		else {
			System.out.println("[AdminInterceptor] 관리자 아이디 아님");
			response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('접근할 수 없습니다.'); location.href='/movie/mainMovie';</script>");
            out.flush();
			return false;
		}
		
	}
	
	

}
