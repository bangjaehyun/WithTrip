package kr.or.iei.user.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
public class GoogleApiSetting {
	public static final String googleClientId = "383628200526-bmlq8g7hto7kv1bsvj9ffnnbe9e5oji0.apps.googleusercontent.com";
	public static final String googleRedirectUrl = "http://localhost:80";
	public static final String googleLoginUrl = "https://accounts.google.com";
	public static final String googleClientSecret = "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";
	public static final String googleProjectId = "withtrip";
	public static final String googleAuthId = "https://accounts.google.com/o/oauth2/auth";
/*	
	로그인 창 호출 Url
	googleLoginUrl + "/o/oauth2/v2/auth?client_id=" + googleClientId + "&redirect_uri=" + googleRedirectUrl
    + "&response_type=code&scope=email%20profile%20openid&access_type=offline";
*/    
}
