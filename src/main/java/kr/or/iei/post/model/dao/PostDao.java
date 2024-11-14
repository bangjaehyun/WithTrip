package kr.or.iei.post.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.or.iei.common.JDBCTemplate;
import kr.or.iei.post.model.vo.Post;
import kr.or.iei.post.model.vo.PostComment;
import kr.or.iei.post.model.vo.PostFile;
import kr.or.iei.spot.model.vo.Spot;
import kr.or.iei.user.model.vo.User;

public class PostDao {

	//공지사항 목록 보기
	public ArrayList<Post> selectPostList(Connection conn, String postTypeCd, int start, int end) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Post> list = new ArrayList<Post>();
		String query = "select * from (select rownum rnum, a.* from(select rownum, a.* from tbl_post a where post_type_id = ? order by post_date desc) a ) a where rnum between ? and ?";
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
				p.setPostTypeCd(rset.getString("post_type_id"));
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

		String query = "select count(*) cnt from tbl_post where post_type_id = ?";
		
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
		String query = "select to_char(sysdate, 'yyyymmddhh24mi') || lpad(seq_post.nextval, 4, '0') as post_no from dual";
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


	//게시글 상세 보기 //게시글 - 조회수 +1 처리 없이 하나 상세보기
	public Post selectOnePost(Connection conn, String postNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Post p = null;
		String query = "select a.* from tbl_post a, tbl_post_type c where a.post_no = ?  and a.post_type_id = c.post_type_id";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, postNo);
			rset = pstmt.executeQuery();
			
			System.out.println(postNo);
			
