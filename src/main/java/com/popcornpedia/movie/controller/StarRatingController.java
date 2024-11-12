package com.popcornpedia.movie.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.popcornpedia.movie.dto.StarRatingDTO;

public interface StarRatingController {
	public ModelAndView insertStarRating(@ModelAttribute("starRatingDTO") StarRatingDTO starRatingDTO,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView updateStarRating(@ModelAttribute("starRatingDTO") StarRatingDTO starRatingDTO, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView deleteStarRating(@RequestParam(value ="member_id") String member_id, @RequestParam(value="movie_id") String movie_id,HttpServletRequest request, HttpServletResponse response) throws Exception;
	//public ModelAndView selectStarRatingById(@RequestParam("member_id") String member_id,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView selectStarRatingByMovie(@RequestParam("movie_id") String movie_id,HttpServletRequest request, HttpServletResponse response) throws Exception;
	//public ModelAndView formStarRating(@RequestParam(value ="ratingNO", required = false, defaultValue = "0") int ratingNO,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView deleteDetailStarRating(@RequestParam(value="movie_id")String movie_id, @RequestParam(value="member_id") String member_id,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView modDetailStarRating(@ModelAttribute("starRatingDTO") StarRatingDTO starRatingDTO, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public double avgStarRating(@RequestParam(value="moive_id") String movie_id,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public double checkStarRating(String movie_id, String member_id,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public StarRatingDTO checkDetailStarRating(String movie_id, String member_id,HttpServletRequest request, HttpServletResponse response) throws Exception;
	
}
