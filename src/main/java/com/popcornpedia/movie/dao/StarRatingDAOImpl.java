package com.popcornpedia.movie.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.popcornpedia.movie.dto.StarRatingDTO;

@Repository("StarRatingDAO")
public class StarRatingDAOImpl implements StarRatingDAO{



	@Autowired
	private SqlSession sqlSession;
	
	
	// 별점 작성
	@Override
	public int insertStarRating(StarRatingDTO starRatingDTO) {
		int result = sqlSession.insert("mapper.starRating.insertStarRating", starRatingDTO);
		return result;
	}

	// 별점 삭제
	@Override
	public int deleteStarRating(Map<String, Object> starRatingParams) {
		int result = sqlSession.delete("mapper.starRating.deleteStarRating", starRatingParams);
		return result;
	}

	// 별점 수정
	@Override
	public int updateStarRating(StarRatingDTO starRatingDTO) {
		int result = sqlSession.update("mapper.starRating.updateStarRating", starRatingDTO);
		return result;
	}

	@Override
	public List<StarRatingDTO> selectStarRating(String member_id) {
		
		return null;
	}
	
	// ID로 별점 가져오기
	@Override
	public List<StarRatingDTO> selectStarRatingById(String member_id) {
		List<StarRatingDTO> starRatingList;
		starRatingList = sqlSession.selectList("mapper.starRating.selectStarRatingById", member_id);
		return starRatingList;
	}

	// movie_id 로 별점 가져오기 
	@Override
	public List<StarRatingDTO> selectStarRatingByMovie(String movie_id) {
		List<StarRatingDTO> starRatingList;
		starRatingList = sqlSession.selectList("mapper.starRating.selectStarRatingByMovie", movie_id);
		return starRatingList;
	}

	// RatingNO으로 별점 가져오기
	@Override
	public StarRatingDTO selectStarRatingByRatingNO(int ratingNO) {
		StarRatingDTO starRatingDTO;
		starRatingDTO = sqlSession.selectOne("mapper.starRating.selectStarRatingByRatingNO", ratingNO);
		return starRatingDTO;
	}
	
	// movie_id 의 평균 별점
	@Override
	public double avgStarRating(String movie_id) {
		double result;
		Double Double_result = sqlSession.selectOne("mapper.starRating.avgStarRating", movie_id);
		if(Double_result==null) {
			return 0;
		}
		result = Double_result;
		
		return result;
	}

	// 별점 가져오기
	@Override
	public double checkStarRating(Map<String,String> starRatingParams) {
		Double result; 
		result = sqlSession.selectOne("mapper.starRating.checkStarRating", starRatingParams);
		
		double a = 0;
		
		if(result==null) {
			result= a;
		}
		
		return result;
	}	
	
	// 상세 별점만 삭제
	@Override
	public int deleteDetailStarRating(Map<String, String> starRatingParams) {
		int result;
		result = sqlSession.delete("mapper.starRating.deleteDetailStarRating", starRatingParams);
		return result;
	}

	
	// 상세 별점 체크
	@Override
	public StarRatingDTO checkDetailStarRating(Map<String,String> starRatingParams) {
		
		StarRatingDTO starRatingDTO = sqlSession.selectOne("mapper.starRating.checkDetailStarRating", starRatingParams);
	
		return starRatingDTO;
	}	
	
	
	// 상세 별점 업데이트
	@Override
	public int updateDetailStarRating(StarRatingDTO starRatingDTO) {
		int result;
		result = sqlSession.update("mapper.starRating.updateDetailStarRating", starRatingDTO);
		return result;
	}
	
	
}
