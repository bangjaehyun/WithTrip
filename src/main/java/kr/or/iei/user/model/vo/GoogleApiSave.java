package kr.or.iei.user.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class GoogleApiSave {
	private String accessToken;
	private String refreshToken;
	private String token_type;
}
