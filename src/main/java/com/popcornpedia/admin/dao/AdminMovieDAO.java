package com.popcornpedia.admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import com.popcornpedia.member.dto.MemberDTO;
import com.popcornpedia.movie.dto.MovieDTO;

public interface AdminMovieDAO {
	public int insertMovie(MovieDTO movieDTO) throws Exception;
	public int insertMovieAdmin(MovieDTO movieDTO) throws Exception;
	public List selectAllMovie() throws Exception;
	public void updateMovie(MovieDTO movieDTO) throws Exception;
	public MovieDTO selectOneMovie(String movie_id) throws Exception;
	public List adminSearchMovie(HashMap<String, Object> searchMap) throws Exception;
	public List searchMovie(HashMap<String, Object> searchMap) throws Exception;
	public int countUserSearchMovie(HashMap<String, Object> searchMap)  throws Exception;
	public void deleteMovie(String movie_id) throws Exception;
	public int getMovieID(String movieCd) throws Exception;
	public List getCollection_harry() throws Exception;
	public List getCollection_marvel() throws Exception;
	public List getCollection_krFantagy() throws Exception;
	public List getCollection_tenMillion() throws Exception;
	public List getMovieGenre(HashMap<String, Object> searchMap)  throws Exception;
	public int getMovieGenreTotal(String keyword) throws Exception;
	public List getMovieByYear(HashMap<String, Object> searchMap);
	public int getMovieByYearTotal(String movieYear);
	public int countMovie();
	public List<MovieDTO> selectPageMovie(int displayPost, int postNum) throws Exception;
	public int countSearchMovieByKeyword(HashMap<String, Object> searchMap);
	
	//영화 보고싶어요 체크 여부
	public int wishCheck(Map<String, Object> wishParams);
	public int addWish(Map<String, Object> wishParams);
	public int cancelWish(Map<String, Object> wishParams);
	
	public List getWishMovie(String member_id) throws Exception;

}
