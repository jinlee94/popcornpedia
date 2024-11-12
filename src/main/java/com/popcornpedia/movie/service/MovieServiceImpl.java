package com.popcornpedia.movie.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.popcornpedia.movie.dao.ReviewDAO;
import com.popcornpedia.movie.dao.StarRatingDAO;
import com.popcornpedia.movie.dto.MovieDTO;
import com.popcornpedia.movie.dto.ReviewDTO;
import com.popcornpedia.movie.dto.StarRatingDTO;

@Service("MovieService")
public class MovieServiceImpl implements MovieService{

	@Autowired
	private ReviewDAO reviewDAO;
	
	@Autowired
	private StarRatingDAO starRatingDAO;
	
	// 전체 리뷰 조회
	@Override
	public List<ReviewDTO> selectAllReview(String movie_id) {
		List reviewList = null;
		reviewList = reviewDAO.selectAllReview(movie_id);
		return reviewList;
	}
	
	// 유저 리뷰 조회
	@Override
	public List<ReviewDTO> selectReviewById(String member_id) {
		List reviewList = null;
		reviewList = reviewDAO.selectReviewById(member_id);
		return reviewList;
	}
	
	// 상세 리뷰 정보 가져오기
	@Override
	public ReviewDTO selectReviewByreviewNO(int reviewNO) {
		ReviewDTO reviewDTO = null;
		reviewDTO = reviewDAO.selectReviewByreviewNO(reviewNO);
		return reviewDTO;
	}
	
	// 리뷰 작성
	@Override
	public int insertReview(ReviewDTO reviewDTO) {
		int result = reviewDAO.insertReview(reviewDTO);
		return result;
	}

	// 리뷰 수정
	@Override
	public int updateReview(ReviewDTO reviewDTO) {
		int result = reviewDAO.updateReview(reviewDTO);
		return result;
	}

	// 리뷰 삭제
	@Override
	public int deleteReview(Map<String, Object> deleteParams) {
		int result = reviewDAO.deleteReview(deleteParams);
		return result;
	}
	
	// 리뷰 좋아요 
	@Override
	public int addLikeReview(Map<String, Object> addLikeParams) {
		int result = reviewDAO.addLikeReview(addLikeParams);
		return result;
	}
	
	
	// 리뷰 좋아요 취소
	@Override
	public int cancelLikeReview(Map<String, Object> cancelLikeParams) {
		int result = reviewDAO.cancelLikeReview(cancelLikeParams);
		return result;
	}
	
	// 좋아요 상태 체크 return 1이면 좋아요 누름 0이면 안누름
	@Override
	public int likeCheck(Map<String, Object> likeParams) {
		int result = reviewDAO.likeCheck(likeParams);
		return result;
	}

	
	// 좋아요 수 업데이트 
	@Override
	public int updateLike(Map<String, Object> likeParams) {
		int result = reviewDAO.updateLike(likeParams);
		return result;	
	}
	
	
	// 게시글 좋아요수 +
	@Override
	public int plusLikeReview(Map<String, Object> likeParams) {
		int result = reviewDAO.plusLikeReview(likeParams);
		return result;
	}
	
	// 게시글 좋아요수 -
	@Override
	public int minusLikeReview(Map<String, Object> likeParams) {
		int result = reviewDAO.minusLikeReview(likeParams);
		return result;
	}

	
	// 별점 작성 
	public int insertStarRating(StarRatingDTO starRatingDTO) {
		int result = starRatingDAO.insertStarRating(starRatingDTO);
		return result;
	}
	

	// id로 별점 가져오기
	@Override
	public List<StarRatingDTO> selectStarRatingById(String member_id) {
		List<StarRatingDTO> starRatingList;
		starRatingList = starRatingDAO.selectStarRatingById(member_id);
		return starRatingList;
	}

	// movie로 별점 가져오기
	@Override
	public List<StarRatingDTO> selectStarRatingByMovie(String movie_id) {
		List<StarRatingDTO> starRatingList;
		starRatingList = starRatingDAO.selectStarRatingByMovie(movie_id);
		return starRatingList;
	}
	
	
	// ratingNO 으로 별점 가져오기
	@Override
	public StarRatingDTO selectStarRatingByRatingNO(int ratingNO) {
		StarRatingDTO starRatingDTO = starRatingDAO.selectStarRatingByRatingNO(ratingNO);
		return starRatingDTO;
	}


	// 별점 삭제
	@Override
	public int deleteStarRating(Map<String, Object> starRatingParams) {
		int result = 0;
		result = starRatingDAO.deleteStarRating(starRatingParams);
		return result;
	}

	// 별점 수정
	@Override
	public int updateStarRating(StarRatingDTO starRatingDTO) {
		int result = 0;
		result = starRatingDAO.updateStarRating(starRatingDTO);
		return result;
	}
	
	// 리뷰 작성 여부 체크
	@Override
	public ReviewDTO checkReview(Map<String, String> reviewParams) {
		
		ReviewDTO reviewDTO = reviewDAO.checkReview(reviewParams);
		return reviewDTO;
	}
	
	
	// movie_id 로 영화 평균 별점 가져오기
	@Override
	public double avgStarRating(String movie_id) {
		double result = starRatingDAO.avgStarRating(movie_id);
		return result;
	}
	
	
	// 별점 작성 여부 체크, 작성했다면 값 받아오기 
	public double checkStarRating(Map<String,String> starRatingParams) {
		double result = starRatingDAO.checkStarRating(starRatingParams);
		return result;
	}
	
	// 상세 평점만 삭제
	@Override
	public int deleteDetailStarRating(Map<String, String> starRatingParams) {
		int result = starRatingDAO.deleteDetailStarRating(starRatingParams);
		return result;
	}
	
	
	// 상세 별점 불러오기
	public StarRatingDTO checkDetailStarRating(Map<String,String> starRatingParams) {
		
		StarRatingDTO starRatingDTO = starRatingDAO.checkDetailStarRating(starRatingParams);
		return starRatingDTO;
	}
	
	// 상세 별점 업데이트
	@Override
	public int updateDetailStarRating(StarRatingDTO starRatingDTO) {
		
		int result = starRatingDAO.updateDetailStarRating(starRatingDTO);
		return result;
	}

	@Override
	public MovieDTO selectMovieDTO(String movie_id) {
		MovieDTO movieDTO = reviewDAO.selectMovieDTO(movie_id);
		return movieDTO;
	}


	@Override
	public int countMovieReview(String movie_id) {
		int movieCnt = reviewDAO.countMovieReview(movie_id);
		return movieCnt;
	}

	
}
