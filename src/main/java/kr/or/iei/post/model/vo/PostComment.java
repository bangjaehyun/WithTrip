package kr.or.iei.post.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data

public class PostComment {
	private String commentRef;		//게시글 번호
	private String commentDate;		//작성일
	
	private String commentId;		//댓글 분류번호
	private String commentVal;		//댓글 내용
	private String commentLike;		//좋아요
	private String commentDisLike;	//싫어요
	private String userNo;			//회원번호
	
	//private String commentNo;		//댓글 번호
	//private String commentContent;	//댓글 내용
	//private String commentWriter;	//댓글 작성자
	//private String userId;			//회원아이디
	//private int userType;			//회원 분류 -> 1 관리자 2 사용자 3 파트너
	private int postTypeCd;			//게시글 분류번호 -> 1.공지사항 2.여행기록 3.FAQ 4.Q&A 5.사이트 이용안내
}
