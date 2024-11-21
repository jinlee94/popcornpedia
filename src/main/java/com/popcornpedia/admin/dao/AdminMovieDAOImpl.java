package com.popcornpedia.admin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

import com.popcornpedia.board.dto.BoardDTO;
import com.popcornpedia.member.dto.MemberDTO;
import com.popcornpedia.movie.dto.MovieDTO;

@Repository("AdminMovieDAO")
public class AdminMovieDAOImpl implements AdminMovieDAO{

	@Autowired
	private SqlSession sqlsession;
	
	// API로 가져온 정보가 DB에 있는지 확인하고 추가 또는 수정
	@Override
	public int insertMovie(MovieDTO movieDTO) throws Exception {
		System.out.println("dao의 check & insertMovie() 도착 "+movieDTO.getMovieCd());
		Integer movie_id = getMovieIDbyNmYear(movieDTO); // 메서드로 movie_id 가져오기
		System.out.println("-------movie_id 가지고 옴 : " + movie_id);
		int result = 0;
		if(movie_id.intValue()==0 ) //movie_id가 없는경우 (DB에 없는경우)
		{
			System.out.println("if - movie_id 없고 DB에 추가");
			result = sqlsession.insert("mapper.movie.insertMovie", movieDTO); //insert해줌
		}
		else if(movie_id != null) {
			System.out.println("else if - update");
			movieDTO.setMovie_id(movie_id); //movie_id를 찾아온 경우 set
			result = sqlsession.update("mapper.movie.updateMovieParts", movieDTO); //컬럼 내용 update
		}
		return result;
	}
	
	private int getMovieIDbyNmYear(MovieDTO movieDTO) throws Exception{
		Integer movie_id = sqlsession.selectOne("mapper.movie.selectMovieIDByNmYear", movieDTO);
			if (movie_id == null || movie_id.intValue() == 0) { // movie_id가 null이거나 0일 경우 처리
		        sqlsession.insert("mapper.movie.insertMovie", movieDTO);
		        movie_id = movieDTO.getMovie_id();
		    }
		return movie_id;
	}
	
	public int insertMovieAdmin(MovieDTO movieDTO) throws Exception {
		int result = sqlsession.insert("mapper.movie.insertMovie", movieDTO);
		return result;
	}
	
	@Override
	public List selectAllMovie() throws Exception {
		List movielist = sqlsession.selectList("mapper.movie.selectAllmovie");
		return movielist;
	}
	
	@Override
	public MovieDTO selectOneMovie(String movie_id) throws Exception {
		MovieDTO movieDTO = sqlsession.selectOne("mapper.movie.selectOneMovie", movie_id);
		return movieDTO;
	}

	@Override
	public MovieDTO selectOneMovieByCd(String movieCd) throws Exception {
		return sqlsession.selectOne("mapper.movie.selectOneMovieByCd", movieCd);
	}

	@Override
	public void deleteMovie(String movie_id) throws Exception {
		int result = sqlsession.delete("mapper.movie.deleteMovie", movie_id);
		System.out.println("삭제 : " + result);
	}

	@Override
	public void updateMovie(MovieDTO movieDTO) throws Exception {
		int result = sqlsession.insert("mapper.movie.updateMovie", movieDTO);
		System.out.println("쿼리 결과 : " + result);
	}

	public List adminSearchMovie(HashMap<String, Object> searchMap) throws Exception {
		List movielist=  sqlsession.selectList("mapper.movie.selectAdminSearchMovie", searchMap);
		return movielist;
	}
	
	//전체 영화 개수
	@Override
	public int countMovie() {
		int total = sqlsession.selectOne("mapper.movie.countMovie");
		return total;
	}
	
	@Override
	public List<MovieDTO> selectPageMovie(int displayPost, int postNum) throws Exception {
		HashMap data = new HashMap();		
		data.put("displayPost", displayPost);
		data.put("postNum", postNum);	
		return sqlsession.selectList("mapper.movie.selectPageArticle", data);
	}
	
	//영화 검색시 개수 
	@Override
	public int countSearchMovieByKeyword(HashMap<String, Object> searchMap) {
		return sqlsession.selectOne("mapper.movie.countSearchMovieByKeyword", searchMap);
	}
	
	//DB검색 (영화제목&감독이름&배우이름)
	@Override
	public List searchMovie(HashMap<String, Object> searchMap) throws Exception {
		List movielist = sqlsession.selectList("mapper.movie.userSearchMovie", searchMap);
		return movielist;
	}
	@Override
	public int countUserSearchMovie(HashMap<String, Object> searchMap)  throws Exception {
		return sqlsession.selectOne("mapper.movie.countUserSearchMovie", searchMap);
	}


	//장르별 영화 가져오기
	@Override
	public List getMovieGenre(HashMap<String, Object> searchMap) throws Exception {
		List movieList = sqlsession.selectList("mapper.movie.selectMovieGenre", searchMap);
		return movieList;
	}
	@Override
	public int getMovieGenreTotal(String keyword) throws Exception {
		int total = sqlsession.selectOne("mapper.movie.getGenreTotal", keyword);
		return total;
	}

	// Kobis movie코드로 우리 내부 DB movie_id 가져오기 
	@Override
	public int getMovieID(String movieCd) throws Exception{
		Integer movie_id = sqlsession.selectOne("mapper.movie.getMovieidBymovieCd", movieCd);
		if(movie_id == null || movie_id.intValue()==0 ) {movie_id = 0;}	
		return movie_id;
	}
	
	
	
	/*--------보고싶은영화 (마이페이지 매핑은 member패키지-UserController에 있음-----------*/
	@Override
	public int wishCheck(Map<String, Object> wishParams) {
		int result = sqlsession.selectOne("mapper.movie.wishCheck", wishParams);
		return result;
	}

	@Override
	public int addWish(Map<String, Object> wishParams) {
		return sqlsession.insert("mapper.movie.insertWish", wishParams);
	}

	@Override
	public int cancelWish(Map<String, Object> wishParams) {
		return sqlsession.delete("mapper.movie.deleteWish", wishParams);
	}

	public List getWishMovie(String member_id) throws Exception {
		return sqlsession.selectList("mapper.movie.selectWishMovie",member_id);
	}

	/*--------------------------------------연도별 영화----------------------------------------*/
	public List getMovieByYear(HashMap<String, Object> searchMap) {
		List movieList = sqlsession.selectList("mapper.movie.selectMovieByYear", searchMap);
		return movieList;
	}

	@Override
	public int getMovieByYearTotal(String movieYear) {
		int total = sqlsession.selectOne("mapper.movie.selectMovieByYearTotal", movieYear);
		return total;
	}
	
	/*---------------------------------------- 컬렉션---------------------------------------*/
	public List getCollection_harry() throws Exception{
		List collectionList = sqlsession.selectList("mapper.movie.collection_harrypotter");
		return collectionList;
	}
	
	public List getCollection_marvel() throws Exception{
		List collectionList = sqlsession.selectList("mapper.movie.collection_marvel");
		return collectionList;
	}
	
	public List getCollection_krFantagy() throws Exception{
		List collectionList = sqlsession.selectList("mapper.movie.collection_krFantagy");
		return collectionList;
	}
	
	public List getCollection_tenMillion() throws Exception{
		List collectionList = sqlsession.selectList("mapper.movie.collection_tenMillion");
		return collectionList;
	}


}
