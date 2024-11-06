package kr.or.iei.user.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.or.iei.common.JDBCTemplate;

public class UserDao {

	public int deleteUser(Connection conn, String userNo) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "delete from TBL_User where user_no = ? cascade";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, "userNo");
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public int nicknameChk(Connection conn, String userNickname) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select count(*) as cnt From TBL_User where user_Nickname = ?";
		int cnt = 0;
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userNickname);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				cnt = rset.getInt("cnt");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}		
		return cnt;
	}

	public int userPwChg(Connection conn, String userNo, String newUserPw) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "Update Tbl_User_withTrip set User_Pw = ? Where User_No = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, newUserPw);
			pstmt.setString(2, userNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}		
		return result;
	}

}
