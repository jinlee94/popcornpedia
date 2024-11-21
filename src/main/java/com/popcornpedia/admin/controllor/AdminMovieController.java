package com.popcornpedia.admin.controllor;

import java.io.PrintWriter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.popcornpedia.admin.service.AdminMovieService;
import com.popcornpedia.common.dto.makePagingDTO;
import com.popcornpedia.member.dto.MemberDTO;
import com.popcornpedia.movie.dto.MovieDTO;

@Controller
public class AdminMovieController {
	
	/*
    movieCd : 영진위 코드
    movie_id : 팝콘피디아 DB 추가 순서
     */

	@Autowired
	private AdminMovieService movieService;
	
	// 전체 DB 영화 목록 조회 (관리자 - 영화 조회)
	@RequestMapping(value = "/admin/listMovie")
	public ModelAndView selectAllMovie(@RequestParam(defaultValue = "1") int num) throws Exception {
		// 페이징 처리
		int postNum = 10; // 한 페이지에 표시할 수
		int total = movieService.countMovie(); // 전체 영화 수
		makePagingDTO page = new makePagingDTO(num, total, postNum);
		
		List<MovieDTO> movieList = movieService.selectPageMovie(page.getDisplayPost(), page.getPostNum());
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("movieList", movieList);
		mav.addObject("page", page);
		mav.addObject("selectPageNum", num);
		mav.addObject("total", total);
		mav.setViewName("/admin/listMovie");
		return mav;
	}

