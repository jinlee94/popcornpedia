package com.popcornpedia.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestBody;

import com.popcornpedia.board.dto.BoardDTO;
import com.popcornpedia.member.dto.MemberDTO;
import com.popcornpedia.movie.dto.ReviewDTO;
import com.popcornpedia.movie.dto.StarRatingDTO;

public interface UserDAO {
	public List<ReviewDTO> selectMyReviews(String member_id);
	public List<BoardDTO> selectMyArticles(Map<String,Object> myArticlesMap);
	public List<StarRatingDTO> selectMyStarRatings(String member_id);
	public int updateMyInfo(MemberDTO memberDTO);
	public MemberDTO selectMyMemberDTO(MemberDTO memberDTO);
	public MemberDTO selectUserByNickname(String nickname);
	public int updateMyProfile(MemberDTO memberDTO);
	public int updateMemberImgFileName(MemberDTO memberDTO);
	public int countMyReviews(String member_id);
	public double avgMyStarRating(String member_id);
	public int countMyArticles(String member_id);
	public int countMyStarRatings(String member_id);
	public double maxMyStarRating(String member_id);
	public List<Map<String, Object>> tasteMyStarRating(String member_id);
	public int countWatchTime(String member_id);
	public List<Map<String, Object>> tasteMovieNation(String member_id);
	public List<Map<String, Object>> tasteMovieDirector(String member_id);
	public List<String> tasteMovieActor(String member_id);
	public List<String> tasteMovieGenre(String member_id);
	public int updateEmail(@RequestBody HashMap<String, Object> emailMap) throws Exception;
	public int countWishMovie(String member_id) throws Exception ;
}
