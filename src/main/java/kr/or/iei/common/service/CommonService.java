package kr.or.iei.common.service;

import java.sql.Connection;
import java.util.ArrayList;

import kr.or.iei.common.JDBCTemplate;
import kr.or.iei.common.dao.CommonDao;
import kr.or.iei.common.model.vo.PageData;
import kr.or.iei.common.vo.Pagination;

public class CommonService {
	CommonDao dao;

	public CommonService() {
		dao = new CommonDao();
	}

	public int totalPostCnt(String postTypeId) {
		Connection conn = JDBCTemplate.getConnection();
		int totCnt = dao.selectPostCount(conn, postTypeId);
		JDBCTemplate.close(conn);
		return totCnt;
	}
	public int totalUserCnt() {
		Connection conn = JDBCTemplate.getConnection();
		int totCnt = dao.selectUserCount(conn);
		JDBCTemplate.close(conn);
		return totCnt;
	}
	public int totalCmntCnt() {
		Connection conn = JDBCTemplate.getConnection();
		int totCnt = dao.selectCmntCount(conn);
		JDBCTemplate.close(conn);
		return totCnt;
	}

	// TODO 조금 더 만져봐야 됌.아직 미해결
	public PageData Pagination(Pagination pgInfo) {
		Connection conn = JDBCTemplate.getConnection();
		String mapAddr = pgInfo.getMapAddr();
		String postTypeId = pgInfo.getPstTypeId();// 만약 매개변수로 comment 반환받을시 이게 post용 인지, comment용인지 구분할 변수 이
		String postTypeName = pgInfo.getPstTypeName();
		int reqPage = pgInfo.getReqPage(); // 현재 페이지, 매개변수로 받아옴
		int pageSize = pgInfo.getPageSize();// 한 페이지당 게시글 수, 매개변수로 받아옴 15, 30, 50
		int totCnt = pgInfo.getTotCnt();
		int pOrC = pgInfo.getPOrC();
		System.out.println("common pOrC : "+pOrC);
		ArrayList<?> list = pgInfo.getList();
		int totPage = 0;
		String pageNavi = null;
		/*
		 * **README** Service.java내 ArrayList<vo객체명> list = dao.객체명List(conn, postType);
		 * 하여 list받아오고, 해당 list를 pagination호출시 매개변수로 넣어줄 것 int endPg = reqPage *
		 * pageSize; // 끝 페이지 int startPg = endPg-pageSize+1; // 시작 페이지
		 */
		if(pOrC>0) {
			if (totCnt % pageSize > 0) {
				totPage = totCnt / pageSize + 1;

			} else {
				totPage = totCnt / pageSize;
			}
			// 페이지 하단에 보여질 페이지 네비게이션 사이즈[1,2,3] or [1,2,3,4,5]
			int pageNavSize = 5;

			int pageNo = ((reqPage - 1) / pageNavSize) * pageNavSize + 1;// 페이지번호 연산식
			pageNavi = "<ul class='pagination cirtle-style'>";

			if (pageNo != 1) {
				pageNavi += "<li>";
				pageNavi += "<a class='page-item' href='" + mapAddr + "?pOrC="+pOrC+"&reqPage=" + (pageNo - 1) + "&postTypeId="
						+ postTypeId + "&postTypeName=" + postTypeName + "&pageSize=" + pageSize + "'>";
				pageNavi += "<span class='material-icons'>chevron_left</span>";
				pageNavi += "</li>";
			}

			for (int i = 0; i < pageNavSize; i++) {
				pageNavi += "<li>";
				// 선택한 페이지와 선택하지 않은 페이지를 시각적으로 다르게 표현
				if (reqPage == pageNo) {
					pageNavi += "<a class='page-item active-page' href='" + mapAddr + "?pOrC="+pOrC+"&reqPage=" + pageNo
							+ "&postTypeId=" + postTypeId + "&postTypeName=" + postTypeName + "&pageSize=" + pageSize
							+ "'>";
				} else {
					pageNavi += "<a class='page-item' href='" + mapAddr + "?pOrC="+pOrC+"&reqPage=" + pageNo + "&postTypeId="
							+ postTypeId + "&postTypeName=" + postTypeName + "&pageSize=" + pageSize + "'>";
				}

				pageNavi += pageNo + "</a></li>";
				pageNo++;

				if (pageNo > totPage) {
					break;
				}
			}
			if (pageNo <= totPage) {
				pageNavi += "<li>";
				pageNavi += "<a class='page-item' href='" + mapAddr + "?pOrC="+pOrC+"&reqPage=" + pageNo + "&postTypeId=" + postTypeId
						+ "&postTypeName=" + "&pageSize=" + pageSize + "'>";
				pageNavi += "<span class='material-icons'>chevron_right</span>";
				pageNavi += "</li>";
			}
			pageNavi += "</ul>";
			
		}else if(pOrC == 0) {
			if (totCnt % pageSize > 0) {
				totPage = totCnt / pageSize + 1;

			} else {
				totPage = totCnt / pageSize;
			}
			// 페이지 하단에 보여질 페이지 네비게이션 사이즈[1,2,3] or [1,2,3,4,5]
			int pageNavSize = 5;

			int pageNo = ((reqPage - 1) / pageNavSize) * pageNavSize + 1;// 페이지번호 연산식
			pageNavi = "<ul class='pagination cirtle-style'>";

			if (pageNo != 1) {
				pageNavi += "<li>";
				pageNavi += "<a class='page-item' href='" + mapAddr + "?pOrC="+pOrC+"&reqPage=" + (pageNo - 1) + "&postTypeId="
						+ postTypeId + "&postTypeName=" + postTypeName + "&pageSize=" + pageSize + "'>";
				pageNavi += "<span class='material-icons'>chevron_left</span>";
				pageNavi += "</li>";
			}

			for (int i = 0; i < pageNavSize; i++) {
				pageNavi += "<li>";
				// 선택한 페이지와 선택하지 않은 페이지를 시각적으로 다르게 표현
				if (reqPage == pageNo) {
					pageNavi += "<a class='page-item active-page' href='" + mapAddr + "?pOrC="+pOrC+"&reqPage=" + pageNo
							+ "&postTypeId=" + postTypeId + "&postTypeName=" + postTypeName + "&pageSize=" + pageSize
							+ "'>";
				} else {
					pageNavi += "<a class='page-item' href='" + mapAddr + "?pOrC="+pOrC+"&reqPage=" + pageNo + "&postTypeId="
							+ postTypeId + "&postTypeName=" + postTypeName + "&pageSize=" + pageSize + "'>";
				}

				pageNavi += pageNo + "</a></li>";
				pageNo++;

				if (pageNo > totPage) {
					break;
				}
			}
			if (pageNo <= totPage) {
				pageNavi += "<li>";
				pageNavi += "<a class='page-item' href='" + mapAddr + "?pOrC="+pOrC+"&reqPage=" + pageNo + "&postTypeId=" + postTypeId
						+ "&postTypeName=" + "&pageSize=" + pageSize + "'>";
				pageNavi += "<span class='material-icons'>chevron_right</span>";
				pageNavi += "</li>";
			}
			pageNavi += "</ul>";
			
		}
		
			
		

		
		PageData pd = new PageData();
		pd.setList(list);//
		pd.setPageNavi(pageNavi);
		JDBCTemplate.close(conn);

		return pd;

	}
}
