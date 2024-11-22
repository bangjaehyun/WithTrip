package kr.or.iei.admin.service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.StringTokenizer;

import kr.or.iei.admin.dao.AdminDao;
import kr.or.iei.comment.vo.Comment;
import kr.or.iei.common.JDBCTemplate;
import kr.or.iei.common.model.vo.PageData;
import kr.or.iei.common.service.CommonService;
import kr.or.iei.common.vo.Pagination;
import kr.or.iei.post.model.vo.Post;

public class AdminService {
	AdminDao dao;
	CommonService commnServ;

	public AdminService() {
		dao = new AdminDao();
		commnServ = new CommonService();
	}
	
	
	public ArrayList<Post> selectPostList(String postTypeId, int reqPg, int pgSize) {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Post> pList = null;
		pList = dao.selectPostList(conn, postTypeId, reqPg, pgSize);
		JDBCTemplate.close(conn);
		return pList;
	}

	public ArrayList<Post> selectSrchPostList(String postTypeId, int reqPg, int pgSize, int srchMtdVal,
			String inptVal) {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Post> pList = null;
		String srchMtd = null;
		if (srchMtdVal == 1) {
			srchMtd = "where user_id=";
			pList = dao.selectSrchPostList(conn, postTypeId, reqPg, pgSize, srchMtd, inptVal);
			JDBCTemplate.close(conn);
		} else if (srchMtdVal == 2) {
			srchMtd = "user_nickname=";
			pList = dao.selectSrchPostList(conn, postTypeId, reqPg, pgSize, srchMtd, inptVal);
			JDBCTemplate.close(conn);
		}
		return pList;
	}

	public ArrayList<Comment> selectCommentList(int reqPg, int pgSize) {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Comment> cList = dao.selectCommentList(conn, reqPg, pgSize);
		JDBCTemplate.close(conn);
		return cList;
	}

	public PageData pageListPost(Pagination pageInfo) {
		int totCnt = commnServ.totalPostCnt(pageInfo.getPstTypeId());
		pageInfo.setTotCnt(totCnt);
		PageData pd = commnServ.Pagination(pageInfo);
		return pd;
	}

	public PageData pageListCmt(Pagination pageInfo) {
		int totCnt = commnServ.totalCmntCntAdmin();
		pageInfo.setTotCnt(totCnt);
		PageData pd = commnServ.Pagination(pageInfo);
		return pd;
	}
	public PageData pageListUser(String mapAddr, int reqPage, int pageSize, ArrayList<Post> pgList) {
		int totCnt = commnServ.totalUserCnt();
		PageData pd = Pagination(mapAddr,reqPage,pageSize,totCnt,pgList);
		return pd;
	}
	public ArrayList<Post> selectIndexPostList() {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Post> list = dao.selectIndexPostList(conn);
		JDBCTemplate.close(conn);
		return list;
	}

	public ArrayList<Comment> selectIndexCommentList() {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Comment> list = dao.selectIndexCommentList(conn);
		;
		JDBCTemplate.close(conn);
		return list;
	}
	/*
	 * public int delCmts(String userNo, int cmts) { //복수개의 댓글 삭제하는 메소드 Connection
	 * conn = JDBCTemplate.getConnection(); int result = dao.delCmts(conn, userNo);
	 * JDBCTemplate.close(conn); return result; } public int delCmt(String userNo) {
	 * // 1개의 댓글 삭제하는 메소드 Connection conn = JDBCTemplate.getConnection(); int result
	 * = dao.delCmt(conn, userNo); JDBCTemplate.close(conn); return result; }
	 */

	public int allPostSelDel(String postIdArrStr) {
		Connection conn = JDBCTemplate.getConnection();
		StringTokenizer st = new StringTokenizer(postIdArrStr, "/");
		boolean rsltChk = true;
		while (st.hasMoreTokens()) {
			String postId = st.nextToken();
			int result = dao.allPostSelDel(conn, postId);
			if (result < 1) {
				rsltChk = false;
				break;
			}
		}
		if (rsltChk) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		if (rsltChk) {
			return 1;
		} else {
			return 0;
		}

	}

	public int allCmtSelDel(String commentIdArr) {
		Connection conn = JDBCTemplate.getConnection();
		StringTokenizer st = new StringTokenizer(commentIdArr, "/");
		boolean rsltChk = true;
		while (st.hasMoreTokens()) {
			String commentId = st.nextToken();
			int result = dao.allCmtSelDel(conn, commentId);
			if (result < 1) {
				rsltChk = false;
				break;
			}
		}
		if (rsltChk) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		if (rsltChk) {
			return 1;
		} else {
			return 0;
		}
	}

