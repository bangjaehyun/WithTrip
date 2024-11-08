package kr.or.iei.user.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class User {
	private String userNo;
	private int userType;
	private String userNickname;
	private String userName;
	private String userId;
	private String userPw;
	private String userEmail;
	private String userPhone;
	private Date enrollDate;
	
}
