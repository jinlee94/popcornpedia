package com.popcornpedia.movie.service;

import java.util.List;
import java.util.Map;

import com.popcornpedia.movie.dto.*;

public interface MovieService {
	public List<ReviewDTO> selectAllReview(String movie_id);
	public List<ReviewDTO> selectReviewById(String member_id);
	public ReviewDTO selectReviewByreviewNO(int reviewNO);
	public int insertReview(ReviewDTO reviewDTO);
	public int updateReview(ReviewDTO reviewDTO);
	public int deleteReview(Map<String, Object> deleteParams);
	public int addLikeReview(Map<String, Object> addLikeParams);
	public int cancelLikeReview(Map<String, Object> cancelLikeParams);
	public int likeCheck(Map<String, Object> likeParams);
	public int updateLike(Map<String, Object> likeParams);
	public int plusLikeReview(Map<String, Object> likeParams);
	public int minusLikeReview(Map<String, Object> likeParams);
	public int insertStarRating(StarRatingDTO starRatingDTO);
	public List<StarRatingDTO> selectStarRatingById(String member_id);
	public List<StarRatingDTO> selectStarRatingByMovie(String movie_id);
	public StarRatingDTO selectStarRatingByRatingNO(int ratingNO);
	public int deleteStarRating(Map<String,Object> starRatingParams);
	public int updateStarRating(StarRatingDTO starRatingDTO);
	public ReviewDTO checkReview(Map<String,String> reviewParams);
	public double avgStarRating(String movie_id);
	public double checkStarRating(Map<String,String> starRatingParams);
	public int deleteDetailStarRating(Map<String,String> starRatingParams);
	public StarRatingDTO checkDetailStarRating(Map<String,String> starRatingParams);
	public int updateDetailStarRating(StarRatingDTO starRatingDTO);
	public MovieDTO selectMovieDTO(String movie_id);
	public int countMovieReview(String movie_id);
	
}
