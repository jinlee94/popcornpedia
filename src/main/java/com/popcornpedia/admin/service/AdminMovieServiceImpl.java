package com.popcornpedia.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.popcornpedia.admin.dao.AdminMovieDAO;
import com.popcornpedia.movie.dto.MovieDTO;

@Service("AdminMovieService")
public class AdminMovieServiceImpl implements AdminMovieService{

	@Autowired
	private AdminMovieDAO movieDAO;
	
	@Override
	public int insertMovie(MovieDTO movieDTO) throws Exception {
		int result = movieDAO.insertMovie(movieDTO);
		return result;
	}

	@Override
	public int insertMovieAdmin(MovieDTO movieDTO) throws Exception {
		int result = movieDAO.insertMovieAdmin(movieDTO);
		return result;
	}

	@Override
	public List selectAllMovie() throws Exception {
		List movielist = movieDAO.selectAllMovie();
		return movielist;
	}

	@Override
	public void updateMovie(MovieDTO movieDTO) throws Exception {
		movieDAO.updateMovie(movieDTO);
	}

	@Override
	public MovieDTO selectOneMovie(String movie_id) throws Exception {
		MovieDTO movieDTO = movieDAO.selectOneMovie(movie_id);
		return movieDTO;
	}

	@Override
	public MovieDTO selectOneMovieByCd(String movieCd) throws Exception {
		return movieDAO.selectOneMovieByCd(movieCd);
	}

	public List adminSearchMovie(HashMap<String, Object> searchMap) throws Exception{
		return movieDAO.adminSearchMovie(searchMap);
	}

	@Override
	public List getMovieGenre(HashMap<String, Object> searchMap) throws Exception {
		List movieList = movieDAO.getMovieGenre(searchMap);
		return movieList;
	}
	
	public int getMovieGenreTotal(String keyword) throws Exception{
		int total = movieDAO.getMovieGenreTotal(keyword);
		return total;
	}

	@Override
	public void deleteMovie(String movie_id) throws Exception {
		movieDAO.deleteMovie(movie_id);
		
	}

	@Override
	public int getMovieID(String movieCd) throws Exception {
		int movie_id = movieDAO.getMovieID(movieCd);
		return movie_id;
	}
	
	@Override
	public Map<String, List> getCollection() throws Exception{
		Map<String, List> collection = new HashMap<String, List>();
		List harryList = movieDAO.getCollection_harry();
		collection.put("harryList", harryList);
		List marvelList = movieDAO.getCollection_marvel();
		collection.put("marvelList", marvelList);
		List krFantagyList = movieDAO.getCollection_krFantagy();
		collection.put("krFantagyList", krFantagyList);
		List tenMillionList = movieDAO.getCollection_tenMillion();
		collection.put("tenMillionList", tenMillionList);
		return collection;
	}

	@Override
	public List getMovieByYear(HashMap<String, Object> searchMap) {
		List movieList = movieDAO.getMovieByYear(searchMap);
		return movieList;
	}

	@Override
	public int getMovieYearTotal(String movieYear) {
		int total = movieDAO.getMovieByYearTotal(movieYear);
		return total;
	}

	@Override
	public int countMovie() {
		int total = movieDAO.countMovie();
		return total;
	}

	@Override
	public List<MovieDTO> selectPageMovie(int displayPost, int postNum) throws Exception{
		List movieList = movieDAO.selectPageMovie(displayPost, postNum);
		return movieList;
	}

	@Override
	public int countSearchMovieByKeyword(HashMap<String, Object> searchMap) {
		return movieDAO.countSearchMovieByKeyword(searchMap);
	}
	
	
	@Override
	public List searchMovie(HashMap<String, Object> searchMap) throws Exception {
		List movielist = movieDAO.searchMovie(searchMap);
		return movielist;
	}
	
	public int countUserSearchMovie(HashMap<String, Object> searchMap)  throws Exception{
		return movieDAO.countUserSearchMovie(searchMap);
	}
	 
	
	//wish

	
	@Override
	public int wishCheck(Map<String, Object> wishParams) {
		return movieDAO.wishCheck(wishParams);
	}

	@Override
	public int addWish(Map<String, Object> wishParams) {
		return movieDAO.addWish(wishParams);
		
	}

	@Override
	public int cancelWish(Map<String, Object> wishParams) {
		return movieDAO.cancelWish(wishParams);
		
	}

	@Override
	public List getWishMovie(String member_id) throws Exception {
		return movieDAO.getWishMovie(member_id);
	}
	
	
	
}
