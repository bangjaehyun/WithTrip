package kr.or.iei.user.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.or.iei.common.JDBCTemplate;
import kr.or.iei.user.model.vo.UserGoogle;
import kr.or.iei.user.model.vo.UserNaver;

public class GoogleLoginDao {

	public UserGoogle googleLogin(Connection conn, String email) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		UserGoogle g = null;
		String query = "select * From tbl_user_kakao where user_email = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, email);
			rset = pstmt.executeQuery();	
			if(rset.next()) {
				g = new UserGoogle();
				g.setUserNo(rset.getString("user_no"));
				g.setUserNickname(rset.getString("user_nickname"));
				g.setUserName(rset.getString("user_name"));
				g.setUserId(rset.getString("user_id"));
				g.setUserEmail(rset.getString("user_email"));
				g.setUserPhone(rset.getString("user_phone"));
				g.setEnrollDate(rset.getDate("enroll_date"));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return g;
	}



}
