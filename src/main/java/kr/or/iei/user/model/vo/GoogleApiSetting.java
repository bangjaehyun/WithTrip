package kr.or.iei.user.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
public class GoogleApiSetting {
	public static final String googleClientId = "";
	public static final String googleRedirectUrl = "http://localhost/user/loginFrm";
	public static final String googleLoginUrl = "https://accounts.google.com";
	public static final String googleClientSecret = "";
	public static final String googleProjectId = "withtrip";
	public static final String googleAuthId = "https://accounts.google.com/o/oauth2/auth";
/*	
	로그인 창 호출 Url
	googleLoginUrl + "/o/oauth2/v2/auth?client_id=" + googleClientId + "&redirect_uri=" + googleRedirectUrl
    + "&response_type=code&scope=email%20profile%20openid&access_type=offline";
*/    
}
