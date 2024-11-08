package kr.or.iei.user.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.or.iei.common.JDBCTemplate;
import kr.or.iei.user.model.vo.User;

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

	
	//회원가입
	public int insertUser(Connection conn, User user) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "insert into user_tbl values (to_char(sysdate,'yymmdd')||lapad(seq_user.nextval,4,'0'),?,?,?,?,?,?,3,sysdate)";
		
		
		try {
			pstmt = conn.prepareStatement(query);
		
			pstmt.setString(1, user.getUserId());
			pstmt.setString(2, user.getUserPw());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserEmail());
			pstmt.setString(5, user.getUserPhone());
			pstmt.setString(6, user.getUserNickname());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}
	
	//아이디 중복체크
	public int idDuplChk(Connection conn, String userId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) as cnt from user_tbl where user_id = ?";
		
		int cnt = 0;
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userId);
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
	
	
	}