	// 영화정보 입력 Form으로 이동 (관리자 - 영화 조회 - 영화추가하기)
	@RequestMapping(value = "/admin/movieForm")
	public ModelAndView MovieForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("admin/movieForm");
	}
	
	// 영화 정보 추가 (관리자 - 영화 조회 - 영화추가하기 - 추가하기)
	@RequestMapping(value = "/admin/insertMovie.do", method = RequestMethod.POST)
	public ModelAndView insertMovie(@ModelAttribute("movieInfo") MovieDTO movieDTO, 
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		movieService.insertMovieAdmin(movieDTO);
		return new ModelAndView("redirect:/admin/listMovie");
	}

	// 영화 정보 수정 Form으로 이동 (관리자 - 영화 조회 - 수정)
	@RequestMapping(value = "/admin/updateMovieForm.do")
	public ModelAndView updateMovieForm(@RequestParam("movie_id") String movie_id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		request.setAttribute("movieDTO", movieService.selectOneMovie(movie_id));
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/admin/movieForm");
		return mav;
	}
	
	// 영화 정보 수정 (관리자 - 영화 조회 - 수정 - 수정하기)
	@RequestMapping(value = "/admin/updateMovie.do")
	public String updateMovie(MovieDTO movieDTO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		movieService.updateMovie(movieDTO);
	    return "redirect:/admin/searchMovie.do?searchType=movie_id&keyword=" + movieDTO.getMovie_id();
	}

	// 영화 삭제 (관리자 - 영화 조회 - 삭제)
	@RequestMapping(value = "/admin/deleteMovie.do")
	public ModelAndView deleteMovie(@RequestParam("movie_id") String movie_id, 
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		movieService.deleteMovie(movie_id);
		String originalUrl = request.getHeader("referer");
		return new ModelAndView("redirect:" + originalUrl);
	}
	
	// 상세정보 페이지로 이동 (movie_id)
	@RequestMapping(value = "/movie/movieInfoByID.do")
	public ModelAndView goMovieInfoByID(@RequestParam("movie_id") String movie_id, 
			HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		MovieDTO dto = movieService.selectOneMovie(movie_id);
		String posterPath="http://image.tmdb.org/t/p/w300"+dto.getMoviePosterPath();
		dto.setMoviePosterPath(posterPath);
		ModelAndView mav = new ModelAndView("/movie/movieInfo");
		model.addAttribute("dto", dto); //모델에 담는거 테스트
		return mav;
	}
	
	// 상세정보 페이지로 이동(movieCd)
	@RequestMapping(value = "/movie/movieInfo")
	public ModelAndView goMovieInfoByCD(@RequestParam("movieCd") String movieCd,
			HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		System.out.println("movieInfo 메서드 파라미터 movieCd : "+movieCd);
		MovieDTO dto = movieService.selectOneMovieByCd(movieCd);
		String posterPath="http://image.tmdb.org/t/p/w300"+dto.getMoviePosterPath();
		if(posterPath.equals("")){
			posterPath = "/popcornpedias/resources/images/movie/ready300.png";
		}
		dto.setMoviePosterPath(posterPath);
		ModelAndView mav = new ModelAndView("/movie/movieInfo");
		model.addAttribute("dto", dto); //모델에 담는거 테스트
		return mav;
	}

	// 영화 검색 페이지로 이동하기 (kobis 검색용)
	@RequestMapping(value = "/admin/search")
	public ModelAndView goSearchForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		return new ModelAndView("/admin/kobisSearchMovie");
	}
	
	// 보고싶은영화 추가 및 삭제
	@RequestMapping(value="/movie/wishMovie")
	public void wishMovie(int movie_id, String member_id, HttpServletResponse response) throws Exception {
		// System.out.println("wishMovie 매핑확인");
		Map<String, Object> wishParams = new HashMap();
		wishParams.put("movie_id", movie_id);
		wishParams.put("member_id", member_id);	
		
		int wishCheck = movieService.wishCheck(wishParams); // 좋아요 상태 체크 
		if(wishCheck ==0) {  								// likeCheck 0 이면 좋아요 안누른 상태 
			movieService.addWish(wishParams);   			// 좋아요 추가
		}
		else if(wishCheck ==1) {    						// likeCheck 1 이면 좋아요 누른 상태
			movieService.cancelWish(wishParams);			// 좋아요 취소
		}	
		PrintWriter pw = response.getWriter();
		pw.print(wishCheck);
	}
	
	// 보고싶은영화 멤버별로 체크 (로그아웃 상태면 0 리턴)
	@RequestMapping(value="/movie/checkWishMovie")
	public void checkWishMovie(int movie_id, String member_id, HttpServletResponse response) throws Exception {
		Map<String, Object> wishParams = new HashMap();
		wishParams.put("movie_id", movie_id);
		wishParams.put("member_id", member_id);
		
		int wishCheck = movieService.wishCheck(wishParams); // 좋아요 상태 체크 
		PrintWriter pw = response.getWriter();
		if(member_id.equals(null)  || member_id.equals("")) {
			wishCheck = 0;
		}
		pw.print(wishCheck);
	}
	
	// 보고싶은영화 페이지로 가기
	@RequestMapping(value="/movie/myWishMovie.do")
	public ModelAndView goMyWishMovie(HttpServletRequest request, HttpServletResponse Response, HttpSession session) throws Exception {
		String member_id;
		if(request.getParameter("member_id") != null) {
			member_id = request.getParameter("member_id");
		}
		else {
			MemberDTO userDTO = (MemberDTO) session.getAttribute("user");
			member_id = userDTO.getMember_id();
		}
		
		List movieList = movieService.getWishMovie(member_id);	
		ModelAndView mav = new ModelAndView("/member/myWishMovie");
		mav.addObject("starRatingList", movieList);
		return mav;
	}
	

	
	/*
	 * 
	 * 검색 기능
	 * 
	 * */

	
	// 영화 검색하기 (관리자 - 영화 조회 - 검색)
	@RequestMapping(value = "/admin/searchMovie.do")
	public ModelAndView adminSearchMovie(@RequestParam HashMap<String, Object> searchMap, 
			@RequestParam(defaultValue = "1") int num, 
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 페이징 처리
		int postNum = 10;
		int total = movieService.countSearchMovieByKeyword(searchMap);
		makePagingDTO page = new makePagingDTO(num, total, postNum);
		searchMap.put("displayPost",page.getDisplayPost());
		searchMap.put("postNum", page.getPostNum());
		request.setCharacterEncoding("utf-8");	
		
		//비지니스로 넘기기
		List movieList = movieService.adminSearchMovie(searchMap);
		//받아온 데이터 뷰 페이지로 보내기
		ModelAndView mav = new ModelAndView();
		mav.addObject("movieList",movieList);
		mav.addObject("page", page);
		mav.addObject("total", total);
		mav.addObject("selectPageNum", num);
		mav.addObject("searchMap",searchMap);
		mav.setViewName("admin/listMovie");
		return mav;
	}
	
	// (사용자) 팝콘 피디아 영화 검색 - 키워드별, 연도별
	@RequestMapping(value = "/movie/movieSearch")
	public ModelAndView userMovieSearch(@RequestParam HashMap<String, Object> searchMap, 
			@RequestParam(defaultValue = "1") int num, 
			@RequestParam("keyword") String keyword, 
			HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		request.setCharacterEncoding("utf-8");	
		ModelAndView mav = new ModelAndView("/movie/searchResult");
		
		// 페이징 처리 초기값 설정
		int postNum = 40;		
		List<MovieDTO> movieList;
		int total=0;
		makePagingDTO page;
		
		// 키워드별
		if (isGenreKeyword(keyword)) 
		{
			page = new makePagingDTO(num, movieService.getMovieGenreTotal(keyword), postNum);
		    total = movieService.getMovieGenreTotal(keyword);
			searchMap.put("displayPost",page.getDisplayPost());
			searchMap.put("postNum", page.getPostNum());
		    movieList = movieService.getMovieGenre(searchMap);   
		} 
		// 연도별
		else if(isYearKeyword(keyword)) {
			page = new makePagingDTO(num, movieService.getMovieYearTotal(keyword), postNum);
		    total = movieService.getMovieYearTotal(keyword);
			searchMap.put("displayPost",page.getDisplayPost());
			searchMap.put("postNum", page.getPostNum());
		    movieList = movieService.getMovieByYear(searchMap);		
		}
		else{
			page = new makePagingDTO(num, movieService.countUserSearchMovie(searchMap), postNum);
			total = movieService.countUserSearchMovie(searchMap);
			searchMap.put("displayPost",page.getDisplayPost());
			searchMap.put("postNum", page.getPostNum());
			movieList = movieService.searchMovie(searchMap);
		}
		System.out.println("가져온 영화 개수 total: " + total);		
		mav.addObject("page", page);
		mav.addObject("result", movieList);	
		mav.addObject("total", total);
		mav.addObject("selectPageNum", num);
		mav.addObject("searchMap",searchMap);

		return mav;
		
	}
	// 키워드 매칭
	private boolean isGenreKeyword(String keyword) {
	    return Arrays.asList("판타지", "액션", "공포", "드라마", "멜로", "미스터리", "스릴러", "코미디", "애니메이션", "SF", "다큐멘터리").contains(keyword);
	}
	// 연도 매칭
	private boolean isYearKeyword(String keyword) {
	    int startYear = 1971;
	    int endYear = 2023;
	    try {
	        int year = Integer.parseInt(keyword);
	        return year >= startYear && year <= endYear;
	    } catch (NumberFormatException e) {
	        return false;
	    }
	}



}
