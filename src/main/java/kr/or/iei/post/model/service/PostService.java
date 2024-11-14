package kr.or.iei.post.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import kr.or.iei.common.JDBCTemplate;
import kr.or.iei.post.model.dao.PostDao;
import kr.or.iei.post.model.vo.Post;
import kr.or.iei.post.model.vo.PostComment;
import kr.or.iei.post.model.vo.PostFile;
import kr.or.iei.post.model.vo.PostPageData;
import kr.or.iei.spot.model.vo.Spot;
import kr.or.iei.user.model.vo.User;

public class PostService {
	
	private PostDao dao;
	
	public PostService() {
		dao = new PostDao();
	}

	//공지사항 리스트 조회
	public PostPageData selectPostList(String postTypeCd, int reqPage, String postTypeNm) {
		Connection conn = JDBCTemplate.getConnection();
		
		//한 페이지에서 보여줄 게시글의 갯수
		int viewPostCnt = 10;
		
		int end = reqPage * viewPostCnt;
		int start = end - viewPostCnt + 1;
		
		ArrayList<Post> list = dao.selectPostList(conn, postTypeCd, start, end);
		
		for(Post post : list) {
			User user = dao.selectUser(conn,post.getUserNo());
			post.setUser(user);
		}
		
		//전체 게시글의 갯수
		int totCnt = dao.selectPostCount(conn, postTypeCd);
		
		//전체 페이지의 갯수
		int totPage = 0;
		
		if(totCnt % viewPostCnt > 0) {
			totPage = totCnt / viewPostCnt + 1;
		} else {
			totPage = totCnt / viewPostCnt;
		}
		
		
		//페이지 하단에 보여줄 페이지 네비게이션 사이즈
		int pageNaviSize = 5;
		
		//페이지 시작번호 연산식
		int pageNo = ((reqPage - 1) / pageNaviSize) * pageNaviSize + 1;	
		
		
		//페이지 네비게이션 HTML 태그 생성
		String pageNavi = "<ul class = 'pagination circle-style'>";
		
		//이전버튼 생성
		if(pageNo != 1) {
			//6,7,8,9,10 or 11,12,13,14,15 or 16,17,18,19,20 ................
			pageNavi += "<li>";
			pageNavi += "<a class = 'page-item' href='/post/list?reqPage=" + (pageNo - 1) + "&postTypeCd=" + postTypeCd + "&postTypeNm=" + postTypeNm+"'>";
			pageNavi += "<span class='material-icons'>chevron_left</span></a>";
			pageNavi += "</li>";
		}
		
		//페이지 네비게이션 사이즈만큼 반복하며, 태그 생성
		for( int i=0; i<pageNaviSize; i++) {
			pageNavi += "<li>";
			
			//선택한 페이지와, 선택하지 않은 페이지를 시각적으로 다르게 표현
			if(reqPage == pageNo) {
				pageNavi += "<a class='page-item active-page' href='/post/list?reqPage="+pageNo+"&postTypeCd="+postTypeCd+"&postTypeNm="+postTypeNm+"'>";
			} else {
				pageNavi += "<a class='page-item' href='/post/list?reqPage="+pageNo+"&postTypeCd="+postTypeCd+"&postTypeNm="+postTypeNm+"'>";
			}
			pageNavi += pageNo + "</a></li>";
			pageNo++;
			
			if(pageNo > totPage) {
				break;
			}
		}
		
		//시작번호 <= 전체 페이지 갯수
		if(pageNo <= totPage) {
			//6,7,8,9,10 or 11,12,13,14,15 or 16,17,18,19,20 ................
			pageNavi += "<li>";
			pageNavi += "<a class = 'page-item' href='/post/list?reqPage=" + pageNo + "&postTypeCd=" + postTypeCd + "&postTypeNm=" + postTypeNm+"'>";
			pageNavi += "<span class='material-icons'>chevron_right</span></a>";
			pageNavi += "</li>";
		}
		
		pageNavi += "</ul>";
		
		
		PostPageData pd = new PostPageData();
		pd.setList(list);
		pd.setPageNavi(pageNavi);
		
		JDBCTemplate.close(conn);		
		return pd;
	}

	//게시글 상세 보기
	public Post selectOnePost(String postNo) {
		Connection conn = JDBCTemplate.getConnection();
		
		Post p = dao.selectOnePost(conn, postNo);
		
		User user = dao.selectUser(conn, p.getUserNo());
		p.setUser(user);
		
		JDBCTemplate.close(conn); 
		return p;
	}
	
	
	//게시글 - 조회수 +1 처리 없이 하나 상세보기
	public Post getOnePost (String postNo) {
		Connection conn = JDBCTemplate.getConnection();
		Post p = dao.selectOnePost(conn, postNo);
		if( p != null) {
			ArrayList<PostFile> fileList = dao.selectPostFileList(conn, postNo);
			p.setFileList(fileList);
		}
		
		JDBCTemplate.close(conn);
		return p;
	}
	

