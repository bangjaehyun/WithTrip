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
import kr.or.iei.post.model.vo.UserLikeComment;
import kr.or.iei.spot.model.vo.Spot;
import kr.or.iei.user.model.vo.User;

public class PostDao {

  //공지사항, FAQ, 1:1문의, 우리의여행 목록 보기
	public ArrayList<Post> selectPostList(Connection conn, String postTypeCd, int start, int end) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Post> list = new ArrayList<Post>();
		//String query = "select * from (select rownum rnum, a.* from(select rownum, a.* from tbl_post a where post_type_id = ? order by post_date desc) a ) a where rnum between ? and ?";
		//String query = "select * from (select rownum rnum, a.* from(select rownum, a.* from tbl_post where post_type_id = ?)a)a) where  rnum between ? and ?";
		String query = "select * from (select rownum rnum, a.* from (select rownum, a.* from (select a.* from tbl_post a where post_type_id = ? order by post_date desc) a) a) where rnum between ? and ?";
		
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
//      System.out.println("PostDao : " + p);
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
            
//            System.out.println("PostDao 게시글 작성자" + user);
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
      String query = "select * from tbl_comment where comment_id in (select comment_id from tbl_post_comment_management where post_no = ?) order by comment_date desc";   ///최신순으로 댓글 가져오기
   
//      System.out.println("PostDao - 댓글정보 comment_ref : " + postNo);
      
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
            c.setCommentDislike(rset.getString("comment_dislike"));
            list.add(c);
            
//            System.out.println("PostDao - 댓글정보 c : " + c);
            
         }
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      } finally {
         JDBCTemplate.close(rset);
         JDBCTemplate.close(pstmt);
      }
//      System.out.println("PostDao CommentList : " +list);
      
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
            file.setFileNo(rset.getString("post_file_no"));
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
//      System.out.println("PostDao의 게시글 조회수+1 결과 : " + result);
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
   
//게시글삭제 및 수정 시 장소정보 지우기
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
   
//게시글삭제 및 수정 시 장소관리 테이블에서 장소정보 지우기
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
   
//게시글 수정
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
   
   
   //장소관리테이블에 정보 입력
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
   
//게시글 수정하거나 볼때 장소정보 띄우기
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
   
//게시글 첨부파일 삭제
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



   //댓글 좋아요
   /*
   1. tbl_comment_like에 값이 있는지 없는지 확인
   2-1. 없음 -> 값을 넣어줌
   3-1. 성공적으로 완료시 tbl_comment을 변경해줌 == 댓글 좋아요 +1
   
   1. tbl_comment_like에 값이 있는지 없는지 확인
   2-2. 있음 -> 값을 변경해줌
   3-2. 성공적으로 완료시 tbl_comment을 변경해줌 == 댓글 좋아요 -1
   */
