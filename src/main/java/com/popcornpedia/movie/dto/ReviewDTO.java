package com.popcornpedia.movie.dto;

import java.sql.Timestamp;


public class ReviewDTO {

	public String getMemberImgName() {
		return memberImgName;
	}
	public void setMemberImgName(String memberImgName) {
		this.memberImgName = memberImgName;
	}
	public int getReviewNO() {
		return reviewNO;
	}
	public void setReviewNO(int reviewNO) {
		this.reviewNO = reviewNO;
	}
	public int getMovie_id() {
		return movie_id;
	}
	public void setMovie_id(int movie_id) {
		this.movie_id = movie_id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	public Timestamp getReviewdate() {
		return reviewdate;
	}
	public void setReviewdate(Timestamp reviewdate) {
		this.reviewdate = reviewdate;
	}
	public int getLikeNO() {
		return likeNO;
	}
	public void setLikeNO(int likeNO) {
		this.likeNO = likeNO;
	}
	
	public int reviewNO;
	public int movie_id;
	public String content;
	public String member_id;
	public String nickname;
	public Timestamp reviewdate;
	public int likeNO;
	private String memberImgName;
	
}