	//게시글 상세보기 + 댓글
	///다양한 서블릿에서 상세보기 메소드를 호출하고 있는데, 댓글확인이 항상 있는 것이 아님 -> commentChk는 있을수도, 없을수도 있음  -> 댓글을 작성을 하고 요청하는 경우가 아니라면 commentChk 의 값은 null
	public Post selectOneNotice(String postNo, String commentChk) {
		Connection conn = JDBCTemplate.getConnection();
		
		Post p = dao.selectOnePost (conn, postNo);
		//System.out.println("1" +n);
		
		//조회해온 다음에 조회수 +1 처리
		if(p != null) {
			int result = 0;
			 
			//commentChk == null 인 것은, 댓글을 작성하고 상세보기 이동하는 경우를 제외한 모든 요청
			
			///일반적으로 상세보기하는 경우에는 result == 0
			if(commentChk == null) {
				result = dao.updateReadCount(conn, postNo);				
			}
				
			
			//게시글 파일정보 불러오기
			//commentChk != null 인 것은 댓글을 작성하고 상세보기 이동하는 경우에도, 파일 정보를 select 할 수 있도록
			if(result > 0 || commentChk != null) {
				JDBCTemplate.commit(conn);
				
				//파일 리스트, 댓글리스트 모두 1개의 게시글에 종속적인 데이터이므로, 별도의 클래스를 생성하지 않고(NoticePageData.java를 만들었던것 처럼이 아니라), Notice 클래스에 변수로 추가
				ArrayList<PostFile> fileList = dao.selectPostFileList(conn, postNo);
				p.setFileList(fileList);
				
				///해당 게시글에 대한 댓글정보도 읽어와야 함
				ArrayList<PostComment> commentList = dao.selectCommentList (conn, postNo);
				p.setCommentList(commentList);
				
			} else {
				JDBCTemplate.rollback(conn);
			}
		}
		
		JDBCTemplate.close(conn);
		
		return p;
	}
	
	//게시글 종류별 리스트 조회 : 고객센터 메인페이지에서 사용
	public ArrayList<Post> selectIndexPostList() {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Post> list = dao.selectIndexPostList(conn);
		JDBCTemplate.close(conn);
		return list;
	}

	//게시글 등록
	public int insertPost(Post post, ArrayList<PostFile> fileList, ArrayList<Spot> spotList) {
		Connection conn = JDBCTemplate.getConnection();
		
		String postNo = dao.selectPostNo(conn);
		post.setPostNo(postNo);
		int result = dao.insertPost(conn,post);
		
		if(result > 0) {
			boolean fileChk = true;
			for (PostFile file : fileList) {
				file.setPostNo(postNo);
				result = dao.insertPostFile(conn, file);
				
				if(result < 1) {
					JDBCTemplate.rollback(conn);
					fileChk = false;
					break;
				}
			}
			
			//commit 시점
            if(fileChk) {
                boolean soptChk = true;
                for(int i =0; i < spotList.size(); i++) {
                    result = dao.insertPostSpot(conn, spotList.get(i));
                    if(result < 1) {
                        JDBCTemplate.rollback(conn);
                        soptChk = false;
                        break;
                    }
                }
                
                if(soptChk) {
                    JDBCTemplate.commit(conn);
                }
			}
		}else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		
		return result;
	}

	//댓글 작성(등록)
	public int insertComment(PostComment comment) {
		Connection conn = JDBCTemplate.getConnection();
		int result = dao.insertComment(conn, comment);
		
		System.out.println("postService - comment 1 : " + comment);
		
		if(result > 0 ) {
			//댓글 작성 후 댓글관리 테이블에 넣어주기
			result = dao.insertCmtManagement(conn, comment);
			
			System.out.println("postService - comment 2 : " + comment);
			
			if(result > 0) {
				JDBCTemplate.commit(conn);
			} else {
				JDBCTemplate.rollback(conn);
			}			
		} 
		JDBCTemplate.close(conn);
		return result;
	}
	
	//댓글 삭제
	public int deleteComment(String commentNo) {
		Connection conn = JDBCTemplate.getConnection();
		int result = dao.deleteComment(conn, commentNo);
		
		if(result > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}

	//댓글 수정
	public int updateComment(PostComment comment) {
		Connection conn = JDBCTemplate.getConnection();
		int result = dao.updateComment(conn, comment);
		
		if(result > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}

}
