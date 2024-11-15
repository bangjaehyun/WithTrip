package kr.or.iei.spot.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Spot {
	private String spotNo;
	private String kakaoMapId;	//카카오 맵 아이디;
	private String spotName;
	private int spotType;
	private String spotAddr;
	private String spotLat;
	private String spotLng;
	private String spotPhone;
}
