package com.popcornpedia.board.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.popcornpedia.board.dto.BoardDTO;
import com.popcornpedia.board.service.BoardService;
import com.popcornpedia.common.dto.makePagingDTO;
import com.popcornpedia.member.dto.MemberDTO;

@Controller("boardController")
@RequestMapping("/board")
public class BoardControllerImpl implements BoardController {

	@Autowired
	private BoardService boardService;

	// 전체 게시글 가져오기 + 페이징 
	@GetMapping(value="/")
	@Override
	public ModelAndView selectPageArticle(@RequestParam(defaultValue = "1") int num) throws Exception {
	
		int postNum = 15;
		System.out.println(postNum);
		
		makePagingDTO page = new makePagingDTO(num,boardService.countArticles(),postNum);
		
		List<BoardDTO> boardList = null;
		boardList = boardService.selectPageArticle(page.getDisplayPost(), page.getPostNum());
		
		ModelAndView mav = new ModelAndView("/board/listBoard");
		mav.addObject("boardList", boardList);
		mav.addObject("page", page);
		mav.addObject("selectPageNum", num);	
		
		return mav;
	}
	
	

	// 상세 게시글 보기
	@GetMapping(value="/article")
	@Override
	public ModelAndView viewArticle(
		@RequestParam("id") int articleNO, HttpSession session
	) throws Exception {
		// url 쿼리(?id=...)에서 글번호를 가져와 게시글 하나 찾기, 조회수 먼저 증가
		BoardDTO boardDTO = boardService.viewArticle(articleNO);
		
		// 추천 여부 확인하기
		MemberDTO userDTO = (MemberDTO) session.getAttribute("user");
		String member_id = "";
		if(userDTO != null) {
			member_id = userDTO.getMember_id();
		}
		int likeCheck = likeCheck(articleNO, member_id);
		
		// 게시글 DTO, 추천 여부 바인딩
		ModelAndView mav = new ModelAndView("/board/article");
		mav.addObject("article", boardDTO);
		mav.addObject("likeCheck", likeCheck);
		return mav;
	}

	// 새글 작성폼 이동
	@GetMapping(value="/writeArticle")
	@Override
	public String formArticle() throws Exception {
		return "/board/articleForm";
	}
	
	// 수정폼 이동
	@GetMapping(value="/modArticle")
	@Override
	public String formModArticle(
		@RequestParam("id") int articleNO,
		Model model
	) throws Exception {
		BoardDTO boardDTO = boardService.searchArticleByArticleNO(articleNO);
		model.addAttribute("boardDTO", boardDTO);
		return "/board/articleForm";
	}
	
	// 게시글 작성
	@PostMapping(value="/writeArticle.do")
	@Override
	public ModelAndView insertArticle(@RequestParam("imgFile") MultipartFile file, @ModelAttribute BoardDTO boardDTO)
			throws Exception {
		// 입력한 텍스트들(DTO), 파일(MultipartFile) 파라미터로 받아옴
		// 게시글 작성하기
		boardService.insertArticle(boardDTO, file);
		// 작성 후 전체 조회로 redirect
		ModelAndView mav = new ModelAndView("redirect:/board/");
		return mav;
		// [TODO] 파일 업로드 로직을 공통 모듈로 분리해 여러 곳에서 재사용할 수 있게 만들기 [DONE] FileService 인터페이스 구현
	}
	
	// 게시글 수정
	@PostMapping(value="/modArticle.do")
	@Override
	public ModelAndView updateArticle(
		@RequestParam("imgFile") MultipartFile file,
		@RequestParam(value="deleteFile", required=false, defaultValue="false") boolean deleteFile,
		@RequestParam(value="updateFile", required=false, defaultValue="false") boolean updateFile,
		@ModelAttribute BoardDTO boardDTO
	) throws Exception {
		// 게시글 수정하기
		boardService.updateArticle(boardDTO, file, deleteFile, updateFile);
		// 작성 후 해당 게시글로 redirect
		ModelAndView mav = new ModelAndView("redirect:/board/article?id="+boardDTO.getArticleNO());
		return mav;
	}
	
	// 게시글 삭제
	@GetMapping(value="/deleteArticle.do")
	@Override
	public String deleteArticle(@RequestParam(value="id", required=false, defaultValue="0") int articleNO)
			throws Exception {
		// 삭제 후 전체 조회로 redirect
		boardService.deleteArticle(articleNO);
		return "redirect:/board/";
	}
	
	// 게시글 검색
	@RequestMapping(value="/search.do")
	@Override
	public ModelAndView searchArticle(
		@RequestParam HashMap<String, Object> searchMap,
		@RequestParam(defaultValue = "1") int num
	) throws Exception {
		// 검색 타입, 키워드 HashMap에 받아오기
		int postNum = 15;
		
		makePagingDTO page = new makePagingDTO(num,boardService.countSearchArticleByKeyword(searchMap),postNum);
		
		searchMap.put("displayPost",page.getDisplayPost());
		searchMap.put("postNum", page.getPostNum());
		
		List<BoardDTO> boardList = boardService.searchPageArticleByKeyword(searchMap);
		
		ModelAndView mav = new ModelAndView("/board/listBoard");
		mav.addObject("boardList", boardList);
		mav.addObject("page", page);
		mav.addObject("selectPageNum", num);
		mav.addObject("searchMap",searchMap);
		return mav;
	}

	// 게시글 추천, 추천 취소
	@ResponseBody
	@GetMapping(value="/updateLike")
	@Override
	public int updateLikeArticle(
		int articleNO, String member_id, int likeCheck
	) throws Exception {
		if(likeCheck == 0) {
			// 처음 추천 누름
			// 추천수 증가, 추천 기록 추가
			boardService.addLikeArticle(articleNO, member_id);
		}
		else if(likeCheck == 1) {
			// 추천수 감소, 추천 기록 삭제
			boardService.cancelLikeArticle(articleNO, member_id);
		}
		
		// 최종 반영할 추천수 가져오기
		int likeNO = boardService.searchArticleByArticleNO(articleNO).getLikeNO();
		return likeNO;
	}
	
	// 게시글 추천 여부 확인해서 0, 1 반환하고 반환된 값에 따라 버튼 모양 다르게 지정하기
	@Override
	public int likeCheck(int articleNO, String member_id) throws Exception {
		int likeCheck = boardService.likeCheck(articleNO, member_id);
		return likeCheck;
	}
	

}
