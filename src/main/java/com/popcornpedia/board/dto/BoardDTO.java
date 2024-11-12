package com.popcornpedia.board.dto;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

@Component("boardDTO")
public class BoardDTO {
	private int articleNO; // 글번호
	private String title; // 글제목
	private Timestamp writeDate; // 작성일자
	private String nickname; // 닉네임
	private String member_id; // 회원 ID
	private int hit; // 조회수
	private String content; // 글내용
	private String imgFileName; // 첨부파일명
	private String oldFileName; // 수정전 파일명
	private int likeNO; // 추천수
	private int comments; //댓글수
	private String memberImgName; // 작성자 프로필사진
	
	public int getArticleNO() {
		return articleNO;
	}
	public void setArticleNO(int articleNO) {
		this.articleNO = articleNO;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Timestamp getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Timestamp writeDate) {
		this.writeDate = writeDate;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImgFileName() {
		return imgFileName;
	}
	public void setImgFileName(String imgFileName) {
		this.imgFileName = imgFileName;
	}
	public String getOldFileName() {
		return oldFileName;
	}
	public void setOldFileName(String oldFileName) {
		this.oldFileName = oldFileName;
	}
	public int getLikeNO() {
		return likeNO;
	}
	public void setLikeNO(int likeNO) {
		this.likeNO = likeNO;
	}
	public int getComments() {
		return comments;
	}
	public void setComments(int comments) {
		this.comments = comments;
	}
	public String getMemberImgName() {
		return memberImgName;
	}
	public void setMemberImgName(String memberImgName) {
		this.memberImgName = memberImgName;
	}
}
