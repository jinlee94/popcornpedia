package com.popcornpedia.movie.dto;

public class StarRatingDTO {
	public double getRating() {
		return rating;
	}
	public void setRating(double rating) {
		this.rating = rating;
	}
	public int getDetailOST() {
		return detailOST;
	}
	public void setDetailOST(int detailOST) {
		this.detailOST = detailOST;
	}
	public int getDetailDirection() {
		return detailDirection;
	}
	public void setDetailDirection(int detailDirection) {
		this.detailDirection = detailDirection;
	}
	public int getDetailVisual() {
		return detailVisual;
	}
	public void setDetailVisual(int detailVisual) {
		this.detailVisual = detailVisual;
	}
	public int getDetailActing() {
		return detailActing;
	}
	public void setDetailActing(int detailActing) {
		this.detailActing = detailActing;
	}
	public int getDetailStory() {
		return detailStory;
	}
	public void setDetailStory(int detailStory) {
		this.detailStory = detailStory;
	}
	public int getRatingNO() {
		return ratingNO;
	}
	public void setRatingNO(int ratingNO) {
		this.ratingNO = ratingNO;
	}
	public int getMovie_id() {
		return movie_id;
	}
	public void setMovie_id(int movie_id) {
		this.movie_id = movie_id;
	}
	
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	private int ratingNO;
	private int movie_id;
	private double rating;
	private String member_id;
	private String nickname;
	private int detailOST;
	private int detailDirection;
	private int detailVisual;
	private int detailActing;
	private int detailStory;
	
	
	

}
