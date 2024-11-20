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
				n.setUserType(3);
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

	public int addNaverInfo(Connection conn, UserNaver naverLogin) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "insert into tbl_user_naver values (to_char(sysdate,'yyyymmddhh24mi')||lpad(seq_user_no.nextval,4,'0'),?,?,?,?,?,sysdate)";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, naverLogin.getUserNickname());
			pstmt.setString(2, naverLogin.getUserName());
			pstmt.setString(3, naverLogin.getUserId());
			pstmt.setString(4, naverLogin.getUserEmail());
			pstmt.setString(5, naverLogin.getUserPhone());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		return result;
	}
/*
	//추가 정보 입력 후 자동 로그아웃 & 로그인해서 값 가져오기
	public UserNaver naverUserLogin(Connection conn, String userEmail) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select * from tbl_user_naver where user_email = ?";
		UserNaver n = null;
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userEmail);
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
				n.setUserType(3);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return n;
	}
*/


}
