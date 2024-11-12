package com.popcornpedia.board.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.web.multipart.MultipartFile;

import com.popcornpedia.board.dto.BoardDTO;
import com.popcornpedia.board.dto.CommentDTO;

public interface BoardService {
	// 게시글 기본 CRUD
	public List<BoardDTO> selectAllArticle() throws DataAccessException;
	public int insertArticle(BoardDTO boardDTO, MultipartFile file) throws DataAccessException;
	public int updateArticle(BoardDTO boardDTO, MultipartFile file, boolean deleteFile, boolean updateFile) throws DataAccessException;
	public int deleteArticle(int articleNO) throws DataAccessException;
	
	// 상세 게시글 보기
	public BoardDTO viewArticle(int articleNO) throws DataAccessException;

	// 게시글 검색
	public List<BoardDTO> searchArticleByKeyword(HashMap<String, Object> searchMap) throws DataAccessException;
	public BoardDTO searchArticleByArticleNO(int articleNO) throws DataAccessException;
	public String selectMember_idByArticleNO(int articleNO) throws DataAccessException;
	
	// 게시글 추천, 추천 취소
	public int likeCheck(int articleNO, String member_id) throws DataAccessException;
	public void addLikeArticle(int articleNO, String member_id) throws DataAccessException;
	public void cancelLikeArticle(int articleNO, String member_id)throws DataAccessException;
	
	// 댓글 기본 CRUD
	public List<CommentDTO> selectCommentByArticleNO(int articleNO) throws DataAccessException;
	public int insertComment(CommentDTO commentDTO) throws DataAccessException;
	public int updateComment(HashMap<String, Object> commentMap) throws DataAccessException;
	public int deleteComment(int articleNO, int commentNO) throws DataAccessException;
	
	// 댓글 작성자 검색
	public String selectMember_idByCommentNO(int commentNO) throws DataAccessException;
	
	
	// 페이징 구현 

	public int countArticles() throws Exception;		
	public List<BoardDTO> selectPageArticle(int displayPost, int postNum) throws Exception;
	public int countSearchArticleByKeyword(HashMap<String,Object> searchMap) throws Exception;
	public List<BoardDTO> searchPageArticleByKeyword(HashMap<String, Object> searchPageMap) throws Exception;
	public List<CommentDTO> selectPageCommentByArticleNO(int ArticleNO, int displayPost, int postNum)throws Exception;
	public int countCommentByArticleNO(int articleNO)throws Exception;
}
