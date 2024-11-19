package kr.or.iei.user.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.or.iei.common.JDBCTemplate;
import kr.or.iei.post.model.vo.Post;
import kr.or.iei.user.model.vo.UserSite;

public class UserDao {

	public int deleteUser(Connection conn, String userNo) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "delete from tbl_user where user_no = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userNo);
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
		String query = "select count(*) as cnt From tbl_user where user_Nickname = ?";
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
		String query = "Update tbl_user_withtrip set User_Pw = ? Where User_No = ?";
		
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
	public int insertUserSite(Connection conn, UserSite usersite) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "insert into tbl_user_withtrip values (to_char(sysdate,'yymmddhh24mi') || lpad(seq_user_no.nextval,5,'0'),?,?,?,?,?,?,sysdate)";
		
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, usersite.getUserNickname());
			pstmt.setString(2, usersite.getUserName());			
			pstmt.setString(3, usersite.getUserId());
			pstmt.setString(4, usersite.getUserPw());
			pstmt.setString(5, usersite.getUserEmail());
			pstmt.setString(6, usersite.getUserPhone());
			System.out.println(usersite);
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
		
		String query = "select count(*) as cnt from tbl_user_withtrip where user_id = ?";
		
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
	
		//로그인
	public UserSite userLogin(Connection conn, String loginId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		UserSite u = null;
		int userType = 5;
		String query = "select * from tbl_user_withtrip where user_id = ? ";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, loginId);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				u = new UserSite();
				u.setUserNo(rset.getString("user_no"));
				u.setUserId(rset.getString("user_id"));
				u.setUserPw(rset.getString("user_pw"));
				u.setUserName(rset.getString("user_name"));
				u.setUserEmail(rset.getString("user_email"));
				u.setUserPhone(rset.getString("user_phone"));
				u.setUserNickname(rset.getString("user_nickname"));
				u.setEnrollDate(rset.getDate("enroll_date"));
				u.setUserType(userType);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		
		return u;
	}
	public ArrayList<Post> selectAllPostsList(String postTypeId,int reqPg, int pgSize, Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int endPg = reqPg * pgSize; // 끝 페이지  
		int startPg = endPg-pgSize+1; // 시작 페이지  
		ArrayList<Post> list = new ArrayList<Post>();
		String query = "";
			query = "select * from (select rownum as rnum, a.* from (select * from tbl_Post a join tbl_user b on(a.user_no = b.user_no)where Post_type_id = ? order by Post_date desc) a) where rnum between ? and ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, postTypeId);
			pstmt.setInt(2, startPg);
			pstmt.setInt(3, endPg);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Post pst = new Post();
				pst.setPostNo(rset.getString("Post_no"));
				pst.setUserNo(rset.getString("user_no"));
				pst.setPostTypeId(rset.getString("Post_type_id"));
				pst.setPostDate(rset.getString("Post_date"));
				pst.setPostTitle(rset.getString("Post_title"));
				pst.setPostContent(rset.getString("Post_content"));
				//
				pst.setUserType(rset.getString("user_type"));
				pst.setUserNickName(rset.getString("user_nickname"));
				list.add(pst);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return list;
	}

	public int allPostSelDel(Connection conn, String postId) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "delete from tbl_Post where post_no = ?";
		
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, postId);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}
	public int updateUserPhone(Connection conn, String userNo,String updNickname ,String updUserPhone, int type) {
		PreparedStatement pstmt = null;
		int result = 0;
		int userType = type;
		String query = "";
		
		if(userType == 3) {
			query = "update TBL_User_Naver set user_Phone = ?, user_Nickname = ? Where User_No = ?";
		}else if(userType == 4) {
			query = "update TBL_User_Kakao set user_Phone = ?, user_Nickname = ? Where User_No = ?";
		}else if(userType == 5) {
			query = "update TBL_User_WithTrip set user_Phone = ?, user_Nickname = ? Where User_No = ?";
		}
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, updUserPhone);
			pstmt.setString(2, updNickname);
			pstmt.setString(3, userNo);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	public int updateUserNickname(Connection conn, String userNo, String updNickname) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "update tbl_user set user_nickname = ? where user_No = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, updNickname);
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

    	//이메일로 아이디 찾기
	public String srchInfoId(Connection conn, String userEmail) {
	    PreparedStatement pstmt = null;
	    ResultSet rset = null;
	    String query = "select user_id from tbl_user_withtrip where user_email = ? ";
	String userId = null;
	
	try {
	   pstmt = conn.prepareStatement(query);
	   pstmt.setString(1, userEmail);
	   rset = pstmt.executeQuery();
	   if(rset.next()) {
	      userId = rset.getString("user_id");
	   }
	   
	} catch (SQLException e) {
	   // TODO Auto-generated catch block
	       e.printStackTrace();
	    } finally {
	       JDBCTemplate.close(rset);
	       JDBCTemplate.close(pstmt);
	    }
	       
	    return userId;
	 }
	
	 //아이디와 이메일로 비밀번호 찾기 -> 이메일 전송
	 public String srchInfoPw(Connection conn, String userId, String userEmail) {
	    PreparedStatement pstmt = null;
	    ResultSet rset = null;
	    String query = "select user_email from tbl_user_withtrip where user_id = ? and user_email =?";
	    String toEmail = null;
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userId);
			pstmt.setString(2, userEmail);
			rset = pstmt.executeQuery();
		   
			if(rset.next()) {
				toEmail = rset.getString("user_email");
			}
	   
		} catch (SQLException e) {
		   // TODO Auto-generated catch block
		   e.printStackTrace();
		} finally {
		   JDBCTemplate.close(rset);
		   JDBCTemplate.close(pstmt);
		}
		    
		return toEmail;
	 }
	
	 public int updateUserPw(Connection conn, String userId, String newUserPw) {
	    
	    PreparedStatement pstmt = null;
	    int result = 0;
	    String query = "update tbl_user_withtrip set user_pw = ? where user_id = ?";
	
		try {
		   pstmt = conn.prepareStatement(query);
		   pstmt.setString(1, newUserPw);
		   pstmt.setString(2, userId);
	   
		   result = pstmt.executeUpdate();
	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
	   } finally {
	      JDBCTemplate.close(pstmt);
	   }
	    
	   return result;
	}

	public int userIdChkSite(Connection conn, String userId) {
		PreparedStatement pstmt = null;
		int result = 0;
		ResultSet rset = null;
		String query = "select count(*) as cnt from tbl_user_withTrip where user_id = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userId);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				result = rset.getInt("cnt");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	public int userIdChkNaver(Connection conn, String userId) {
		PreparedStatement pstmt = null;
		int result = 0;
		ResultSet rset = null;
		String query = "select count(*) as cnt from tbl_user_naver where user_id = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userId);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				result = rset.getInt("cnt");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	 
	 
	}


