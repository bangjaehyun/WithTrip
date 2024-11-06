package kr.or.iei.common.model.vo;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data

public class PageData {
	private ArrayList<?> list;//제네릭 변수. 페이지 개시글 arraylist를 담을 수 있음
	private String pageNavi;
}
