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
	public ArrayList<Post> selectPostList(String postTypeId, int reqPg, int pgSize){
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Post> pList = dao.selectPostList(conn, postTypeId, reqPg, pgSize);
		JDBCTemplate.close(conn);
		return pList;
	}
	public ArrayList<Comment> selectCommentList(String postTypeId, String postTypeNm, int reqPg, int pgSize){
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Comment> cList = dao.selectCommentList(conn, postTypeId, reqPg, pgSize);
		JDBCTemplate.close(conn);
		return cList;
	}
	public PageData pageList(Pagination pageInfo) {
		int totCnt = commnServ.totalPostCnt(pageInfo.getPstTypeId());
		pageInfo.setTotCnt(totCnt);
		PageData pd = commnServ.Pagination(pageInfo);
		return pd;
	}
	
	public ArrayList<Comment> selectAllCommentsList() {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Comment> cmtlist = dao.selectAllCommentsList(conn);
		JDBCTemplate.close(conn);
		return cmtlist;

	}

	public ArrayList<Post> selectAllPostsList(String i) {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Post> list  = dao.selectAllPostsList(i, conn);
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

}
