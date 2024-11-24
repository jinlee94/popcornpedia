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
		
		// 비로그인 상태 처리
        if (userDTO == null) {
            System.out.println("[AdminInterceptor] 비로그인 상태");
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('관리자 로그인이 필요합니다.'); location.href='/popcornpedias/user/login';</script>");
            out.flush();
            return false;
        }
        
        // 로그인 상태
        String user_id = userDTO.getMember_id(); 
        if ("admin".equals(user_id)) {
            return true;
        } else {
            System.out.println("[AdminInterceptor] 관리자 아이디 아님");
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('접근할 수 없습니다.'); location.href='/popcornpedias/movie/mainMovie';</script>");
            out.flush();
            return false;
        }
		
	}
	
	

}