			if(rset.next()) {
				p = new Post();
				p.setPostNo(rset.getString("post_no"));
				p.setPostTypeCd(rset.getString("post_type_id"));
				p.setPostTitle(rset.getString("post_title"));
				p.setUserNo(rset.getString("user_no"));
				p.setPostContent(rset.getString("post_content"));
				p.setPostDate(rset.getString("post_date"));
				p.setReadCount(rset.getInt("read_count"));
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

	//게시글 종류별 리스트 조회 : 고객센터 메인페이지에서 사용
	public ArrayList<Post> selectIndexPostList(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		//post-type-cd (게시글 종류코드 1-공지사항, 2-여행정보, 3-Q&A, 4-FAQ, 5-사이트 이용안내)별로 그룹지어, 행번호를 조회
		String query = "select * from ( select row_number() over (partition by post_type_id order by post_date desc) as rnum, a.* from tbl_post a) where rnum <=5";
		ArrayList<Post> list = new ArrayList<Post>();
		
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				Post p = new Post();
				p.setPostNo(rset.getString("post_no"));
				p.setPostTypeCd(rset.getString("post_type_id"));
				p.setPostTitle(rset.getString("post_title"));
				p.setUserNo(rset.getString("user_no"));
				p.setPostContent(rset.getString("post_content"));
				p.setPostDate(rset.getString("post_date"));
				list.add(p);
				System.out.println(p);
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

	//게시글 등록
	public int insertPost(Connection conn, Post post) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "insert into tbl_post values(?,?,?,?,?,sysdate,default)";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, post.getPostNo());
			pstmt.setString(2, post.getUserNo());
			pstmt.setString(3, post.getPostTypeCd());
			pstmt.setString(4, post.getPostTitle());
			pstmt.setString(5, post.getPostContent());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//게시글에 파일 넣기
	public int insertPostFile(Connection conn, PostFile file) {
		PreparedStatement pstmt = null;
		String query = "insert into tbl_post_file values (to_char(sysdate, 'yymmddhh24mi') || lpad(seq_post_file.nextval, 4,'0'), ?, ?, ?)";
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, file.getPostNo());
			pstmt.setString(2, file.getFileName());
			pstmt.setString(3, file.getFilePath());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//게시글 작성자 - 닉네임 불러오는 용도
	public User selectUser(Connection conn, String userNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select * from tbl_user where user_no = ?";
		User user = null;
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				user = new User();
				user.setUserNo(rset.getString("user_no"));
				user.setUserNickname(rset.getString("user_nickname"));
				user.setUserType(rset.getInt("user_type"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return user;
	}

	//댓글 작성(등록)
	public int insertComment(Connection conn, PostComment comment) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "insert into tbl_comment values ((to_char(sysdate, 'yymmddhh24mi') || lpad(seq_comment_id.nextval, 4, 0)), ?, ?,sysdate, default, default)";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, comment.getUserNo());
			pstmt.setString(2, comment.getCommentVal());
			
			System.out.println("DAO  - 1, commentId : " +  comment.getCommentId());
			
			System.out.println("DAO : " +  comment);
			
			
			result =  pstmt.executeUpdate();	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}
	
	//해당 게시글에 대한 댓글정보 불러오기
	public ArrayList<PostComment> selectCommentList(Connection conn, String postNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<PostComment> list = new ArrayList<PostComment>();
		String query = "select * from tbl_comment where comment_ref = ? order by comment_date desc";	///최신순으로 댓글 가져오기
	
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, postNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				PostComment c = new PostComment();
				c.setCommentId(rset.getString("comment_Id"));
				c.setUserNo(rset.getString("comment_writer"));
				c.setCommentVal(rset.getString("comment_val"));
				c.setCommentRef(rset.getString("comment_ref"));
				c.setCommentDate(rset.getString("comment_date"));
				list.add(c);
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

	//댓글 삭제
	public int deleteComment(Connection conn, String commentId) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "delete from tbl_comment where comment_id = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, commentId);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	//댓글 수정	
	public int updateComment(Connection conn, PostComment comment) {
		PreparedStatement pstmt = null;
		int result = 0; 
		String query = "update tbl_comment set comment_val = ?  where comment_id = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, comment.getCommentVal());
			pstmt.setString(2, comment.getCommentId());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}


	//게시글 작성 시 장소 정보 추가
	public int insertPostSpot(Connection conn, Spot spot) {
        PreparedStatement pstmt = null;
        int result = 0;
        String query = "insert into tbl_spot values(to_char(sysdate, 'yyyymmddhh24mi') || lpad(seq_spot_no.nextval, 4, '0'), ?,?,?,?,?,?,default)";
        
        try {
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, spot.getSpotName());
            pstmt.setInt(2, spot.getSpotType());
            pstmt.setString(3, spot.getSpotAddr());
            pstmt.setString(4, spot.getSpotLat());
            pstmt.setString(5, spot.getSpotLng());
            pstmt.setString(6, spot.getSpotPhone());
            
            result = pstmt.executeUpdate();
            
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }finally {
            JDBCTemplate.close(pstmt);
        }
        
        return result;
    }

	//작성한 댓글 댓글관리테이블에 넣어주기
	public int insertCmtManagement(Connection conn, PostComment comment) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "insert into tbl_post_comment_management values (?, ?, ?)";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, comment.getCommentId());
			pstmt.setString(2, comment.getCommentRef());
			pstmt.setInt(3, comment.getPostTypeCd());
			
			System.out.println("DAO - 2, commentId : " + comment.getCommentId());
			System.out.println("DAO - 2, commentRef : " + comment.getCommentRef());
			System.out.println("DAO - 2, postTypeCd : " + comment.getPostTypeCd());		
			
			System.out.println("DAO - 2 : " +  comment);
			
			result =  pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}

	//게시글 조회시 불러올 업로드된 파일
	public ArrayList<PostFile> selectPostFileList(Connection conn, String postNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select * from tbl_post_file where post_no = ?";
		ArrayList<PostFile> fileList = new ArrayList<PostFile>();
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, postNo);
			rset = pstmt.executeQuery();
					
			while (rset.next()) {
				PostFile file = new PostFile();
				file.setFileNo(rset.getString("file_no"));
				file.setPostNo(rset.getString("post_no"));
				file.setFileName(rset.getString("file_name"));
				file.setFilePath(rset.getString("file_path"));
				fileList.add(file);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return fileList;
	}

	//게시글 조회수+1
	public int updateReadCount(Connection conn, String postNo) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "update tbl_post set read_count = read_count +1 where post_no = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, postNo);
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
