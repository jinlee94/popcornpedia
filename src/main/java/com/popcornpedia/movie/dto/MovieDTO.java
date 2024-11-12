package com.popcornpedia.movie.dto;

public class MovieDTO {
	
	private int movie_id; //우리가 부여하는 번호
	private String movieNm; //국문명
	private String movieNm_EN; //영문명
	private String movieYear; //개봉일
	private String movieGenre; //영화 장르
	private String movieNation; //제작 국가
	private String movieDirector; //감독
	private String movieActor; //배우
	private String movieGrade; //관람등급
	private String showTm; //상영시간
	private String moviePosterPath; //포스터 url (TMDB에서 제공하는 url)
	private String movieBackdropPath; //배경화면 url
	private String movieOverview; //줄거리
	private String movieCd; //영진위 영화 코드
	
	//검색용
	private String searchType;
	private String keyword;
	private int index;
	
	
	
	
	public MovieDTO() {
		
	}

	public MovieDTO(String movieNm, String movieNm_EN, String movieYear, String movieGenre, String movieNation,
			String movieDirector, String movieActor, String movieGrade, String showTm, String moviePosterPath,
			String movieBackdropPath, String movieOverview, String movieCd) {
		super();
		this.movieNm = movieNm;
		this.movieNm_EN = movieNm_EN;
		this.movieYear = movieYear;
		this.movieGenre = movieGenre;
		this.movieNation = movieNation;
		this.movieDirector = movieDirector;
		this.movieActor = movieActor;
		this.movieGrade = movieGrade;
		this.showTm = showTm;
		this.moviePosterPath = moviePosterPath;
		this.movieBackdropPath = movieBackdropPath;
		this.movieOverview = movieOverview;
		this.movieCd = movieCd;
	}
	
	
	public MovieDTO(String movieNm, String movieNm_EN, String movieYear, String movieGenre, String movieNation,
			String movieDirector, String movieActor, String movieGrade, String showTm, String movieCd) {
		super();
		this.movieNm = movieNm;
		this.movieNm_EN = movieNm_EN;
		this.movieYear = movieYear;
		this.movieGenre = movieGenre;
		this.movieNation = movieNation;
		this.movieDirector = movieDirector;
		this.movieActor = movieActor;
		this.movieGrade = movieGrade;
		this.showTm = showTm;
		this.movieCd = movieCd;
	}

	
	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public String getMovieYear() {
		return movieYear;
	}
	public void setMovieYear(String movieYear) {
		this.movieYear = movieYear;
	}
	public String getMovieCd() {
		return movieCd;
	}
	public void setMovieCd(String movieCd) {
		this.movieCd = movieCd;
	}
	public String getMovieBackdropPath() {
		return movieBackdropPath;
	}
	public void setMovieBackdropPath(String movieBackdropPath) {
		this.movieBackdropPath = movieBackdropPath;
	}
	public String getMovieOverview() {
		return movieOverview;
	}
	public void setMovieOverview(String movieOverview) {
		this.movieOverview = movieOverview;
	}
	public String getMovieGenre() {
		return movieGenre;
	}
	public void setMovieGenre(String movieGenre) {
		this.movieGenre = movieGenre;
	}
	public String getMoviePosterPath() {
		return moviePosterPath;
	}
	public void setMoviePosterPath(String moviePosterPath) {
		this.moviePosterPath = moviePosterPath;
	}
	public String getShowTm() {
		return showTm;
	}
	public void setShowTm(String showTm) {
		this.showTm = showTm;
	}
	public String getMovieNm_EN() {
		return movieNm_EN;
	}
	public void setMovieNm_EN(String movieNm_EN) {
		this.movieNm_EN = movieNm_EN;
	}
	public int getMovie_id() {
		return movie_id;
	}
	public void setMovie_id(int movie_id) {
		this.movie_id = movie_id;
	}
	
	public String getMovieNm() {
		return movieNm;
	}
	public void setMovieNm(String movieNm) {
		this.movieNm = movieNm;
	}

	public String getMovieNation() {
		return movieNation;
	}
	public void setMovieNation(String movieNation) {
		this.movieNation = movieNation;
	}
	public String getMovieDirector() {
		return movieDirector;
	}
	public void setMovieDirector(String movieDirector) {
		this.movieDirector = movieDirector;
	}
	public String getMovieActor() {
		return movieActor;
	}
	public void setMovieActor(String movieActor) {
		this.movieActor = movieActor;
	}
	public String getMovieGrade() {
		return movieGrade;
	}
	public void setMovieGrade(String movieGrade) {
		this.movieGrade = movieGrade;
	}

	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	
	
}
