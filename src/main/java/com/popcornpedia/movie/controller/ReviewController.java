package com.popcornpedia.movie.controller;

import java.util.List;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.popcornpedia.movie.dto.MovieDTO;
import com.popcornpedia.movie.dto.ReviewDTO;
import com.popcornpedia.movie.service.MovieService;

@Controller
public class ReviewController {


    @Autowired
    private MovieService movieService;

    //@Autowired
    //private ReviewDTO reviewDTO;

    // 사용중
    // 상세페이지 영화 리뷰
    @RequestMapping(value = "/movie/allReviews.do", method = RequestMethod.GET)
    public ModelAndView selectAllReview(@RequestParam("movie_id") String movie_id, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String viewName = "/movie/listReviews";
        List<ReviewDTO> reviewList = movieService.selectAllReview(movie_id);
        ModelAndView mav = new ModelAndView(viewName);
        mav.addObject("reviewList", reviewList);
        return mav;
    }


    // 영화 리뷰 전체조회
    @RequestMapping(value = "/movie/moreReviews")
    public ModelAndView moreMovieReview(@RequestParam("movie_id") String movie_id) throws Exception {

        List<ReviewDTO> reviewList = movieService.selectAllReview(movie_id);
        for (ReviewDTO reviewDTO : reviewList) {
            System.out.println(reviewDTO.getMemberImgName());
        }
        MovieDTO movieDTO = movieService.selectMovieDTO(movie_id);
        String movieNm = movieDTO.getMovieNm();
        ModelAndView mav = new ModelAndView("/movie/movieReviews");
        mav.addObject("reviewList", reviewList);
        mav.addObject("movieNm", movieNm);
        return mav;

    }

    // 사용중
    // 유저 리뷰 전체조회
    @RequestMapping(value = "/movie/userAllReviews.do")
    public ModelAndView selectReviewById(@RequestParam("member_id") String member_id, HttpServletRequest request, HttpServletResponse response) throws Exception {
        ModelAndView mav = new ModelAndView("/movie/userReviews");
        List<ReviewDTO> reviewList = movieService.selectReviewById(member_id);
        System.out.println(reviewList);
        if (reviewList.size() == 0) {
            return mav;
        }

        ReviewDTO reviewDTO = reviewList.get(0);
        String userNickName = reviewDTO.getNickname();
        String userMemberImgName = reviewDTO.getMemberImgName();
        String userId = reviewDTO.getMember_id();


        mav.addObject("reviewList", reviewList);
        mav.addObject("userNickName", userNickName);
        mav.addObject("userMemberImgName", userMemberImgName);
        mav.addObject("userId", userId);
        return mav;

    }

    // 사용중
    // 리뷰 작성
    @RequestMapping(value = "/movie/writeReview.do", method = RequestMethod.POST)
    public ModelAndView insertReview(@ModelAttribute("reviewDTO") ReviewDTO reviewDTO,
                                     HttpServletRequest request, HttpServletResponse response) throws Exception {

        int result = movieService.insertReview(reviewDTO);

        String originalUrl = request.getHeader("referer");
        ModelAndView mav = new ModelAndView("redirect:" + originalUrl);
        return mav;
    }

    // 사용중
    // 리뷰 수정
    @RequestMapping(value = "/movie/modReview.do", method = RequestMethod.POST)
    public ModelAndView updateReview(@ModelAttribute("reviewDTO") ReviewDTO reviewDTO,
                                     HttpServletRequest request, HttpServletResponse response) throws Exception {

        int result = movieService.updateReview(reviewDTO);

        String originalUrl = request.getHeader("referer");
        ModelAndView mav = new ModelAndView("redirect:" + originalUrl);
        return mav;
    }

    // 사용중
    // 리뷰 삭제
    @RequestMapping(value = "/movie/deleteReview.do", method = RequestMethod.GET)
    public ModelAndView deleteReview(@RequestParam("member_id") String member_id, @RequestParam("reviewNO") int reviewNO,
                                     HttpServletRequest request, HttpServletResponse response) throws Exception {

        Map<String, Object> deleteParams = new HashMap<>();
        deleteParams.put("member_id", member_id);
        deleteParams.put("reviewNO", reviewNO);

        int result = movieService.deleteReview(deleteParams);
        String originalUrl = request.getHeader("referer");
        ModelAndView mav = new ModelAndView("redirect:" + originalUrl);
        return mav;
    }


