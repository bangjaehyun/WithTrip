package kr.or.iei.post.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data

public class Post {
	private String postNo;				//게시글 번호
	private String postTypeCd;			//게시글 종류 코드
	private String postTitle;			//게시글 제목
	private String postContent;			//게시글 내용
	private String userNo;				//작성자 == 회원번호
	private String postDate;			//작성일
	
	private String postTypeNm;			//게시글 종류 명칭
	private String postTypeId;
}
