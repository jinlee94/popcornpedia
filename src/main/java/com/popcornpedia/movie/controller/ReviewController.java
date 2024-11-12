package com.popcornpedia.movie.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.popcornpedia.movie.dto.ReviewDTO;

public interface ReviewController {
	public ModelAndView selectAllReview(@RequestParam("movie_id") String movie_id,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView insertReview(@ModelAttribute("reviewDTO") ReviewDTO reviewDTO,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView updateReview(@ModelAttribute("reviewDTO") ReviewDTO reviewDTO,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView deleteReview(@RequestParam("member_id") String member_id, @RequestParam("reviewNO") int reviewNO,HttpServletRequest request, HttpServletResponse response) throws Exception;
	//public ModelAndView selectMovieUserAllReview(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView formReview(@RequestParam(value ="reviewNO", required = false) int reviewNO, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView moreMovieReview(@RequestParam("movie_id") String movie_id) throws Exception;
	public int updateLikeReview(int reviewNO, String member_id);
	public ModelAndView selectReviewById(@RequestParam("member_id") String member_id, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ReviewDTO checkReview(String movie_id, String member_id);
	public int countMovieReview(@RequestParam("movie_id") String movie_id) throws Exception;

}
