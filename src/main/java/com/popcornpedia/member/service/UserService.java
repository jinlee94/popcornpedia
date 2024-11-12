package com.popcornpedia.member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.multipart.MultipartFile;

import com.popcornpedia.board.dto.BoardDTO;
import com.popcornpedia.member.dto.MemberDTO;
import com.popcornpedia.movie.dto.ReviewDTO;
import com.popcornpedia.movie.dto.StarRatingDTO;

public interface UserService {

	public List<ReviewDTO> selectMyReviews(String member_id);
	public List<BoardDTO> selectMyArticles(Map<String,Object> myArticlesMap);
	public List<StarRatingDTO> selectMyStarRatings(String member_id);
	public MemberDTO updateMyInfo(MemberDTO memberDTO);
	public MemberDTO updateMyProfile(MultipartFile file, MemberDTO memberDTO, boolean deleteFile, HttpSession session);
	public MemberDTO selectUserByNickname(String nickname);
	public int countMyReviews(String member_id);
	public double avgMyStarRating(String member_id);
	public int countMyArticles(String member_id);
	public int countMyStarRatings(String member_id);
	public double maxMyStarRating(String member_id);
	public List<Map<String, Object>> tasteMyStarRating(String member_id);
	public List<Map<String, Object>> tasteMovieNation(String member_id);
	public List<Map<String, Object>> tasteMovieDirector(String member_id);
	public int countWatchTime(String member_id);
	public List<Map.Entry<String, Integer>> tasteMovieActor(String member_id);
	public List<Map.Entry<String, Integer>> tasteMovieGenre(String member_id);
	public int updateEmail(@RequestBody HashMap<String, Object> emailMap) throws Exception;
	public int countWishMovie(String member_id) throws Exception;
} 
