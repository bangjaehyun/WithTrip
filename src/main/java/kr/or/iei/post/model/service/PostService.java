package kr.or.iei.post.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import kr.or.iei.common.JDBCTemplate;
import kr.or.iei.post.model.dao.PostDao;
import kr.or.iei.post.model.vo.Post;
import kr.or.iei.post.model.vo.PostPageData;

public class PostService {
	
	private PostDao dao;
	
	public PostService() {
		dao = new PostDao();
	}

	//공지사항 리스트 조회
	public PostPageData selectNoticeList(String postTypeCd, int reqPage, String postTypeNm) {
		Connection conn = JDBCTemplate.getConnection();
		
		//한 페이지에서 보여줄 게시글의 갯수
		int viewPostCnt = 10;
		
		int end = reqPage * viewPostCnt;
		int start = end - viewPostCnt + 1;
		
		ArrayList<Post> list = dao.selectPostList(conn, postTypeCd, start, end);
		
		
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
		
		JDBCTemplate.close(conn); 
		return p;
	}

}
