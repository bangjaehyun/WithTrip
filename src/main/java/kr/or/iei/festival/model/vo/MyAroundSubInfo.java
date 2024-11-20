package kr.or.iei.festival.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data

public class MyAroundSubInfo {
	//소개 정보
	private String myAroundTitle; //제목
	private String myAroundHomePage; //홈페이지 주소
	private String myAroundZipCode; //우편 번호
	private String myAroundLat; //경도
	private String myAroundLng; //위도
	private String myAroundAddr; //주소
	private String myAroundContent; // 개요
	private String myAroundImg; //이미지
	
	
	//소개정보
	
	private String myAroundTel;//문의 및 안내
	private String myAroundCloseDay; // 쉬는날
	private String myAroundTime; //운영시간
	private String myAroundPaking; //주차 정보
}