//   public int updCmtLike(Connection conn, String postNo, String commentId, String userNo) {
//      PreparedStatement pstmt = null;
//      int result = 0;
//      String query = "update tbl_comment set comment_Like = comment_Like + 1 where comment_id = ?";
//      
//      return result;
//   }

   //댓글호감도 테이블에 해당 댓글에 대한 유저의 정보가 있는지 확인
   public UserLikeComment chkTblCmtLike(Connection conn, String commentId, String userNo) {
      PreparedStatement pstmt = null;
      ResultSet rset = null;
      UserLikeComment comment = null;
      String query = "select * from tbl_comment_like where comment_id  = ? and user_no = ? ";
      
      try {
         pstmt = conn.prepareStatement(query);
         pstmt.setString(1, commentId);
         pstmt.setString(2, userNo);
         
         rset = pstmt.executeQuery();
         
         if(rset.next()) {
            comment = new UserLikeComment();
            comment.setUserNo(rset.getString("user_no"));
            comment.setCommentId(rset.getString("comment_id"));
            comment.setUserLike(rset.getInt("comment_chk"));
         }
         
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      } finally {
         JDBCTemplate.close(rset);
         JDBCTemplate.close(pstmt);
      }
      return comment;
   }


   //댓글호감도 테이블에 해당 댓글에 대한 유저의 정보 삽입
   public int insertCmtLikeInfo(Connection conn, String userNo, String commentId, int like) {
      PreparedStatement pstmt = null;
      int insertCmtLikeInfo = 0;
      String query = "insert into tbl_comment_like values (?, ?, ?)";
      try {
         pstmt = conn.prepareStatement(query);
         pstmt.setString(1, userNo);
         pstmt.setString(2, commentId);
         pstmt.setInt(3, like);         
         insertCmtLikeInfo = pstmt.executeUpdate();
         
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      } finally {
         JDBCTemplate.close(pstmt);
      }
      return insertCmtLikeInfo;
   }



   public int updCommentLike(Connection conn, UserLikeComment commentLike) {
      PreparedStatement pstmt = null;
      int result = 0;
      String query = "update tbl_comment_like set comment_chk = ? where comment_id  = ? and user_no = ?";
      
      try {
         pstmt = conn.prepareStatement(query);
         pstmt.setInt(1, commentLike.getUserLike());
         pstmt.setString(2, commentLike.getCommentId());
         pstmt.setString(3, commentLike.getUserNo());
         
         result = pstmt.executeUpdate();
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }finally {
         JDBCTemplate.close(pstmt);
      }
      
      return result;
   }
   
      //댓글테이블에서 해당 댓글에 대한 좋아요 +1 진행
      public int updateCmtLike(Connection conn, String commentId, int value) {
         PreparedStatement pstmt = null;
         int updCmtLike = 0;
         String query = "";
         if(value == 1) {
            query = "update tbl_comment set comment_like = comment_like +1 where comment_id = ?";
         }else {
            query = "update tbl_comment set comment_like = comment_like -1 where comment_id = ?";
         }
         
         try {
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, commentId);
            System.out.println(query);
            updCmtLike = pstmt.executeUpdate();
         } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         } finally {
            JDBCTemplate.close(pstmt);   
         }
         return updCmtLike;
      }
      
    //댓글테이블 싫어요 +1
      public int updateCmtDislike(Connection conn, String commentId, int value) {
         PreparedStatement pstmt = null;
         int updCmtDislike = 0;
         String query = "";
         if(value == 1) {
            query = "update tbl_comment set comment_dislike = comment_dislike +1 where comment_id = ?";
         }else {
            query = "update tbl_comment set comment_dislike = comment_dislike -1 where comment_id = ?";
         }
         
         
         try {
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, commentId);
            System.out.println(query);
            updCmtDislike = pstmt.executeUpdate();
         } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         } finally {
            JDBCTemplate.close(pstmt);   
         }
         return updCmtDislike;
      }


   public int selectLoginUserPostLike(Connection conn, String userNo, String postNo) {
      PreparedStatement pstmt = null;
      ResultSet rset = null;
      int result = 0;
      String query = "select * from tbl_post_like where user_no = ? and post_no = ?";
      
      try {
         pstmt = conn.prepareStatement(query);
         pstmt.setString(1, userNo);
         pstmt.setString(2, postNo);
         
         rset = pstmt.executeQuery();
         
         if(rset.next()) {
            result = 1;
         }
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }finally{
         JDBCTemplate.close(rset);
         JDBCTemplate.close(pstmt);
      }
      return result;
   }


   public int deletePostLike(Connection conn, String userNo, String postNo) {
      PreparedStatement pstmt = null;
      int result = 0;
      String query = "delete from tbl_post_like where user_no = ? and post_no = ?";
      
      try {
         pstmt = conn.prepareStatement(query);
         pstmt.setString(1, userNo);
         pstmt.setString(2, postNo);
         
         result = pstmt.executeUpdate();
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }finally {
         JDBCTemplate.close(pstmt);
      }
      
      return result;
   }


   public int insertPostLike(Connection conn, String userNo, String postNo) {
      PreparedStatement pstmt = null;
      int result = 0;
      String query = "insert into tbl_post_like values(?,?)";
      
      
      try {
         pstmt = conn.prepareStatement(query);
         pstmt.setString(1, userNo);
         pstmt.setString(2, postNo);
         
         result = pstmt.executeUpdate();
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }finally {
         JDBCTemplate.close(pstmt);
      }
      
      return result;
   }


   public int selectPostLikeCount(Connection conn, String postNo) {
      PreparedStatement pstmt = null;
      ResultSet rset = null;
      int count = 0;
      String query = "select count(*) as cnt from tbl_post_like where post_no = ?";
      
      try {
         pstmt = conn.prepareStatement(query);
         pstmt.setString(1, postNo);
         
         rset = pstmt.executeQuery();
         
         if(rset.next()) {
            count = rset.getInt("cnt");
         }
      } catch (SQLException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }finally{
         JDBCTemplate.close(rset);
         JDBCTemplate.close(pstmt);
         System.out.println("likeCount" + count);
      }
      
      return count;
   }


   public ArrayList<Post> selectPostReadList(Connection conn, String postTypeCd, int start, int end) {
      PreparedStatement pstmt = null;
      ResultSet rset = null;
      ArrayList<Post> list = new ArrayList<Post>();
      String query = "select * from (select rownum rnum, a.* from (select rownum, a.* from(select a.* from tbl_post a where post_type_id = ? order by read_count desc) a ) a) where rnum between ? and ?";
      
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


   public ArrayList<Post> selectPostLikeList(Connection conn, String postTypeCd, int start, int end) {
      PreparedStatement pstmt = null;
      ResultSet rset = null;
      ArrayList<Post> list = new ArrayList<Post>();
      String query = "select * from (select rownum rnum, a.* from (select rownum, a.* from(select a.* from tbl_post a where post_type_id = ? order by (select count(*) from tbl_post_like where post_no = a.post_no) desc) a ) a) a where rnum between ? and ?";
      
      try {
         System.out.println("postType : " + postTypeCd);
         System.out.println("start : " + start);
         System.out.println("end : " + end);
         
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

}
