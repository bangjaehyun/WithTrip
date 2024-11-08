package kr.or.iei.user.model.service;

import java.sql.Connection;

import org.mindrot.jbcrypt.BCrypt;

import kr.or.iei.common.JDBCTemplate;
import kr.or.iei.user.model.dao.UserDao;
import kr.or.iei.user.model.vo.User;

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
		newUserPw = BCrypt.hashpw(newUserPw, BCrypt.gensalt());
		
		
		int result = dao.userPwChg(conn, userNo, newUserPw);
		
		if(result > 0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}
	//회원가입
	public int insertUser(User user) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = dao.insertUser(conn, user);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);	
		return result;
			
		}
	
	public int idDuplChk(String userId) {
		Connection conn = JDBCTemplate.getConnection();
		int result = dao.idDuplChk(conn, userId);
		JDBCTemplate.close(conn);
		return result;
		

}
	//  로그인
	public User userLogin(String loginId, String loginPw) {
		Connection conn = JDBCTemplate.getConnection();
		User user = dao.userLogin(conn, loginId, loginPw);
		JDBCTemplate.close(conn);
		return null;
	}
}
