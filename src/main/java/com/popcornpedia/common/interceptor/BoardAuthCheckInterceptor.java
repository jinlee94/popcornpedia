package com.popcornpedia.common.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.popcornpedia.board.service.BoardService;
import com.popcornpedia.member.dto.MemberDTO;

@Component
public class BoardAuthCheckInterceptor implements HandlerInterceptor {
	
	@Autowired
	private BoardService boardService;

	// 게시판 관련 요청 중 사용자 대조가 필요한 요청은 사전에 인터셉터로 처리 (로그인 확인 이후 실행됨)
	// 게시글 수정창이동/수정/삭제 , 댓글 수정/삭제
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		MemberDTO userDTO = (MemberDTO) session.getAttribute("user");
		String user_id = userDTO.getMember_id(); // 접속중인 사용자 id
		
		// (일단) ajax 요청이면 댓글 수정/삭제, 아니면 게시글 수정/삭제임
		if(isAjaxRequest(request)){ // ajax 요청일 때
			System.out.println("[BoardInterceptor] ajax 요청임");
			int commentNO = (request.getParameter("cmtId") != null) ? Integer.parseInt(request.getParameter("cmtId")) : 0; // 댓글 번호 가져오기 (?id=*, 없으면 0)
				System.out.println("[BoardInterceptor] 댓글 번호 : "+commentNO);
			String member_id = boardService.selectMember_idByCommentNO(commentNO); // 댓글 작성자 id
			if(user_id.equals(member_id)) { // 접속중 사용자와 댓글 작성자가 같은지 확인
				System.out.println("[BoardInterceptor] 작성자 일치함");
				return true;
			} else {
				System.out.println("[BoardInterceptor] 작성자 일치하지 않음");
				// 해당 뷰 페이지에서 403 error 처리하는 ajax 코드 필요
				response.sendError(403);
				return false;
			}
		}
		else { // ajax 요청 아닐때
			System.out.println("[BoardInterceptor] ajax 요청 아님");
			int articleNO = (request.getParameter("id") != null) ? Integer.parseInt(request.getParameter("id")) : 0; // 게시글 번호 가져오기 (?id=*, 없으면 0)
			if(articleNO!=0) {
				String member_id = boardService.selectMember_idByArticleNO(articleNO); // 게시글 작성자 id
				System.out.println("[BoardInterceptor] user_id : " + user_id + ", member_id : " + member_id);
				if(user_id.equals(member_id)) { // 접속중 사용자와 게시글 작성자가 같은지 확인
					System.out.println("[BoardInterceptor] 작성자 일치함");
					return true;
				} else {
					System.out.println("[BoardInterceptor] 작성자 일치하지 않음");
					response.setContentType("text/html; charset=UTF-8");
		            PrintWriter out = response.getWriter();
		            out.println("<script>alert('권한이 없습니다.'); location.href='/board/';</script>");
		            out.flush();
		            return false;
				}
			}
			else {
				System.out.println("[BoardInterceptor] 게시글 번호 없음");
				response.setContentType("text/html; charset=UTF-8");
	            PrintWriter out = response.getWriter();
	            out.println("<script>alert('잘못된 요청입니다.'); location.href='/board/';</script>");
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