    // 리뷰 작성,수정 페이지 요청
    @RequestMapping(value = "/movie/reviewForm.do", method = RequestMethod.GET)
    public ModelAndView formReview(@RequestParam(value = "reviewNO", required = false, defaultValue = "0") int reviewNO, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String viewName = "/movie/reviewForm";
        ModelAndView mav = new ModelAndView(viewName);
        if (reviewNO > 0) {
            ReviewDTO reviewDTO = movieService.selectReviewByreviewNO(reviewNO);
            mav.addObject("reviewDTO", reviewDTO);
        }

        return mav;
    }


    // 사용중
    // 리뷰 좋아요, 좋아요 취소 통합
    @ResponseBody
    @RequestMapping(value = "/movie/updateLike.do", method = RequestMethod.POST)
    public int updateLikeReview(int reviewNO, String member_id) {

        Map<String, Object> likeParams = new HashMap();
        likeParams.put("reviewNO", reviewNO);
        likeParams.put("member_id", member_id);


        int likeCheck = movieService.likeCheck(likeParams); // 좋아요 상태 체크

        if (likeCheck == 0) {                                // likeCheck 0 이면 좋아요 안누른 상태
            movieService.addLikeReview(likeParams);        // 좋아요 추가
            movieService.plusLikeReview(likeParams);            // 좋아요 수 + 업데이트
        } else if (likeCheck == 1) {                            // likeCheck 1 이면 좋아요 누른 상태
            movieService.cancelLikeReview(likeParams);        // 좋아요 취소
            movieService.minusLikeReview(likeParams);            // 좋아요 수 - 업데이트
        }

        return likeCheck;
    }


    // 사용중
    // 좋아요 여부 체크
    @ResponseBody
    @RequestMapping(value = "/movie/likeCheck.do", method = RequestMethod.GET)
    public int likeCheck(int reviewNO, String member_id) {

        Map<String, Object> likeParams = new HashMap();
        likeParams.put("reviewNO", reviewNO);
        likeParams.put("member_id", member_id);

        int likeCheck = movieService.likeCheck(likeParams);

        return likeCheck;
    }


    // 테스트용 영화 상세 페이지
    @RequestMapping(value = "/movie/movieInfo.do", method = RequestMethod.GET)
    public ModelAndView info(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String viewName = "/movie/movieInfo";
        ModelAndView mav = new ModelAndView(viewName);
        return mav;
    }

    // 사용중
    // 리뷰 작성 여부
    @ResponseBody
    @RequestMapping(value = "/movie/checkReview.do", method = RequestMethod.GET)
    public ReviewDTO checkReview(String movie_id, String member_id) {
        Map<String, String> reviewParams = new HashMap();

        reviewParams.put("movie_id", movie_id);
        reviewParams.put("member_id", member_id);

        ReviewDTO reviewDTO = movieService.checkReview(reviewParams);


        if (reviewDTO == null) {
            reviewDTO = new ReviewDTO();

            return reviewDTO;
        }

        return reviewDTO;
    }


    // MovieDTO 가져오기 포스터가져오기 용
    @ResponseBody
    @RequestMapping(value = "/movie/selectMovieDTO.do")
    public MovieDTO selectMovieDTO(@RequestParam("movie_id") String movie_id, HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        MovieDTO movieDTO = movieService.selectMovieDTO(movie_id);
        System.out.println(movieDTO.getMovieNm());
        System.out.println(movieDTO.getMoviePosterPath());
        return movieDTO;
    }


    @ResponseBody
    @RequestMapping(value = "/movie/countMovieReview.do")
    public int countMovieReview(@RequestParam("movie_id") String movie_id) throws Exception {
        System.out.println(movie_id);
        int reviewCnt = movieService.countMovieReview(movie_id);

        return reviewCnt;
    }


}
