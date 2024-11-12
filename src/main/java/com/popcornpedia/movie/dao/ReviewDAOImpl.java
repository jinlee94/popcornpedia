package com.popcornpedia.movie.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.popcornpedia.movie.dto.MovieDTO;
import com.popcornpedia.movie.dto.ReviewDTO;


@Repository("ReviewDAO")
public class ReviewDAOImpl implements ReviewDAO{


	@Autowired
	private SqlSession sqlSession;
	
	// 전체 리뷰 조회
	@Override
	public List<ReviewDTO> selectAllReview(String movie_id) {
		List<ReviewDTO> reviewList =null;
		reviewList = sqlSession.selectList("mapper.review.selectAllReview", movie_id);
		return reviewList;
	}
	
	// 유저 리뷰 조회
	@Override
	public List<ReviewDTO> selectReviewById(String member_id) {
		List<ReviewDTO> reviewList = null;
		reviewList = sqlSession.selectList("mapper.review.selectUserAllReview", member_id);
		return reviewList;
	}

	// 리뷰 작성
	@Override
	public int insertReview(ReviewDTO reviewDTO) {
		int result = sqlSession.insert("mapper.review.insertReview", reviewDTO);
		return result;
	}
	
	// 리뷰 삭제
	@Override
	public int deleteReview(Map<String, Object> deleteParams) {
		int result = sqlSession.delete("mapper.review.deleteReview",deleteParams);
		return result;
	}

	// 리뷰 수정
	@Override
	public int updateReview(ReviewDTO reviewDTO) {
		int result = sqlSession.update("mapper.review.updateReview", reviewDTO);
		return result;
	}

	// 상세 리뷰 정보 조회
	@Override
	public ReviewDTO selectReviewByreviewNO(int reviewNO) {
		ReviewDTO reviewDTO = sqlSession.selectOne("mapper.review.selectReview", reviewNO);
		return reviewDTO;
	}
	
	
	// 좋아요 
	@Override
	public int addLikeReview(Map<String, Object> addLikeParams) {
		int result = sqlSession.insert("mapper.review.addLikeReview", addLikeParams);

		return 0;
	}
	
	
	// 좋아요 취소
	@Override
	public int cancelLikeReview(Map<String, Object> cancelLikeParams) {
		int result = sqlSession.delete("mapper.review.cancelLikeReview", cancelLikeParams);
		return 0;
	}
	
	
	// 좋아요 상태 확인. 
	@Override
	public int likeCheck(Map<String, Object> likeParams) {
		int result = sqlSession.selectOne("mapper.review.likeCheck", likeParams);
		return result;
	}
	
	// 좋아요 수 업데이트 
	@Override
	public int updateLike(Map<String, Object> likeParams) {
		int result  = sqlSession.update("mapper.review.updateLike", likeParams);
		return result;
	}
	

	// 게시글 좋아요 수 +
	@Override
	public int plusLikeReview(Map<String, Object> likeParams) {
		int result = sqlSession.update("mapper.review.plusLikeReview", likeParams);
		return result;
	}

	// 게시글 좋아요 수 - 
	@Override
	public int minusLikeReview(Map<String, Object> likeParams) {
		int result = sqlSession.update("mapper.review.minusLikeReview", likeParams);
		return result;
	}
	
	// 리뷰 작성 여부 체크
	@Override
	public ReviewDTO checkReview(Map<String, String> reviewParams) {
		ReviewDTO reviewDTO = sqlSession.selectOne("mapper.review.checkReview", reviewParams);
		
		return reviewDTO;
	}
	
	@Override
	public MovieDTO selectMovieDTO(String movie_id) {
		MovieDTO movieDTO = sqlSession.selectOne("mapper.movie.selectOneMovie", movie_id);
		return movieDTO;
	}
	


	@Override
	public int countMovieReview(String movie_id) {
		int movieCnt = sqlSession.selectOne("mapper.review.countReviewsByMovie_id",movie_id);
		return movieCnt;
	}
	
}
