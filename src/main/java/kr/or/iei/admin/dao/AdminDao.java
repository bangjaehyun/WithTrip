package kr.or.iei.admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.or.iei.comment.vo.Comment;
import kr.or.iei.common.JDBCTemplate;
import kr.or.iei.post.model.vo.Post;
import kr.or.iei.user.model.vo.User;

public class AdminDao {
	
	public Post shortenContentTitle(Post p){
		if(p.getPostTitle().length()>10) {
			String title = p.getPostTitle().substring(0, 9);
			p.setShortenTitle(title+"...");
		}
		if(p.getPostContent().length()>10) {
			String content = p.getPostContent().substring(0, 10);
			p.setShortenContent(content+"...");
		}
		return p; 
	}
	
	public Comment shortenContent(Comment c){
		if(c.getCommentVal().length()>10) {
			String content = c.getCommentVal().substring(0, 10);
			c.setShortenContent(content+"...");
		}
		return c; 
	}
	
	
	public ArrayList<Comment> selectAllCommentsList(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Comment> list = new ArrayList<Comment>();
		String query = "select * from tbl_comment join tbl_user using(user_no)";
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			while (rset.next()) {
				Comment c = new Comment();
				c.setCommentId(rset.getString("comment_id"));
				c.setUserNo(rset.getString("user_no"));
				c.setCommentVal(rset.getString("comment_val"));
				c.setCommentDate(rset.getString("comment_date"));
				c.setCommentLike(rset.getInt("comment_like"));
				c.setCommentDislike(rset.getInt("comment_dislike"));
				
				c.setUserType(rset.getInt("user_type"));
				c.setUserNickname(rset.getString("user_nickname"));
				Comment cmt = shortenContent(c);
				list.add(cmt);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return list;
	}

	public ArrayList<Post> selectAllPostsList(String i, Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Post> list = new ArrayList<Post>();

		String query = "select * from tbl_Post join tbl_user using(user_no) where Post_type_id=?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, i);
			rset = pstmt.executeQuery();
			while (rset.next()) {
				Post pst = new Post();
				User user = new User();
				user.setUserType(rset.getInt("user_type"));
				pst.setUser(user);
				pst.setPostNo(rset.getString("Post_no"));
				pst.setUserNo(rset.getString("user_no"));
				pst.setPostTypeId(rset.getString("Post_type_id"));
				pst.setPostDate(rset.getString("Post_date"));
				pst.setPostTitle(rset.getString("Post_title"));
				pst.setPostContent(rset.getString("Post_content"));
				//
				pst.setUserNickName(rset.getString("user_nickname"));
				Post p = shortenContentTitle(pst);
				list.add(p);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return list;
	}

	public ArrayList<Comment> selectedCmts(Connection conn, String userNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Comment> list = new ArrayList<Comment>();

		String query = "select * from tbl_comment where user_no = ?";

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userNo);
			rset = pstmt.executeQuery();
			while (rset.next()) {
				Comment cmt = new Comment();
				cmt.setCommentId(rset.getString("comment_id"));
				cmt.setUserNo(userNo);
				cmt.setCommentVal(rset.getString("comment_val"));
				cmt.setCommentDate(rset.getString("comment_date"));
				cmt.setCommentLike(rset.getInt("comment_like"));// 변경예정?
				cmt.setCommentDislike(rset.getInt("comment_dislike"));// 변경예정?

				list.add(cmt);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return list;
	}

	public int delCmts(Connection conn, String userNo) {
		selectedCmts(conn, userNo);
		return 0;
	}

	public int allPostSelDel(Connection conn, String PostId) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "delete from tbl_Post where Post_no = ?";

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, PostId);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public int allCmtSelDel(Connection conn, String commentId) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "delete from tbl_comment where comment_id = ?";

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, commentId);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public ArrayList<Post> selectPostList(Connection conn, String postTypeId, int reqPg, int pgSize) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int endPg = reqPg * pgSize; // 끝 페이지

		int startPg = endPg - pgSize + 1; // 시작 페이지

