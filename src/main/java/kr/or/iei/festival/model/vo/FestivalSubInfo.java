package kr.or.iei.festival.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class FestivalSubInfo {
	private String festivalTitle;
	private String festivalAddr;
	private String festivalStartDay;
	private String festivalEndDay;
	private String festivalLat;
	private String festivalLng;
	private String festivalTel;
	private String festivalContent;
}
