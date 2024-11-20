package kr.or.iei.user.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper = false)
@Data
public class User extends UserType{
	private String userNo;
	//private int userType;
	private String userNickname;
	private String userId;
/*	
	private String userName;
	private String userPw;
	private String userEmail;
	private String userPhone;
	private Date enrollDate;
*/	
}
