package kr.or.iei.user.model.service;

import java.sql.Connection;

import kr.or.iei.common.JDBCTemplate;
import kr.or.iei.user.model.dao.UserDao;

public class UserService {
	UserDao dao;

	public UserService(){
		dao = new UserDao();
	}
	
	public int deleteUser(String userNo) {
		Connection conn = JDBCTemplate.getConnection();
		int result = dao.deleteUser(conn, userNo);

		if(result > 0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}

	public int nicknameChk(String userNickname) {
		Connection conn = JDBCTemplate.getConnection();
		int result = dao.nicknameChk(conn, userNickname);
		JDBCTemplate.close(conn);
		return result;
	}

	public int userPwChg(String userNo, String newUserPw) {
		Connection conn = JDBCTemplate.getConnection();
		int result = dao.userPwChg(conn, userNo, newUserPw);
		
		if(result > 0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}

}
