package com.popcornpedia.movie.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.popcornpedia.movie.dto.ReviewDTO;
import com.popcornpedia.movie.dto.StarRatingDTO;
import com.popcornpedia.movie.service.MovieService;

@Controller("starRatingController")
public class StarRatingControllerImpl implements StarRatingController{


	@Autowired
	private MovieService movieService;
	
	
	// 사용중
	// 별점 작성 
	@RequestMapping(value="/movie/writeStarRating.do")
	public ModelAndView insertStarRating(@ModelAttribute("starRatingDTO") StarRatingDTO starRatingDTO,HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		int result = movieService.insertStarRating(starRatingDTO);
		ModelAndView mav = new ModelAndView("redirect:/movie/movieInfo.do");
		return mav;
		
	}
	
	// 사용중
	// 별점 수정 
	@Override
	@RequestMapping(value="/movie/modStarRating.do")
	public ModelAndView updateStarRating(@ModelAttribute("starRatingDTO") StarRatingDTO starRatingDTO,HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int result = movieService.updateStarRating(starRatingDTO);
		ModelAndView mav = new ModelAndView("redirect:/movie/movieInfo.do");
		return mav;
	}
 
	// 사용중
	// 별점 삭제 (member_id , movie_id)
	@Override
	@RequestMapping( value="/movie/deleteStarRating.do", method = RequestMethod.POST)
	public ModelAndView deleteStarRating(@RequestParam(value ="member_id") String member_id, @RequestParam(value="movie_id") String movie_id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		Map<String, Object> starRatingParam = new HashMap();
		starRatingParam.put("member_id", member_id);
		starRatingParam.put("movie_id", movie_id);
		movieService.deleteStarRating(starRatingParam);
		ModelAndView mav = new ModelAndView("redirect:/movie/userStarRatings.do?member_id=kim");
		return mav;
	}
	
	

	//사용중
	@Override
	@ResponseBody
	@RequestMapping(value="/movie/avgStarRating.do", method = RequestMethod.GET)
	public double avgStarRating(@RequestParam(value="movie_id")String movie_id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
	
		double result = movieService.avgStarRating(movie_id);
		return result;
	}
	
	

	
	// 사용중
	// 별점  가져오기 .
	@ResponseBody
	@RequestMapping(value="/movie/checkStarRating.do", method = RequestMethod.GET)
	public double checkStarRating(@RequestParam(value="movie_id") String movie_id, @RequestParam(value="member_id") String member_id,HttpServletRequest request, HttpServletResponse response) throws Exception  {
		
		Map<String,String> starRatingParams = new HashMap();
		
		starRatingParams.put("movie_id", movie_id);
		starRatingParams.put("member_id", member_id);
		
		double result = 0;
		result = movieService.checkStarRating(starRatingParams);
	
		return result;
	}
	
	
	// 사용중
	// 상세 평점만 삭제하기 
	@Override
	@RequestMapping(value="/movie/deleteDetailStarRating.do", method = RequestMethod.GET)
	public ModelAndView deleteDetailStarRating(String movie_id, String member_id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Map<String,String> starRatingParams = new HashMap();
		
		starRatingParams.put("movie_id", movie_id);
		starRatingParams.put("member_id", member_id);
		
		int result = movieService.deleteDetailStarRating(starRatingParams);
		
		return null;
	}
	
	// 사용중
	@ResponseBody
	@RequestMapping(value="/movie/checkDetailStarRating.do", method = RequestMethod.GET)
	public StarRatingDTO checkDetailStarRating(String movie_id, String member_id,HttpServletRequest request, HttpServletResponse response) throws Exception  {
		
		Map<String,String> starRatingParams = new HashMap();
		
		starRatingParams.put("movie_id", movie_id);
		starRatingParams.put("member_id", member_id);
	
		StarRatingDTO starRatingDTO = movieService.checkDetailStarRating(starRatingParams);
		
		return starRatingDTO;
	}
	
	
	
	/*// 별점 수정/삭제 폼 요청
	@RequestMapping(value="/movie/starRatingForm.do", method= RequestMethod.GET)
	public ModelAndView formStarRating(@RequestParam(value ="ratingNO", required = false, defaultValue = "0") int ratingNO,HttpServletRequest request, HttpServletResponse response) throws Exception{
			String viewName = "/movie/starRatingForm";	
			ModelAndView mav = new ModelAndView(viewName);
			if( ratingNO > 0) {
				StarRatingDTO starRatingDTO = movieService.selectStarRatingByRatingNO(ratingNO);
				mav.addObject("starRatingDTO", starRatingDTO);
			}
					
			return mav;
	}
	
	
	// ID로 별점 가져오기
	@Override
	@RequestMapping(value="/movie/userStarRatings.do", method = RequestMethod.GET)
	public ModelAndView selectStarRatingById(HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String member_id = session.getAttribute("member_id");
		ModelAndView mav = new ModelAndView("movie/listStarRating");
		List<StarRatingDTO> starRatingList = movieService.selectStarRatingById(member_id);
		mav.addObject("starRatingList",starRatingList);
		
		return mav;
		
	}

	*/
	// movie_id 로 별점 가져오기
	@Override
	@RequestMapping(value="/movie/movieStarRatings.do", method = RequestMethod.GET)
	public ModelAndView selectStarRatingByMovie(@RequestParam(value="movie_id")String movie_id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView("movie/listStarRating");
		List<StarRatingDTO> starRatingList = movieService.selectStarRatingByMovie(movie_id);
		mav.addObject("starRatingList",starRatingList);
		
		return mav;
	}

	
	
	// 사용중
	@Override
	@RequestMapping(value="/movie/modDetailStarRating.do")
	public ModelAndView modDetailStarRating(@ModelAttribute("starRatingDTO") StarRatingDTO starRatingDTO, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
	
		int result = movieService.updateDetailStarRating(starRatingDTO);
		ModelAndView mav = new ModelAndView("redirect:/movie/movieInfo.do");
		return mav;
	
	}
	
	
}
