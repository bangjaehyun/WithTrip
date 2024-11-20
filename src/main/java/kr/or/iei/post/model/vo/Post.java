package kr.or.iei.post.model.vo;

import java.util.ArrayList;

import kr.or.iei.spot.model.vo.Spot;
import kr.or.iei.user.model.vo.User;
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
	private String tripDate;			//여행다녀온일자
	
	private String postTypeNm;			//게시글 종류 이름 : 공지사항, 여행정보, FAQ, Q&A, 사이트 이용안내
	private String postTypeId;
	
	private User user;
	
	private String userType;
	private String userNickName;
	
	private int readCount;				//조회수
	private ArrayList<PostFile> fileList;			//게시글 파일목록
	private ArrayList<PostComment> commentList;		//게시글 댓글 목록
	private ArrayList<Spot> spotList; //게시글 장소 목록
	private String tagList; //선택한 태그리스트 json을 string으로저장
	private int likeCount;			//좋아요 횟수
}
