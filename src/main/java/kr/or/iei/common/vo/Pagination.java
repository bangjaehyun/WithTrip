package kr.or.iei.common.vo;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data

public class Pagination {
	//엄..준식꺼임 건들지 마3
	private String mapAddr;
	private String pstTypeId;
	private String pstTypeName;
	private int reqPage;
	private int pageSize;
	private ArrayList<?> list;
	
	private int totCnt;
	private int pOrC;
}