		ArrayList<Post> list = new ArrayList<Post>();
		String query = "select * from (select rownum as rnum, a.* from (select * from tbl_Post a join tbl_user b on(a.user_no = b.user_no)where Post_type_id = ? order by Post_date desc) a) where rnum between ? and ?";
		try {
			pstmt = conn.prepareStatement(query);
			// PostTypeId : 게시 코드 : 1.공지사항 2.QnA...
			pstmt.setString(1, postTypeId);
			pstmt.setInt(2, startPg);
			pstmt.setInt(3, endPg);
			rset = pstmt.executeQuery();
			while (rset.next()) {
				Post pst = new Post();
				User user = new User();
				user.setUserType(rset.getInt("user_type"));
				pst.setUser(user);
				pst.setPostNo(rset.getString("Post_no"));
				pst.setUserNo(rset.getString("user_no"));
				pst.setPostTypeId(rset.getString("Post_type_id"));
				pst.setPostDate(rset.getString("Post_date"));
				pst.setPostTitle(rset.getString("Post_title"));
				pst.setPostContent(rset.getString("Post_content"));

				pst.setUserNickName(rset.getString("user_nickname"));
				Post p = shortenContentTitle(pst);
				list.add(p);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return list;
	}

	public ArrayList<Comment> selectCommentList(Connection conn, int reqPg, int pgSize) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int endPg = reqPg * pgSize; // 끝 페이지
		int startPg = endPg - pgSize + 1; // 시작 페이지
		ArrayList<Comment> list = new ArrayList<Comment>();
		String query = "select * from (select rownum as rnum, a.* from (select a.* from tbl_comment a order by comment_date desc) a) where rnum between ? and ?";
		try {
			pstmt = conn.prepareStatement(query);
			// PostTypeId : 게시 코드 : 1.공지사항 2.QnA...
			pstmt.setInt(1, startPg);
			pstmt.setInt(2, endPg);
			rset = pstmt.executeQuery();
			while (rset.next()) {
				Comment cmt = new Comment();
				cmt.setCommentId(rset.getString("comment_id"));
				cmt.setUserNo(rset.getString("user_no"));
				cmt.setCommentVal(rset.getString("comment_val"));
				cmt.setCommentDate(rset.getString("comment_date"));
				cmt.setCommentLike(rset.getInt("comment_like"));// 변경예정?
				cmt.setCommentDislike(rset.getInt("comment_dislike"));// 변경예정?

				list.add(cmt);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return list;
	}

//admin 페이지의 메인페이지에서 보여줄 게시글 list
	public ArrayList<Post> selectIndexPostList(Connection conn) {

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Post> list = new ArrayList<Post>();
		String query = "select * from (select row_number() over (partition by post_type_id order by post_date desc) as rnum, a.*, b.user_nickname, b.user_type from tbl_post a join tbl_user b on(a.user_no = b.user_no)) where rnum <= 5";
		
		//		String query  = "select * from tbl_notice";
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			while (rset.next()) {
				Post pst = new Post();
				User user = new User();
				user.setUserType(rset.getInt("user_type"));
				pst.setUser(user);
				pst.setPostNo(rset.getString("Post_no"));
				pst.setUserNo(rset.getString("user_no"));
				pst.setPostTypeId(rset.getString("Post_type_id"));
				pst.setPostDate(rset.getString("Post_date"));
				pst.setPostTitle(rset.getString("Post_title"));
				pst.setPostContent(rset.getString("Post_content"));
				pst.setUserNickName(rset.getString("user_nickname"));
				Post p = shortenContentTitle(pst);
				list.add(p);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}

		return list;
	}

//admin 페이지의 메인페이지에서 보여줄 댓글 list
	public ArrayList<Comment> selectIndexCommentList(Connection conn) {

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Comment> list = new ArrayList<Comment>();
		String query = "select * from (select row_number() over (order by comment_date desc) as rnum, a.*, b.user_nickname, b.user_type from tbl_comment a join tbl_user b on(a.user_no = b.user_no)) where rnum <= 10";
//		String query  = "select * from tbl_notice";
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			while (rset.next()) {
				Comment cmt = new Comment();
				cmt.setCommentId(rset.getString("comment_id"));
				cmt.setUserNo(rset.getString("user_no"));
				cmt.setCommentVal(rset.getString("comment_val"));
				cmt.setCommentDate(rset.getString("comment_date"));
				cmt.setCommentLike(rset.getInt("comment_like"));// 변경예정?
				cmt.setCommentDislike(rset.getInt("comment_dislike"));// 변경예정?
				cmt.setUserNickname(rset.getString("user_nickname"));
				Comment c = shortenContent(cmt);
				
				list.add(c);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}

		return list;
	}

	public ArrayList<Post> postIdNameList(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Post> list = new ArrayList<Post>();
		String query = "select * from tbl_post_type";
//	String query  = "select * from tbl_notice";
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			while (rset.next()) {
				Post pst = new Post();
				pst.setPostTypeId(rset.getString("Post_type_id"));
				pst.setPostTypeNm(rset.getString("Post_type_name"));

				list.add(pst);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return list;
	}

	public ArrayList<Post> selectSrchPostList(Connection conn, String postTypeId, int reqPg, int pgSize, String srchMtd,
			String inptVal) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int endPg = reqPg * pgSize; // 끝 페이지

		int startPg = endPg - pgSize + 1; // 시작 페이지

		ArrayList<Post> list = new ArrayList<Post>();
		String query = "select * from (select rownum as rnum, a.* from (select * from tbl_Post a join tbl_user b on(a.user_no = b.user_no)where Post_type_id = ? and ? = ? where  order by Post_date desc) a) where rnum between ? and ?";
		try {
			pstmt = conn.prepareStatement(query);
			// PostTypeId : 게시 코드 : 1.공지사항 2.QnA...
			pstmt.setString(1, postTypeId);
			pstmt.setString(2, srchMtd);
			pstmt.setString(3, inptVal);
			pstmt.setInt(4, startPg);
			pstmt.setInt(5, endPg);
			rset = pstmt.executeQuery();
			while (rset.next()) {
				Post pst = new Post();
				User user = new User();
				user.setUserType(rset.getInt("user_type"));
				pst.setUser(user);
				pst.setPostNo(rset.getString("Post_no"));
				pst.setUserNo(rset.getString("user_no"));
				pst.setPostTypeId(rset.getString("Post_type_id"));
				pst.setPostDate(rset.getString("Post_date"));
				pst.setPostTitle(rset.getString("Post_title"));
				pst.setPostContent(rset.getString("Post_content"));

				pst.setUserNickName(rset.getString("user_nickname"));
				list.add(pst);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return list;
	}

	public Post selectPost(Connection conn, int postTypeId, String postTypeName, String userNo, String postNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Post content = new Post();
		String query = "select * from tbl_post a join tbl_user b on(a.user_no = b.user_no) where post_type_id = ? and a.user_no = ? and post_no = ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, postTypeId);
			pstmt.setString(2, userNo);
			pstmt.setString(3, postNo);
			rset = pstmt.executeQuery();
			while (rset.next()) {
				User user = new User();
				user.setUserType(rset.getInt("user_type"));
				content.setUser(user);
				content.setPostNo(rset.getString("Post_no"));
				content.setUserNo(rset.getString("user_no"));
				content.setPostTypeId(rset.getString("Post_type_id"));
				content.setPostDate(rset.getString("Post_date"));
				content.setPostTitle(rset.getString("Post_title"));
				content.setPostContent(rset.getString("Post_content"));
				content.setUserNickName(rset.getString("user_nickname"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return content;
	}

	public Comment selectComment(Connection conn, String userNo, String commentId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Comment content = new Comment();
		String query = "select * from tbl_comment where user_no = ? and comment_id = ?";
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userNo);
			pstmt.setString(2, commentId);
			rset = pstmt.executeQuery();
			while (rset.next()) {
				content.setCommentId(rset.getString("comment_id"));
				content.setUserNo(rset.getString("user_no"));
				content.setCommentVal(rset.getString("comment_val"));
				content.setCommentDate(rset.getString("comment_date"));
				content.setCommentLike(rset.getInt("comment_like"));
				content.setCommentDislike(rset.getInt("comment_dislike"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return content;
	}

	public ArrayList<Post> selectUserList(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		ArrayList<Post> list = new ArrayList<Post>();
		String query = "select * from tbl_user";
		try {
			pstmt = conn.prepareStatement(query);
			// PostTypeId : 게시 코드 : 1.공지사항 2.QnA...
			rset = pstmt.executeQuery();
			while (rset.next()) {
				Post pst = new Post();
				User user = new User();
				user.setUserNo(rset.getString("user_no"));
				user.setUserType(rset.getInt("user_type"));
				user.setUserNickname(rset.getString("user_nickname"));
				pst.setUser(user);
				list.add(pst);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return list;
		
		
	}

	public int delUser(Connection conn, String id) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "delete from tbl_user where user_no = ?";

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public int updUserAdmin(Connection conn,String userType, String userNo) {
		PreparedStatement pstmt = null;

		int result = 0;
		System.out.println(userType + "userType  "+ userType.length());
		System.out.println(userNo + "userNo  "+ userNo.length());
		String query = "update tbl_user set user_type= ? where user_no = ?";

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userType);
			pstmt.setString(2, userNo);

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}

		return result;
	}

	public int allUserSelDel(Connection conn, String userNo) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "delete from tbl_user where user_no = ?";

		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userNo);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}


	

}
