package kr.or.iei.common.service;

import java.sql.Connection;
import java.util.ArrayList;

import kr.or.iei.common.JDBCTemplate;
import kr.or.iei.common.dao.CommonDao;
import kr.or.iei.common.model.vo.PageData;

public class CommonService {
	CommonDao dao;
	
	public CommonService() {
		dao = new CommonDao();
	}
	//TODO 조금 더 만져봐야 됌.아직 미해결
	public PageData Pagination(String postType, String postTypeNm, int reqPg, int pgSize, ArrayList<?> yourList) {
		Connection conn = JDBCTemplate.getConnection();
		int reqPage=reqPg;  // 현재 페이지, 매개변수로 받아옴
		int pageSize=pgSize;// 한 페이지당 게시글 수, 매개변수로 받아옴 15, 30, 50
/*		**README**
		Service.java내
		ArrayList<vo객체명> list = dao.객체명List(conn, postType); 하여 list받아오고, 
		해당 list를 pagination호출시 매개변수로 넣어줄 것
		int endPg = reqPage * pageSize; // 끝 페이지  
		int startPg = endPg-pageSize+1; // 시작 페이지  
*/	
		int totCnt =dao.selectPostCount(conn, postType);
		int totPage = 0;
		
		if (totCnt % pageSize > 0) {
			totPage = totCnt / pageSize + 1;

		} else {
			totPage = totCnt / pageSize;
		}
		// 페이지 하단에 보여질 페이지 네비게이션 사이즈[1,2,3] or [1,2,3,4,5]
		int pageNavSize = 5;
	
		int pageNo = ((reqPage - 1) / pageNavSize) * pageNavSize + 1;// 페이지번호 연산식
		String pageNavi = "<ul class='pagination cirtle-style'>";

		if (pageNo != 1) {
			pageNavi += "<li>";
			pageNavi += "<a class='page-item' href='/notice/list?reqPage=" + (pageNo - 1) + "&noticeCd=" + postType
					+ "&noticeCdNm=" + "'>";
			pageNavi += "<span class='material-icons'>chevron_left</span>";
			pageNavi += "</li>";
		}

		for (int i = 0; i < pageNavSize; i++) {
			pageNavi += "<li>";
			// 선택한 페이지와 선택하지 않은 페이지를 시각적으로 다르게 표현
			if (reqPage == pageNo) {
				pageNavi += "<a class='page-item active-page' href='/notice/list?reqPage=" + pageNo + "&noticeCd="
						+ postType + "&noticeCdNm=" + postTypeNm + "'>";
			} else {
				pageNavi += "<a class='page-item' href='/notice/list?reqPage=" + pageNo + "&noticeCd=" + postType
						+ "&noticeCdNm=" + postTypeNm + "'>";
			}

			pageNavi += pageNo + "</a></li>";
			pageNo++;

			if (pageNo > totPage) {
				break;
			}
		}
		if (pageNo <= totPage) {
			pageNavi += "<li>";
			pageNavi += "<a class='page-item' href='/notice/list?reqPage=" + pageNo + "&noticeCd=" + postType
					+ "&noticeCdNm=" + "'>";
			pageNavi += "<span class='material-icons'>chevron_right</span>";
			pageNavi += "</li>";
		}

		pageNavi += "</ul>";
		PageData pd = new PageData();
		pd.setList(yourList);//
		pd.setPageNavi(pageNavi);

		JDBCTemplate.close(conn);

		return pd;
	
	}
}
