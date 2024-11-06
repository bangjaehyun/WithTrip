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
public class UserKakao extends User{
	private String userNo;
	private String userName;
	private String userId;
	private String userEmail;
	private String userPhone;
	private Date enrollDate;
}
