package com.popcornpedia.board.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;

import com.popcornpedia.board.dto.BoardDTO;

public interface BoardDAO {
	// 게시글 기본 CRUD
	public List<BoardDTO> selectAllArticle() throws DataAccessException;
	public int insertArticle(BoardDTO boardDTO) throws DataAccessException;
	public int updateArticle(BoardDTO boardDTO) throws DataAccessException;
	public int deleteArticle(int articleNO) throws DataAccessException;
	
	// 게시글 검색
	public List<BoardDTO> searchArticleByKeyword(HashMap<String, Object> searchMap) throws DataAccessException;
	public BoardDTO searchArticleByArticleNO(int articleNO) throws DataAccessException;
	public String selectMember_idByArticleNO(int articleNO) throws DataAccessException;
	
	// 게시글 추천, 추천 취소
	public int likeCheck(int articleNO, String member_id) throws DataAccessException;
	public int addLike(int articleNO) throws DataAccessException;
	public int cancelLike(int articleNO) throws DataAccessException;
	public int insertLike(int articleNO, String member_id) throws DataAccessException;
	public int deleteLike(int articleNO, String member_id) throws DataAccessException;
	
	// 조회수 증가
	public int updateHit(int articleNO) throws DataAccessException;
	
	// 게시글의 댓글수 증가, 감소
	public int updateCommentsByArticleNO(HashMap<String, Integer> amountMap) throws DataAccessException;
	
	// 게시글 첨부파일 수정
	public int updateArticleImgFileName(BoardDTO boardDTO) throws DataAccessException;
	
	// 댓글 작성자 검색
	public String selectMember_idByCommentNO(int commentNO) throws DataAccessException;
	

	// 페이징 구현
	
	// 한페이지에 들어갈 게시글 가져오기 
	public List<BoardDTO> selectPageArticle(int displayPost, int postNum) throws Exception;
	
	// 게시물 총 개수 가져오기 
	public int countArticles() throws Exception;
	
	// 검색된 게시물 총 개수 가져오기
	public int countSearchArticleByKeyword(HashMap<String, Object> searchMap) throws Exception;
	
	// 검색시  한페이지에 들어갈 게시글 가져오기 
	public List<BoardDTO> searchPageArticleByKeyword(HashMap<String, Object> searchPageMap) throws Exception;
}
