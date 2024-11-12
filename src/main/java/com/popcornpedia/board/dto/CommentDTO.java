package com.popcornpedia.board.dto;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.annotation.JsonFormat;

@Component("commentDTO")
public class CommentDTO {
	private int commentNO; // 댓글번호
	private int articleNO; // 게시글번호
	private String member_id; // 회원 ID
	private String cmtContent; // 댓글내용
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
	private Timestamp cmtWriteDate; // 댓글작성일자
	private String nickname; // 닉네임
	private String memberImgName; // 작성자 프로필사진
	
	public int getCommentNO() {
		return commentNO;
	}
	public void setCommentNO(int commentNO) {
		this.commentNO = commentNO;
	}
	public int getArticleNO() {
		return articleNO;
	}
	public void setArticleNO(int articleNO) {
		this.articleNO = articleNO;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getCmtContent() {
		return cmtContent;
	}
	public void setCmtContent(String cmtContent) {
		this.cmtContent = cmtContent;
	}
	public Timestamp getCmtWriteDate() {
		return cmtWriteDate;
	}
	public void setCmtWriteDate(Timestamp cmtWriteDate) {
		this.cmtWriteDate = cmtWriteDate;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getMemberImgName() {
		return memberImgName;
	}
	public void setMemberImgName(String memberImgName) {
		this.memberImgName = memberImgName;
	}
}
