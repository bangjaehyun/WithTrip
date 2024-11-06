package kr.or.iei.comment.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data

public class Comment {
	private String commentId;
	private String userNo;
	private String commentVal;
	private String commentDate;
	private int commentLike;
	private int commentDislike;
	
	private int userType;
	private String userNickname;
	
}
