package kr.or.iei.user.model.service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.StringTokenizer;

import org.mindrot.jbcrypt.BCrypt;

import kr.or.iei.common.JDBCTemplate;
import kr.or.iei.common.model.vo.PageData;
import kr.or.iei.common.service.CommonService;
import kr.or.iei.common.vo.Pagination;
import kr.or.iei.post.model.vo.Post;
import kr.or.iei.user.model.dao.UserDao;
import kr.or.iei.user.model.vo.User;
import kr.or.iei.user.model.vo.UserSite;

public class UserService {
	UserDao dao;
	CommonService commonServ;

	public UserService(){
		dao = new UserDao();
		commonServ = new CommonService();
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
	public int insertUserSite(UserSite usersite) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = dao.insertUserSite(conn, usersite);
		
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
		return user;
	}
	public ArrayList<Post> selMyPosts(String postTypeId,int reqPg, int pgSize) {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Post> list  = dao.selectAllPostsList(postTypeId, reqPg, pgSize, conn);
		JDBCTemplate.close(conn);
		return list;
	}
	
	public PageData pageList(Pagination pageInfo) {
		int totCnt = commonServ.totalPostCnt(pageInfo.getPstTypeId());
		pageInfo.setTotCnt(totCnt);
		PageData pd = commonServ.Pagination(pageInfo);
		return pd;
	}

	public int allPostSelDel(String postIdArr) {
		Connection conn = JDBCTemplate.getConnection();
		StringTokenizer st = new StringTokenizer(postIdArr, "/");
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
	public int updateUserInfo(String userNo, String updNickname, String updUserPhone, int type) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = dao.updateUserPhone(conn, userNo, updNickname ,updUserPhone, type);
		
		if(result > 0) {
			result = dao.updateUserNickname(conn, userNo, updNickname);
			
			if(result > 0) {
				JDBCTemplate.commit(conn);
			}else {
				JDBCTemplate.rollback(conn);
			}
		}
		
		JDBCTemplate.close(conn);
		return result;
	}
	
	//이메일로 아이디 찾기
	public String srchInfoId(String userEmail) {
		Connection conn = JDBCTemplate.getConnection();
		String userId = dao.srchInfoId(conn, userEmail);
		JDBCTemplate.close(conn);
		
		
		return userId;
	}
	
	//이메일과 아이디로 비밀번호 찾기 - 이메일 전송
	    public String srchInfoPw(String userId, String userEmail) {
	       Connection conn = JDBCTemplate.getConnection();
	       String toEmail = dao.srchInfoPw(conn, userId, userEmail);
	       JDBCTemplate.close(conn);
	       return toEmail;
	    }

	    public int updateUserPw(String userId, String newUserPw) {
	       Connection conn = JDBCTemplate.getConnection();
	       
	       newUserPw = BCrypt.hashpw(newUserPw, BCrypt.gensalt());   //새 비밀번호 암호화
	       int result = dao.updateUserPw(conn, userId, newUserPw);
	       
	       if(result > 0) {
	          JDBCTemplate.commit(conn);
	       } else {
	          JDBCTemplate.rollback(conn);
	       }
	       JDBCTemplate.close(conn);
	       
	       return result;
	    }


		
}
