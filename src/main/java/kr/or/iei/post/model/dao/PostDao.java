package kr.or.iei.post.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.or.iei.common.JDBCTemplate;
import kr.or.iei.post.model.vo.Post;

public class PostDao {

	//공지사항 목록 보기
	public ArrayList<Post> selectPostList(Connection conn, String postTypeCd, int start, int end) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Post> list = new ArrayList<Post>();
		String query = "select * from (select rownum rnum, a.* from(select rownum, a.* from tbl_post a where post_type_cd = ? order by post_date desc) a ) a where rnum between ? and ?";
		//String query = "select * from (select rownum rnum, a.* from(select rownum, a.* from tbl_post where post_type_id = ?)a)a) where  rnum between ? and ?"; 
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, postTypeCd);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Post p = new Post();
				p.setPostNo(rset.getString("post_no"));
				p.setPostTypeCd(rset.getString("post_type_cd"));
				p.setPostTitle(rset.getString("post_title"));
				p.setPostContent(rset.getString("post_content"));
				p.setUserNo(rset.getString("user_no"));
				p.setPostDate(rset.getString("post_date"));
				list.add(p);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
			
		return list;
	}


	//전체 게시글 갯수
	public int selectPostCount(Connection conn, String postTypeCd) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totCnt = 0;

		String query = "select count(*) cnt from tbl_post where post_type_cd = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, postTypeCd);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				totCnt = rset.getInt("cnt");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return totCnt;
	}

	
	//게시글 번호 조회
		public String selectPostNo(Connection conn) {
			PreparedStatement pstmt = null;
			ResultSet rset = null;
			String query = "select to_char(sysdate, 'yymmdd') || lpad(seq_post.nextval, 4, '0') as post_no from dual";
			String postNo = "";
			
			try {
				pstmt = conn.prepareStatement(query);
				rset = pstmt.executeQuery();
				rset.next();
				postNo = rset.getString("post_no");
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				JDBCTemplate.close(rset);
				JDBCTemplate.close(pstmt);
			}
			
			return postNo;
		}


		//게시글 상세 보기
		public Post selectOnePost(Connection conn, String postNo) {
			PreparedStatement pstmt = null;
			ResultSet rset = null;
			Post p = null;
			String query = "select a.*, c.post_type_nm from tbl_post a, tbl_post_type c where a.post_no = ?  and a.post_type_cd = c.post_type_id";
			
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, postNo);
				rset = pstmt.executeQuery();
				
				System.out.println(postNo);
				
				if(rset.next()) {
					p = new Post();
					p.setPostNo(rset.getString("post_no"));
					p.setPostTypeCd(rset.getString("post_type_cd"));
					p.setPostTypeNm(rset.getString("post_type_nm"));
					p.setPostTitle(rset.getString("post_title"));
					p.setUserNo(rset.getString("user_no"));
					p.setPostContent(rset.getString("post_content"));
					p.setPostDate(rset.getString("post_date"));
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				JDBCTemplate.close(rset);
				JDBCTemplate.close(pstmt);
			}
			System.out.println(p);
			return p;
		}

}
