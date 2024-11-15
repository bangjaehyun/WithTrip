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
				p.setReadCount(rset.getInt("read_count"));
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
	
	//장소 번호 조회
			public String selectSpotNo(Connection conn) {
				PreparedStatement pstmt = null;
				ResultSet rset = null;
				String query = "select to_char(sysdate, 'yyyymmddhh24miss') || lpad(seq_spot_no.nextval, 4, '0') as spot_no from dual";
				String spotNo = "";
				
				try {
					pstmt = conn.prepareStatement(query);
					rset = pstmt.executeQuery();
					rset.next();
					spotNo = rset.getString("spot_no");
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} finally {
					JDBCTemplate.close(rset);
					JDBCTemplate.close(pstmt);
				}
				
				return spotNo;
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
				p.setTagList(rset.getString("post_option"));
				p.setTripDate(rset.getString("post_trip_date"));;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		System.out.println("PostDao : " + p);
		return p;
	}

	//게시글 등록
	public int insertPost(Connection conn, Post post) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "insert into tbl_post values(?,?,?,?,?,sysdate,default,?,?)";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, post.getPostNo());
			pstmt.setString(2, post.getUserNo());
			pstmt.setString(3, post.getPostTypeCd());
			pstmt.setString(4, post.getPostTitle());
			pstmt.setString(5, post.getPostContent());
			pstmt.setString(6, post.getTagList());
			pstmt.setString(7, post.getTripDate());
			
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
				
				System.out.println("PostDao 게시글 작성자" + user);
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
		String query = "insert into tbl_comment values (?, ?, ?,sysdate, default, default)";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, comment.getCommentId());
			pstmt.setString(2, comment.getUserNo());
			pstmt.setString(3, comment.getCommentVal());
			
			System.out.println("DAO  - 1, commentId : " +  comment.getCommentId());
			
			//System.out.println("DAO : " +  comment);
			
			
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
		String query = "select * from tbl_comment where comment_id in (select comment_id from tbl_post_comment_management where post_no = ?) order by comment_date desc";	///최신순으로 댓글 가져오기
	
		System.out.println("PostDao - 댓글정보 comment_ref : " + postNo);
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, postNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				PostComment c = new PostComment();
				c.setCommentId(rset.getString("comment_Id"));
				c.setUserNo(rset.getString("user_no"));
				c.setCommentVal(rset.getString("comment_val"));
				/* c.setCommentRef(rset.getString("post_no")); */
				c.setCommentDate(rset.getString("comment_date"));
				c.setCommentLike(rset.getString("comment_like"));
				c.setCommentDisLike(rset.getString("comment_dislike"));
				list.add(c);
				
				System.out.println("PostDao - 댓글정보 c : " + c);
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		System.out.println("PostDao CommentList : " +list);
		
		return list;
	}

	//댓글 삭제
	public int deleteComment(Connection conn, String commentId) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "delete from tbl_comment where comment_id = ?";
		
		System.out.println("PostDao 댓글삭제 commentId : " + commentId);
		
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
		System.out.println("PostDao 댓글삭제 결과 : " + result);
		
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
        String query = "insert into tbl_spot values(?,?,?,?,?,?,?,?)";
        
        try {
        	pstmt = conn.prepareStatement(query);
            pstmt.setString(1, spot.getSpotNo());
            pstmt.setString(2, spot.getKakaoMapId());
            pstmt.setString(3, spot.getSpotName());
            pstmt.setInt(4, spot.getSpotType());
            pstmt.setString(5, spot.getSpotAddr());
            pstmt.setString(6, spot.getSpotLat());
            pstmt.setString(7, spot.getSpotLng());
            pstmt.setString(8, spot.getSpotPhone());
            
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
				file.setFileName(rset.getString("post_file_name"));
				file.setFilePath(rset.getString("post_file_src"));
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
		System.out.println("PostDao의 게시글 조회수+1 결과 : " + result);
		return result;
	}
	
	public int deletePost(Connection conn, String postNo) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "delete from tbl_post where post_no = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, postNo);
			
			result = pstmt.executeUpdate();
					
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		
		return result;
	}

	//comment_Id 조회
	public String selectCommentId(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select to_char(sysdate, 'yyyymmddhh24mi')||lpad (seq_comment_id.nextval,4,'0')as comment_id from dual";
		String commentId = "";
		
		try {
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			rset.next();
			commentId = rset.getString("comment_id");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return commentId;
	}
	
	public int deleteSpot(Connection conn, String spotNo) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "delete from tbl_spot where spot_no = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, spotNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}
	
	public int deleteSpotManageMent(Connection conn, String spotNo) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "delete from tbl_post_spot_management where spot_no = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, spotNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}
	
	public int modifyPost(Connection conn, Post post) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "update tbl_post set post_title = ?, post_content = ?, post_option = ?, post_trip_date = ? where post_no = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, post.getPostTitle());
			pstmt.setString(2, post.getPostContent());
			pstmt.setString(3, post.getTagList());
			pstmt.setString(4, post.getTripDate());
			pstmt.setString(5, post.getPostNo());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}
	
	
	
	public int insertPostSpotManageMent(Connection conn, String postNo, String spotNo) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "insert into tbl_post_spot_management values(?,?)";
		
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, postNo);
			pstmt.setString(2, spotNo);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}
	
	public ArrayList<Spot> selectPostSpot(Connection conn, String postNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select * from tbl_spot where spot_no in (select spot_no from tbl_post_spot_management where post_no = ?)";
		ArrayList<Spot> spotList = new ArrayList<Spot>();
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, postNo);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				Spot spot = new Spot();
				spot.setSpotNo(rset.getString("spot_no"));
				spot.setKakaoMapId(rset.getString("kakao_spot_id"));
				spot.setSpotName(rset.getString("spot_name"));
				spot.setSpotType(rset.getInt("spot_type"));
				spot.setSpotAddr(rset.getString("spot_addr"));
				spot.setSpotLat(rset.getString("spot_lat"));
				spot.setSpotLng(rset.getString("spot_lng"));
				spot.setSpotPhone(rset.getString("spot_phone"));
				
				spotList.add(spot);
			}
					
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return spotList;
	}
	
	public int deletePostFile(Connection conn, String fileNo) {
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "delete from tbl_post_file where post_file_no = ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, fileNo);
			result = pstmt.executeUpdate();
					
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
			
		}
		return result;
	}


		
}
