package com.popcornpedia.board.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.popcornpedia.board.dto.CommentDTO;

@Repository("commentDAO")
public class CommentDAOImpl implements CommentDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	// 댓글 기본 CRUD
	@Override
	public List<CommentDTO> selectCommentByArticleNO(int articleNO) throws DataAccessException {
		// 특정 글의 댓글 모두 가져오기
		List<CommentDTO> commentList = sqlSession.selectList("mapper.board.selectCommentByArticleNO", articleNO);
		return commentList;
	}

	@Override
	public int insertComment(CommentDTO commentDTO) throws DataAccessException {
		return sqlSession.insert("mapper.board.insertComment", commentDTO);
	}

	@Override
	public int updateComment(HashMap<String, Object> commentMap) throws DataAccessException {
		return sqlSession.update("mapper.board.updateComment", commentMap);
	}

	@Override
	public int deleteComment(int commentNO) throws DataAccessException {
		return sqlSession.delete("mapper.board.deleteComment", commentNO);
	}
	
	// 페이징 처리해서 가져오기 
	@Override
	public List<CommentDTO> selectPageCommentByArticleNO(HashMap<String, Object> pageMap) throws Exception {
			
		return sqlSession.selectList("mapper.board.selectPageCommentByArticleNO", pageMap);
	}
		

		// 특정 게시글 댓글 수 가져오기
	@Override
	public int countCommentByArticleNO(int articleNO) throws Exception {
			
		return sqlSession.selectOne("mapper.board.countCommentByArticleNO", articleNO);
	}

}
