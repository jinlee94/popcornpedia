package com.popcornpedia.member.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.multipart.MultipartFile;

import com.popcornpedia.board.dto.BoardDTO;
import com.popcornpedia.common.file.UserFileService;
import com.popcornpedia.member.dao.MemberDAO;
import com.popcornpedia.member.dao.UserDAO;
import com.popcornpedia.member.dto.MemberDTO;
import com.popcornpedia.movie.dto.ReviewDTO;
import com.popcornpedia.movie.dto.StarRatingDTO;

@Service("userService")
public class UserServiceImpl implements UserService{


	@Autowired
	private UserDAO userDAO;
	
	@Autowired
	private UserFileService userFileService;
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public List<ReviewDTO> selectMyReviews(String member_id) {
		List reviewList = null;
		reviewList = userDAO.selectMyReviews(member_id);
		return reviewList;
	}

	@Override
	public List<BoardDTO> selectMyArticles(Map<String,Object> myArticlesMap) {
		List articleList = null;
		articleList = userDAO.selectMyArticles(myArticlesMap);
		return articleList;
	}
	
	@Override
	public List<StarRatingDTO> selectMyStarRatings(String member_id) {
		List starRatingList = null;
		starRatingList = userDAO.selectMyStarRatings(member_id);
		return starRatingList;
	}

	
	@Override
	public MemberDTO updateMyInfo(MemberDTO memberDTO) {
		int result = userDAO.updateMyInfo(memberDTO);
		MemberDTO userDTO=null;
		if(result==1) {
			userDTO = userDAO.selectMyMemberDTO(memberDTO);
		}
		
		return userDTO;
	}
	
	@Override
	public MemberDTO updateMyProfile(MultipartFile file, MemberDTO memberDTO, boolean deleteFile, HttpSession session) {
		int result = userDAO.updateMyProfile(memberDTO);
		
		String member_id = memberDTO.getMember_id();
		HashMap<String, Object> fileMap = new HashMap<String, Object>();
		fileMap.put("member_id", member_id);
		
		if(!file.isEmpty()) {
	
			MemberDTO userDTO = (MemberDTO) session.getAttribute("user");
			String oldFileName = userDTO.getMemberImgName();
			if(!(oldFileName==null)) {
				fileMap.put("FileName", oldFileName);
			}
			
			userFileService.deleteFileOrDirectory(fileMap);
			
			// 파일 업로드
			userFileService.uploadFile(file, fileMap);
			
			
			// 저장된 파일명으로 레코드 업데이트하기
			memberDTO.setMemberImgName(file.getOriginalFilename());
			int imgResult = userDAO.updateMemberImgFileName(memberDTO);
			
			if(result == 1 && imgResult == 1) return userDAO.selectMyMemberDTO(memberDTO);
			
		}
		else if(deleteFile){
			System.out.println("deleteFileName");
			userFileService.deleteFileOrDirectory(fileMap);
			userDAO.updateMemberImgFileName(memberDTO);
	
		}
		
		
		return userDAO.selectMyMemberDTO(memberDTO);
	}
	
	
	
	public int countMyReviews(String member_id){
		int result = userDAO.countMyReviews(member_id);
		
		return result;
	}
	
	@Override
	public double avgMyStarRating(String member_id) {
		double fullresult = userDAO.avgMyStarRating(member_id);
		double result = Math.round(fullresult * 100) / 100.0;
		return result;
	}
	

	@Override
	public int countMyArticles(String member_id) {
		int result = userDAO.countMyArticles(member_id);
		return result;
	}
	
	@Override
	public int countMyStarRatings(String member_id) {
		int result = userDAO.countMyStarRatings(member_id);
		return result;
	}

	@Override
	public double maxMyStarRating(String member_id) {
		double result = userDAO.maxMyStarRating(member_id);
		return result;
	}



	@Override
	public List<Map<String, Object>> tasteMyStarRating(String member_id) {
		List<Map<String, Object>> tasteMyStarRating = userDAO.tasteMyStarRating(member_id);
		
		return tasteMyStarRating;
	}
	
	@Override
	public int countWatchTime(String member_id) {
		int resultMinutes = userDAO.countWatchTime(member_id);
		int resultHour = resultMinutes / 60;
		
		return resultHour;
	}


	@Override
	public List<Map<String, Object>> tasteMovieNation(String member_id) {
		List<Map<String,Object>> tasteMovieNation = userDAO.tasteMovieNation(member_id);
		return tasteMovieNation;
	}
	

	@Override
	public List<Map<String, Object>> tasteMovieDirector(String member_id) {
		List<Map<String,Object>> tasteMovieDirector = userDAO.tasteMovieDirector(member_id);
		return tasteMovieDirector;
	}


	@Override
	public List<Map.Entry<String, Integer>> tasteMovieActor(String member_id) {
		
		
		Map<String, Integer> actorCounts = new HashMap(); 
		
		List<String> actorList = userDAO.tasteMovieActor(member_id);
		
		for(String actors : actorList) {
			if(actors!= null) {
				String[] individualActors = actors.split(",");
				for(String actor : individualActors) {
					actorCounts.put(actor.trim(), actorCounts.getOrDefault(actor.trim(), 0) + 1);
				}
			}
 		}
		List<Map.Entry<String, Integer>> tasteMovieActor = new ArrayList<>(actorCounts.entrySet());
		tasteMovieActor.sort((a, b) -> b.getValue().compareTo(a.getValue()));
		
		return tasteMovieActor;
	}

	@Override
	public List<Entry<String, Integer>> tasteMovieGenre(String member_id) {
		Map<String, Integer> GenreCounts = new HashMap(); 
		
		List<String> genreList = userDAO.tasteMovieGenre(member_id);
		
		for(String genres : genreList) {
			String[] individualGenres = genres.split(",");
			for(String genre : individualGenres) {
				GenreCounts.put(genre.trim(), GenreCounts.getOrDefault(genre.trim(), 0) + 1);
			}
 		}
		List<Map.Entry<String, Integer>> tasteMovieActor = new ArrayList<>(GenreCounts.entrySet());
		tasteMovieActor.sort((a, b) -> b.getValue().compareTo(a.getValue()));
		
		return tasteMovieActor;
	}
	
	@Override
	public MemberDTO selectUserByNickname(String nickname) {
		MemberDTO userDTO =  userDAO.selectUserByNickname(nickname);
		
		return userDTO;
	}

	@Override
	public int updateEmail(@RequestBody HashMap<String, Object> emailMap) throws Exception {
		int result = userDAO.updateEmail(emailMap);
		if(result == 1) { // 이메일이 변경되었으면
			// 이메일 인증 다시 해제하기
			String member_id = (String) emailMap.get("member_id");
			memberDAO.setEmailNotVerified(member_id);
			System.out.println("[UserService] 이메일 인증 정보 해제");
		}
		return result;
	}
	
	public int countWishMovie(String member_id) throws Exception{
		int result = userDAO.countWishMovie(member_id);
		System.out.println("서비스 result : " + result);
		return result;
	}

	
}
