package com.popcornpedia.movie.dao;

import java.util.List;
import java.util.Map;

import com.popcornpedia.movie.dto.StarRatingDTO;

public interface StarRatingDAO {
	public int insertStarRating(StarRatingDTO starRatingDTO);
	public int deleteStarRating(Map<String, Object> starRatingParams);
	public int updateStarRating(StarRatingDTO starRatingDTO);
	public List<StarRatingDTO> selectStarRating(String member_id);
	public List<StarRatingDTO> selectStarRatingById(String member_id);
	public List<StarRatingDTO> selectStarRatingByMovie(String movie_id);
	public StarRatingDTO selectStarRatingByRatingNO(int ratingNO);
	public double avgStarRating(String movie_id);
	public double checkStarRating(Map<String,String> starRatingParams);
	public int deleteDetailStarRating(Map<String,String> starRatingParams);
	public StarRatingDTO checkDetailStarRating(Map<String,String> starRatingParams);
	public int updateDetailStarRating(StarRatingDTO starRatingDTO);
}
