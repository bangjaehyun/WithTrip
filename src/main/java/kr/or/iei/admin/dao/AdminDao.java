package kr.or.iei.admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.or.iei.comment.vo.Comment;
import kr.or.iei.common.JDBCTemplate;
import kr.or.iei.post.model.vo.Post;

public class AdminDao {
	
	public ArrayList<Comment> selectAllCommentsList(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Comment> list = new ArrayList<Comment>();
		String query = "select * from tbl_comment join tbl_user using(user_no)";
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Comment c = new Comment();
				c.setCommentId(rset.getString("comment_id"));
				c.setUserNo(rset.getString("user_no"));
				c.setCommentVal(rset.getString("comment_val"));
				c.setCommentDate(rset.getString("comment_date"));
				c.setCommentLike(rset.getInt("comment_like"));
				c.setCommentDislike(rset.getInt("comment_dislike"));
				
				c.setUserType(rset.getInt("user_type"));
				c.setUserNickname(rset.getString("user_nickname"));
				list.add(c);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
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
			while(rset.next()) {
				Post pst = new Post();
				pst.setPostNo(rset.getString("Post_id"));
				pst.setUserNo(rset.getString("user_no"));
				pst.setPostTypeId(rset.getString("Post_type_id"));
				pst.setPostDate(rset.getString("Post_date"));
				pst.setPostTitle(rset.getString("Post_title"));
				pst.setPostContent(rset.getString("Post_content"));
				//
//TODO.				pst.setUserType(rset.getInt("user_type"));
//				pst.setUserNickname(rset.getString("user_nickname"));
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
	public ArrayList<Comment> selectedCmts(Connection conn, String userNo){
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Comment> list = new ArrayList<Comment>();
		
		String query = "select * from tbl_comment where user_no = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Comment cmt = new Comment();
				cmt.setCommentId(rset.getString("comment_id"));
				cmt.setUserNo(userNo);
				cmt.setCommentVal(rset.getString("comment_val"));
				cmt.setCommentDate(rset.getString("comment_date"));
				cmt.setCommentLike(rset.getInt("comment_like"));//변경예정?
				cmt.setCommentDislike(rset.getInt("comment_dislike"));//변경예정?
				
				list.add(cmt);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
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
		String query = "delete from tbl_Post where Post_id = ?";
		
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, PostId);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}
	public int allCmtSelDel(Connection conn, String commentId) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "delete from tbl_comment where comment_id = ?";
		
		try {
			pstmt=conn.prepareStatement(query);
			pstmt.setString(1, commentId);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	public ArrayList<Post> selectPostList(Connection conn, String postTp, int reqPg, int pgSize) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int endPg = reqPg * pgSize; // 끝 페이지  
		int startPg = endPg-pgSize+1; // 시작 페이지  
		ArrayList<Post> list = new ArrayList<Post>();
		String query = "select * from (select rownum as rnum, a.* from (select a.* from tbl_Post a where Post_type_id = ? order by Post_date desc) a) where rnum between ? and ?";
		try {
			pstmt = conn.prepareStatement(query);
			//PostTypeId : 게시 코드 : 1.공지사항 2.QnA...
			pstmt.setString(1, postTp);
			pstmt.setInt(2, startPg);
			pstmt.setInt(3, endPg);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Post n = new Post();
				n.setPostNo(rset.getString("Post_no"));
				n.setUserNo(rset.getString("user_no"));
				n.setPostTypeId(rset.getString("Post_type_id"));
				n.setPostDate(rset.getString("Post_date"));
				n.setPostTitle(rset.getString("Post_title"));
				n.setPostContent(rset.getString("Post_content"));
				
				
				list.add(n);
				
			}
				
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return list;
	}

}
