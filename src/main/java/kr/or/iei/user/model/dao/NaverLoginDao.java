package kr.or.iei.user.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.or.iei.common.JDBCTemplate;
import kr.or.iei.user.model.vo.UserNaver;

public class NaverLoginDao {

	public UserNaver naverLogin(Connection conn, String email) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		UserNaver n = null;
		String query = "select * From tbl_user_naver where user_email = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, email);
			rset = pstmt.executeQuery();	
			if(rset.next()) {
				n = new UserNaver();
				n.setUserNo(rset.getString("user_no"));
				n.setUserNickname(rset.getString("user_nickname"));
				n.setUserName(rset.getString("user_name"));
				n.setUserId(rset.getString("user_id"));
				n.setUserEmail(rset.getString("user_email"));
				n.setUserPhone(rset.getString("user_phone"));
				n.setEnrollDate(rset.getDate("enroll_date"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return n;
	}



}
