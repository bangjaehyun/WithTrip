package kr.or.iei.post.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data

public class UserLikeComment {
	private String userNo; //유저 정보
	private String commentId; //댓글 아이디
	private int userLike; //댓글 좋아요 여부
}
