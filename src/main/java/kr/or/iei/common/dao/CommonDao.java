package kr.or.iei.common.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.or.iei.common.JDBCTemplate;

public class CommonDao {

	public int selectPostCount(Connection conn, String postTp) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) cnt from tbl_post where post_type_id = ?";
		int totCnt = 0;
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, postTp);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				totCnt = rset.getInt("cnt");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return totCnt;
	}

	public int selectCmntCount(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) cnt from tbl_comment";
		int totCnt = 0;
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				totCnt = rset.getInt("cnt");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return totCnt;
	}

	public int selectUserCount(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) cnt from tbl_user";
		int totCnt = 0;
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				totCnt = rset.getInt("cnt");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return totCnt;
	}

}
