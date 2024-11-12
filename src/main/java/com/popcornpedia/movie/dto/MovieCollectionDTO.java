package com.popcornpedia.movie.dto;

public class MovieCollectionDTO {
	public int getCollectionNO() {
		return collectionNO;
	}
	public void setCollectionNO(int collectionNO) {
		this.collectionNO = collectionNO;
	}
	public int getMovie_id() {
		return movie_id;
	}
	public void setMovie_id(int movie_id) {
		this.movie_id = movie_id;
	}
	public String getCollectionName() {
		return collectionName;
	}
	public void setCollectionName(String collectionName) {
		this.collectionName = collectionName;
	}
	private int collectionNO;
	private int movie_id;
	private String collectionName;
	
	
	
}
