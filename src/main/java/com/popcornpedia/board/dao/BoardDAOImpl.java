package com.popcornpedia.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.popcornpedia.board.dto.BoardDTO;

@Repository("boardDAO")
public class BoardDAOImpl implements BoardDAO {

	@Autowired
	private SqlSession sqlSession;
	
	// 게시글 기본 CRUD
	@Override
	public List<BoardDTO> selectAllArticle() throws DataAccessException {
		List<BoardDTO> boardList = sqlSession.selectList("mapper.board.selectAllArticle");
		return boardList;
	}

	@Override
	public int insertArticle(BoardDTO boardDTO) throws DataAccessException {
		int result = sqlSession.insert("mapper.board.insertArticle", boardDTO);
		return result;
	}

	@Override
	public int updateArticle(BoardDTO boardDTO) throws DataAccessException {
		int result = sqlSession.update("mapper.board.updateArticle", boardDTO);
		return result;
	}

	@Override
	public int deleteArticle(int articleNO) throws DataAccessException {
		int result = sqlSession.delete("mapper.board.deleteArticle", articleNO);
		return result;
	}

	// 글번호로 게시글 찾기
	@Override
	public BoardDTO searchArticleByArticleNO(int articleNO) throws DataAccessException {
		BoardDTO boardDTO = sqlSession.selectOne("mapper.board.searchArticleByArticleNO", articleNO);
		return boardDTO;
	}
	
	// 글번호로 작성자id 찾기
	@Override
	public String selectMember_idByArticleNO(int articleNO) throws DataAccessException {
		String member_id = sqlSession.selectOne("mapper.board.selectMember_idByArticleNO", articleNO);
		return member_id;
	}

	// 키워드로 게시글 모두 검색
	@Override
	public List<BoardDTO> searchArticleByKeyword(HashMap<String, Object> searchMap) throws DataAccessException {
		List<BoardDTO> boardList = sqlSession.selectList("mapper.board.searchArticleByKeyword", searchMap);
		return boardList;
	}

	// 이미 추천한 게시글인지 확인하기
	@Override
	public int likeCheck(int articleNO, String member_id) throws DataAccessException {
		// 글번호, 아이디를 담아 SQL에 전달할 Map 생성
		Map<String, Object> likeMap = new HashMap<String, Object>();
		likeMap.put("articleNO", articleNO);
		likeMap.put("member_id", member_id);
		
		// Map을 파라미터로 전달해 SQL 실행 결과 반환, 1이면 이미 사용자가 추천한 게시글
		int result = sqlSession.selectOne("mapper.board.likeCheck", likeMap);
		return result;
	}
	
	// 게시글 추천수 증가, 감소
	@Override
	public int addLike(int articleNO) throws DataAccessException {
		// 글번호에 해당하는 게시글 추천수 증가
		int result = sqlSession.update("mapper.board.addLike", articleNO);
		return result;
	}

	@Override
	public int cancelLike(int articleNO) throws DataAccessException {
		// 글번호에 해당하는 게시글 추천수 감소
		int result = sqlSession.update("mapper.board.cancelLike", articleNO);
		return result;
	}

	// 게시글 추천 기록 추가, 삭제
	@Override
	public int insertLike(int articleNO, String member_id) throws DataAccessException {
		// 글번호, 아이디를 담아 SQL에 전달할 Map 생성
		Map<String, Object> likeMap = new HashMap<String, Object>();
		likeMap.put("articleNO", articleNO);
		likeMap.put("member_id", member_id);
		
		// Map을 파라미터로 전달해 SQL 실행
		return sqlSession.insert("mapper.board.insertLike", likeMap);
	}

	@Override
	public int deleteLike(int articleNO, String member_id) throws DataAccessException {
		Map<String, Object> likeMap = new HashMap<String, Object>();
		likeMap.put("articleNO", articleNO);
		likeMap.put("member_id", member_id);
		
		return sqlSession.delete("mapper.board.deleteLike", likeMap);
	}

	// 조회수 증가
	@Override
	public int updateHit(int articleNO) throws DataAccessException {
		return sqlSession.update("mapper.board.updateHit", articleNO);
	}
	
	// 게시글의 댓글수 증가, 감소
	@Override
	public int updateCommentsByArticleNO(HashMap<String, Integer> amountMap) throws DataAccessException {
		// 글번호, 댓글 증감량 가지고 가서 댓글수 업데이트
		return sqlSession.update("mapper.board.updateBoardComment", amountMap);
	}

	// 게시글의 첨부파일 수정
	@Override
	public int updateArticleImgFileName(BoardDTO boardDTO) throws DataAccessException {
		return sqlSession.update("mapper.board.updateArticleImgFileName", boardDTO);
	}

	// 댓글번호로 작성자id 찾기
	@Override
	public String selectMember_idByCommentNO(int commentNO) throws DataAccessException {
		String member_id = sqlSession.selectOne("mapper.board.selectMember_idByCommentNO", commentNO);
		return member_id;
	}
	
	
	// 페이징 구현 
	
	// 전체 글 수 가져오기
	@Override
	public int countArticles() throws Exception {
		return sqlSession.selectOne("mapper.board.countArticles");
	}
	
	
	@Override
	public List<BoardDTO> selectPageArticle(int displayPost, int postNum) throws Exception {
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		data.put("displayPost", displayPost);
		data.put("postNum", postNum);
		
		return sqlSession.selectList("mapper.board.selectPageArticle", data);
	}
	

	@Override
	public int countSearchArticleByKeyword(HashMap<String, Object> searchMap) throws Exception {
		return sqlSession.selectOne("mapper.board.countSearchArticleByKeyword", searchMap);
	}
	
	@Override
	public List<BoardDTO> searchPageArticleByKeyword(HashMap<String, Object> searchPageMap) throws Exception {
		return sqlSession.selectList("mapper.board.searchPageArticleByKeyword", searchPageMap);
	}
}