	public Pagination pagiNationPost(String mapAddr, String pstTypeId, String pstTypeName, int reqPage, int pageSize,
			ArrayList<?> list, int pOrC) {
		Pagination pgInfo = new Pagination();
		pgInfo.setMapAddr(mapAddr);
		pgInfo.setPstTypeId(pstTypeId);
		pgInfo.setPstTypeName(pstTypeName);
		pgInfo.setReqPage(reqPage);
		pgInfo.setPageSize(pageSize);
		pgInfo.setList(list);
		pgInfo.setPOrC(pOrC);
		return pgInfo;
	}

	public Pagination pagiNationCmt(String mapAddr, int reqPage, int pageSize, ArrayList<Comment> list, int pOrC) {
		Pagination pgInfo = new Pagination();
		pgInfo.setMapAddr(mapAddr);
		pgInfo.setReqPage(reqPage);
		pgInfo.setPageSize(pageSize);
		pgInfo.setList(list);
		pgInfo.setPOrC(pOrC);
		return pgInfo;
	}

	public ArrayList<Post> postIdNameList() {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Post> list = dao.postIdNameList(conn);
		return list;
	}

	public Post selectPost(int postTypeId, String postTypeName, String userNo, String postNo) {
		Connection conn = JDBCTemplate.getConnection();
		Post content = dao.selectPost(conn, postTypeId, postTypeName, userNo, postNo);
		JDBCTemplate.close(conn);
		return content;
	}

	public Comment selectComment(String userNo, String commentId) {
		Connection conn = JDBCTemplate.getConnection();
		Comment content = dao.selectComment(conn, userNo, commentId);
		JDBCTemplate.close(conn);
		return content;
	}


	public ArrayList<Post> selectUserList() {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Post> list = dao.selectUserList(conn);
		return list;
		
	}
	public PageData Pagination(String mpAddr, int reqPg,int pageSz, int ttCnt, ArrayList<?> ulist) {
		Connection conn = JDBCTemplate.getConnection();
		String mapAddr = mpAddr;
		int reqPage = reqPg;
		int pageSize = pageSz;
		int totCnt = ttCnt;
		ArrayList<?> list = ulist;;
		int totPage = 0;
		String pageNavi = null;
		/*
		 * **README** Service.java내 ArrayList<vo객체명> list = dao.객체명List(conn, postType);
		 * 하여 list받아오고, 해당 list를 pagination호출시 매개변수로 넣어줄 것 int endPg = reqPage *
		 * pageSize; // 끝 페이지 int startPg = endPg-pageSize+1; // 시작 페이지
		 */
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
				pageNavi += "<a class='page-item' href='" + mapAddr + "?reqPage=" + (pageNo - 1) + "&pageSize=" + pageSize + "'>";
				pageNavi += "<span class='material-icons'>chevron_left</span>";
				pageNavi += "</li>";
			}

			for (int i = 0; i < pageNavSize; i++) {
				pageNavi += "<li>";
				// 선택한 페이지와 선택하지 않은 페이지를 시각적으로 다르게 표현
				if (reqPage == pageNo) {
					pageNavi +="<a class='page-item' href='" + mapAddr + "?reqPage=" + (pageNo - 1) + "&pageSize=" + pageSize + "'>";
				} else {
					pageNavi += "<a class='page-item' href='" + mapAddr + "?reqPage=" + (pageNo - 1) + "&pageSize=" + pageSize + "'>";
				}

				pageNavi += pageNo + "</a></li>";
				pageNo++;

				if (pageNo > totPage) {
					break;
				}
			}
			if (pageNo <= totPage) {
				pageNavi += "<li>";
				pageNavi += "<a class='page-item' href='" + mapAddr + "?reqPage=" + (pageNo - 1) + "&pageSize=" + pageSize + "'>";
				pageNavi += "<span class='material-icons'>chevron_right</span>";
				pageNavi += "</li>";
			}
			pageNavi += "</ul>";
			
		
		PageData pd = new PageData();
		pd.setList(list);//
		pd.setPageNavi(pageNavi);
		JDBCTemplate.close(conn);

		return pd;

	}


	public int delUser(String id) {
		Connection conn = JDBCTemplate.getConnection();
		boolean rsltChk = true;
			int result = dao.delUser(conn, id);
			if (result < 1) {
				rsltChk = false;
			}
		if (rsltChk) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		if (rsltChk) {
			return 1;
		} else {
			return 0;
		}

	}


	public int updUserAdmin(String id, String userType) {
		Connection conn = JDBCTemplate.getConnection();
		int result = dao.updUserAdmin(conn, id, userType);
		if(result > 0){
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		System.out.println(result);
		return result;
	}


	public int allUserSelDel(String idArr) {
		Connection conn = JDBCTemplate.getConnection();
		StringTokenizer st = new StringTokenizer(idArr, "/");
		boolean rsltChk = true;
		while (st.hasMoreTokens()) {
			String userNo = st.nextToken();
			int result = dao.allUserSelDel(conn, userNo);
			if (result < 1) {
				rsltChk = false;
				break;
			}
		}
		if (rsltChk) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		if (rsltChk) {
			return 1;
		} else {
			return 0;
		}
	}
}
