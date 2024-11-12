package com.popcornpedia.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.popcornpedia.board.dto.CommentDTO;
import com.popcornpedia.board.service.BoardService;
import com.popcornpedia.common.dto.makePagingDTO;

@RestController("commentController")
@RequestMapping("/board")
public class CommentControllerImpl implements CommentController {
	
	@Autowired
	private BoardService boardService;
	
	// 글번호로 댓글 가져오기
	@GetMapping(value="/getComment.do/{articleNO}", produces= {MediaType.APPLICATION_JSON_VALUE})
	// GetMapping, PostMapping 쓰면 RequestMapping에서 method 방식 따로 지정하지 않아도 됨
	// produces : 사용자에게 응답할 데이터 타입 지정
	@Override
	public ResponseEntity<List<CommentDTO>> selectComment(@PathVariable("articleNO") int articleNO) throws Exception {
		// 특정 글번호의 전체 댓글을 가져와서 http 상태와 함께 return
		List<CommentDTO> commentList = boardService.selectCommentByArticleNO(articleNO);
		return new ResponseEntity<>(commentList, HttpStatus.OK);
	}
	
	// 댓글 작성
	@PostMapping(value="/writeComment.do")
	@Override
	public ResponseEntity<String> insertComment(@RequestBody CommentDTO commentDTO)
			throws Exception {
		// 아이디, 닉네임, 댓글내용, 글번호 담은 DTO(json) 가져와 새 댓글 작성, 댓글 수 업데이트
		int result = boardService.insertComment(commentDTO);
		if(result == 1) {
			// insert 성공하면 정상 처리 status 반환
			System.out.println("[CommentController] 댓글 작성 완료");
			return new ResponseEntity<>(HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	// 댓글 수정
	@PostMapping(value="/modComment.do")
	@Override
	public ResponseEntity<String> updateComment(@RequestBody HashMap<String, Object> commentMap)
			throws Exception {
		// 수정할 댓글 번호, 내용 HashMap에 받아오기
		// 수정 요청 후 결과에 따라 status 반환
		int result = boardService.updateComment(commentMap);
		if(result == 1) {
			return new ResponseEntity<>(HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	// 댓글 삭제
	@DeleteMapping(value="/deleteComment.do", produces= {MediaType.APPLICATION_JSON_VALUE})
	@Override
	public ResponseEntity<String> deleteComment(@RequestBody HashMap<String, Object> commentMap)
			throws Exception {
		int articleNO = Integer.parseInt((String)commentMap.get("articleNO"));
		int commentNO = Integer.parseInt((String)commentMap.get("commentNO"));
		int result = boardService.deleteComment(articleNO, commentNO);
		if(result == 1) {
			return new ResponseEntity<>(HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	// 글번호로 댓글 가져오기 + 페이징 처리 
		@GetMapping(value="/getPageComment.do/{articleNO}", produces= {MediaType.APPLICATION_JSON_VALUE})
		@Override
		public ResponseEntity<Map<String, Object>> selectPageComment(@PathVariable("articleNO")int articleNO, @RequestParam(name = "num", defaultValue = "1") int num) throws Exception {
		
			
			int postNum = 20;
			makePagingDTO page = new makePagingDTO(num,boardService.countCommentByArticleNO(articleNO),postNum);
			System.out.println("어디가문제일까");
			List<CommentDTO> commentList = boardService.selectPageCommentByArticleNO(articleNO, page.getDisplayPost(), page.getPostNum());
			System.out.println("2");
			Map<String, Object> commentMap = new HashMap();
			commentMap.put("cmtList", commentList);
			commentMap.put("page", page);
			
			System.out.println("3");
			return new ResponseEntity<>(commentMap, HttpStatus.OK);
		}

}
