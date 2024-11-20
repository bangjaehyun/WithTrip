package kr.or.iei.festival.model.vo;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class FestivalSubInfoTema {
	//공통 정보
		private String temaId; //상세 정보를 가져오기 위한 아디
		private String temaType;//상세 정보를 가져오기 위한 타입
		private String temaTitle; //제목
		private String temaContent; //개요
		private String temaImg; //이미지
		private String temaLat; //경도
		private String temaLng; //위도
		private String temaTotalCount; //총 개수
		
		//소개 정보
		private String tematotalDistance; //총 거리
		private String temaTime; // 소요시간
		
		//코스정보
		private ArrayList<FestivalCos> cosList;
}
