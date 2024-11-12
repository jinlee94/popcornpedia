package com.popcornpedia.movie.dao;

import java.util.List;
import java.util.Map;

import com.popcornpedia.movie.dto.MovieDTO;
import com.popcornpedia.movie.dto.ReviewDTO;

public interface ReviewDAO {
	public int insertReview(ReviewDTO reviewDTO);
	public int deleteReview(Map<String, Object> deleteParams);
	public int updateReview(ReviewDTO reviewDTO);
	public ReviewDTO selectReviewByreviewNO(int reviewNO);
	public List<ReviewDTO> selectAllReview(String movie_id);
	public List<ReviewDTO> selectReviewById(String member_id);
	public int addLikeReview(Map<String, Object> addLikeParams);
	public int cancelLikeReview(Map<String, Object> cancelLikeParams);
	public int likeCheck(Map<String, Object> likeParams);
	public int updateLike(Map<String, Object> likeParams);
	public int plusLikeReview(Map<String, Object> likeParams);
	public int minusLikeReview(Map<String, Object> likeParams);
	public ReviewDTO checkReview(Map<String, String> reviewParams);
	public MovieDTO selectMovieDTO(String member_id);
	public int countMovieReview(String member_id);
}
