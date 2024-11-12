package com.popcornpedia.board.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;

import com.popcornpedia.board.dto.CommentDTO;

public interface CommentDAO {
	// 댓글 기본 CRUD
	public List<CommentDTO> selectCommentByArticleNO(int articleNO) throws DataAccessException;
	public int insertComment(CommentDTO commentDTO) throws DataAccessException;
	public int updateComment(HashMap<String, Object> commentMap) throws DataAccessException;
	public int deleteComment(int commentNO) throws DataAccessException;

	// 페이징 구현중
	
	// 페이징 처리해서 댓글 가져오기
	public List<CommentDTO> selectPageCommentByArticleNO(HashMap<String, Object> pageMap)throws Exception;
		
	public int countCommentByArticleNO(int aritcleNO)throws Exception;
	
}
