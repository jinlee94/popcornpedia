package com.popcornpedia.board.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.popcornpedia.board.dao.BoardDAO;
import com.popcornpedia.board.dao.CommentDAO;
import com.popcornpedia.board.dto.BoardDTO;
import com.popcornpedia.board.dto.CommentDTO;
import com.popcornpedia.common.file.BoardFileService;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDAO boardDAO;
	
	@Autowired
	private CommentDAO commentDAO;
	
	@Autowired
	private BoardFileService boardFileService;
	
	@Override
	public List<BoardDTO> selectAllArticle() throws DataAccessException {
		List<BoardDTO> boardList = boardDAO.selectAllArticle();
		return boardList;
	}

	@Override
	public int insertArticle(BoardDTO boardDTO, MultipartFile file) throws DataAccessException {
		// DB에 게시글 레코드 추가
		int insertResult = boardDAO.insertArticle(boardDTO);
		
		if(!file.isEmpty()) { // 업로드한 파일이 있으면
			// 새로 작성한 글번호 받아와 HashMap 만들기
			int articleNO = boardDTO.getArticleNO();
			HashMap<String, Object> fileMap = new HashMap<String, Object>();
			fileMap.put("articleNO", articleNO);
			
			// 파일 업로드
			boardFileService.uploadFile(file, fileMap);
			
			// 저장된 파일명으로 레코드 업데이트하기
			boardDTO.setImgFileName(file.getOriginalFilename());
			int updateResult = boardDAO.updateArticleImgFileName(boardDTO);
			
			// sql 둘다 제대로 실행되었는지 체크 후 return
			if (insertResult == 1 && updateResult == 1) return 1;
			else return 0;
		}
		return insertResult;
	}

	@Override
	public int updateArticle(
		BoardDTO boardDTO, MultipartFile file,
		boolean deleteFile, boolean updateFile
	) throws DataAccessException {
		if(updateFile) { // 파일 수정 요청
			System.out.println("[BoardService] 파일 수정 요청 있음");
			
			if(!(file.isEmpty()) || deleteFile) { // 업로드된 새 파일이 있거나 기존 파일 삭제 요청이면
				// 수정할 글번호, 파일명 받아와 HashMap 만들기
				int articleNO = boardDTO.getArticleNO();
				HashMap<String, Object> fileMap = new HashMap<String, Object>();
				fileMap.put("articleNO", articleNO);
				
				// 기존 파일 있으면 삭제
				String oldFileName = boardDTO.getOldFileName();
				if(!(oldFileName.isEmpty())) {
					fileMap.put("fileName", oldFileName);
					// 기존 파일 삭제 요청하기
					boardFileService.deleteFileOrDirectory(fileMap);
					if(deleteFile) { // 삭제만 하는 요청이면
						// 게시글의 기존 imgFileName 값 null로 만들기
						boardDAO.updateArticleImgFileName(boardDTO);
					}
				}
				// 업로드된 새 파일 있으면 업로드
				if(!(file.isEmpty())) {
					// 새로운 파일 업로드
					boardFileService.uploadFile(file, fileMap);
					// 저장된 새 파일명 DTO에 set
					boardDTO.setImgFileName(file.getOriginalFilename());
				}
			}
		}
		else { // 파일 수정 요청이 없으면
			System.out.println("[BoardService] 파일 수정 요청 없음");
			System.out.println("[BoardService] 기존 파일 유지");
		}
		return boardDAO.updateArticle(boardDTO);
	}

	@Override
	public int deleteArticle(int articleNO) throws DataAccessException {
		// 삭제할 글번호로 HashMap 만들기
		HashMap<String, Object> fileMap = new HashMap<String, Object>();
		fileMap.put("articleNO", articleNO);
		
		// 폴더 삭제 요청
		boardFileService.deleteFileOrDirectory(fileMap);
		
		return boardDAO.deleteArticle(articleNO);
	}
	
	// 상세 게시글 보기
	@Override
	public BoardDTO viewArticle(int articleNO) throws DataAccessException {
		// 조회수 증가 + 게시글 하나 찾기
		boardDAO.updateHit(articleNO);
		BoardDTO boardDTO = boardDAO.searchArticleByArticleNO(articleNO);
		// 뷰 페이지에 출력할 때는 개행문자 \n을 <br> 태그로 바꿈
		boardDTO.setContent(boardDTO.getContent().replace("\n", "<br>"));
		return boardDTO;
	}

	// 키워드로 게시글 모두 검색
	@Override
	public List<BoardDTO> searchArticleByKeyword(HashMap<String, Object> searchMap) {
		List<BoardDTO> boardList = boardDAO.searchArticleByKeyword(searchMap);
		return boardList;
	}
	
	// 글번호로 게시글 찾기
	@Override
	public BoardDTO searchArticleByArticleNO(int articleNO) throws DataAccessException {
		BoardDTO boardDTO = boardDAO.searchArticleByArticleNO(articleNO);
		return boardDTO;
	}
	
	// 글번호로 작성자 id 찾기
	@Override
	public String selectMember_idByArticleNO(int articleNO) throws DataAccessException {
		String member_id = boardDAO.selectMember_idByArticleNO(articleNO);
		return member_id;
	}

	// 이미 추천한 게시글인지 확인하기
	@Override
	public int likeCheck(int articleNO, String member_id) throws DataAccessException {
		return boardDAO.likeCheck(articleNO, member_id);
	}
	
	@Override
	public void addLikeArticle(int articleNO, String member_id) throws DataAccessException {
		// 추천수 증가, 추천 기록 추가
		boardDAO.addLike(articleNO);
		boardDAO.insertLike(articleNO, member_id);
	}

	@Override
	public void cancelLikeArticle(int articleNO, String member_id) throws DataAccessException {
		// 추천수 감소, 추천 기록 삭제
		boardDAO.cancelLike(articleNO);
		boardDAO.deleteLike(articleNO, member_id);
	}

	// 댓글 CRUD
	@Override
	public List<CommentDTO> selectCommentByArticleNO(int articleNO) throws DataAccessException {
		List<CommentDTO> commentList = commentDAO.selectCommentByArticleNO(articleNO);
		return commentList;
	}

	@Override
	public int insertComment(CommentDTO commentDTO) throws DataAccessException {
		// 댓글 추가, 게시글 댓글수 +1
		int insertResult = commentDAO.insertComment(commentDTO);
		HashMap<String, Integer> amountMap = new HashMap<String, Integer>();
		amountMap.put("articleNO", commentDTO.getArticleNO());
		amountMap.put("amount", 1);
		int updateResult = boardDAO.updateCommentsByArticleNO(amountMap);
		// sql 둘다 제대로 실행되었는지 체크 후 return
		if (insertResult == 1 && updateResult == 1) return 1;
		else return 0;
	}

	@Override
	public int updateComment(HashMap<String, Object> commentMap) throws DataAccessException {
		return commentDAO.updateComment(commentMap);
	}

	@Override
	public int deleteComment(int articleNO, int commentNO) throws DataAccessException {
		// 댓글 삭제, 게시글 댓글수 -1
		int deleteResult = commentDAO.deleteComment(commentNO);
		HashMap<String, Integer> amountMap = new HashMap<String, Integer>();
		amountMap.put("articleNO", articleNO);
		amountMap.put("amount", -1);
		int updateResult = boardDAO.updateCommentsByArticleNO(amountMap);
		// sql 둘다 제대로 실행되었는지 체크 후 return
		if (deleteResult == 1 && updateResult == 1) return 1;
		else return 0;
	}

	// 댓글번호로 작성자id 찾기
	@Override
	public String selectMember_idByCommentNO(int commentNO) throws DataAccessException {
		String member_id = boardDAO.selectMember_idByCommentNO(commentNO);
		return member_id;
	}
	
	// 페이징 구현 
	@Override
	public int countArticles() throws Exception {
		return boardDAO.countArticles();
	}
	

	@Override
	public List<BoardDTO> selectPageArticle(int displayPost, int postNum) throws Exception {
		
		return boardDAO.selectPageArticle(displayPost, postNum);
	}
	

	@Override
	public int countSearchArticleByKeyword(HashMap<String, Object> searchMap) throws Exception {
		return boardDAO.countSearchArticleByKeyword(searchMap);
	}


	@Override
	public List<BoardDTO> searchPageArticleByKeyword(HashMap<String, Object> searchPageMap) throws Exception {
		return boardDAO.searchPageArticleByKeyword(searchPageMap);
	}

	@Override
	public List<CommentDTO> selectPageCommentByArticleNO(int articleNO, int displayPost, int postNum) throws Exception {
		
		HashMap<String, Object> pageMap = new HashMap();
		pageMap.put("articleNO", articleNO);
		pageMap.put("displayPost", displayPost);
		pageMap.put("postNum", postNum);

		return commentDAO.selectPageCommentByArticleNO(pageMap);
	}


	@Override
	public int countCommentByArticleNO(int articleNO) throws Exception {
		
		return commentDAO.countCommentByArticleNO(articleNO);
	}
	
}
