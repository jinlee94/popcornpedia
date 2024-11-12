package com.popcornpedia.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.popcornpedia.board.dto.BoardDTO;
import com.popcornpedia.member.dto.MemberDTO;
import com.popcornpedia.movie.dto.ReviewDTO;
import com.popcornpedia.movie.dto.StarRatingDTO;

@Repository("userDAO")
public class UserDAOImpl implements UserDAO{


	@Autowired
	private SqlSession sqlSession;
	
	// member_id 로 리뷰들 가져오기
	@Override
	public List<ReviewDTO> selectMyReviews(String member_id) {
		
		return sqlSession.selectList("mapper.review.selectUserAllReview", member_id);
	}

	// member_id 로 보드들 가져오기
	@Override
	public List<BoardDTO> selectMyArticles(Map<String,Object> myArticlesMap) {
		
		return sqlSession.selectList("mapper.board.selectArticleByMember_id", myArticlesMap);
	}
	
	@Override
	public List<StarRatingDTO> selectMyStarRatings(String member_id) {
	
		return sqlSession.selectList("mapper.starRating.selectStarRatingById", member_id);
	}

	
	// 내 정보 업데이트
	@Override
	public int updateMyInfo(MemberDTO memberDTO) {
		
		return sqlSession.update("mapper.user.updateMyInfo", memberDTO);
	}
	
	
	// 내 정보 DTO 가져오기
	@Override
	public MemberDTO selectMyMemberDTO(MemberDTO memberDTO) {
		
		return sqlSession.selectOne("mapper.user.selectMyMemberDTO", memberDTO);
	}
	
	
	// 내 프로필 업데이트
	public int updateMyProfile(MemberDTO memberDTO) {
		
		return sqlSession.update("mapper.user.updateMyProfile", memberDTO);
		
	}
	
	
	// 내 프로필 이미지이름 업데이트
	@Override
	public int updateMemberImgFileName(MemberDTO memberDTO) {
		
		return sqlSession.update("mapper.user.updateMemberImgFileName", memberDTO);
	}
	
	
	// 리뷰 개수
	public int countMyReviews(String member_id) {
		return sqlSession.selectOne("mapper.review.countReviewsByMember_id", member_id);
	}
	
	public double avgMyStarRating(String member_id) {
		double result;
		Double Double_result = sqlSession.selectOne("mapper.starRating.avgStarRatingByMember_id", member_id);
		if(Double_result==null) {
			return 0;
		}
		result = Double_result;
		
		return result;
	}
	

	@Override
	public int countMyArticles(String member_id) {
		
		return sqlSession.selectOne("mapper.board.countArticlesByMember_id", member_id);
	}
	

	@Override
	public int countMyStarRatings(String member_id) {
		
		return sqlSession.selectOne("mapper.starRating.countStarRatingByMember_id", member_id);
	}

	@Override
	public double maxMyStarRating(String member_id) {
		
		Map<String, Object> result = sqlSession.selectOne("mapper.starRating.maxStarRatingByMember_id", member_id);
		
		double starRating = (double) result.get("rating");
		
		return starRating;
	}

	@Override
	public List<Map<String, Object>> tasteMyStarRating(String member_id) {
		List<Map<String, Object>> tasteMyStarRating = sqlSession.selectList("mapper.starRating.tasteMyStarRating", member_id);
		return tasteMyStarRating;
	}

	@Override
	public int countWatchTime(String member_id) {
		int result =sqlSession.selectOne("mapper.starRating.countWatchTime", member_id);
		return result ;
	}

	@Override
	public List<Map<String, Object>> tasteMovieNation(String member_id) {
		List<Map<String, Object>> tasteMovieNation = sqlSession.selectList("mapper.starRating.tasteMovieNation", member_id);
		return tasteMovieNation;
	}


	@Override
	public List<Map<String, Object>> tasteMovieDirector(String member_id) {
		List<Map<String, Object>> tasteMovieDirector = sqlSession.selectList("mapper.starRating.tasteMovieDirector", member_id);
		return tasteMovieDirector;
	}

	@Override
	public List<String> tasteMovieActor(String member_id) {
		List<String> tasteMovieActor = sqlSession.selectList("mapper.starRating.tasteMovieActor", member_id);
		return tasteMovieActor;
	}


	@Override
	public List<String> tasteMovieGenre(String member_id) {
		List<String> tasteMovieGenre = sqlSession.selectList("mapper.starRating.tasteMovieGenre", member_id);
		return tasteMovieGenre;
	}
	

	@Override
	public MemberDTO selectUserByNickname(String nickname) {
		MemberDTO userDTO = sqlSession.selectOne("mapper.user.selectUserByNickname", nickname);
	
		return userDTO;
	}

	@Override
	public int updateEmail(HashMap<String, Object> emailMap) throws Exception {
		return sqlSession.update("mapper.user.updateEmail", emailMap);
	}

	public int countWishMovie(String member_id) throws Exception {
		int result = sqlSession.selectOne("mapper.movie.countWishMovie", member_id);
		return result;
	}

	
}
