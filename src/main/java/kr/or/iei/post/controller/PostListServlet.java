package kr.or.iei.post.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.iei.post.model.service.PostService;
import kr.or.iei.post.model.vo.Post;
import kr.or.iei.post.model.vo.PostPageData;

/**
 * Servlet implementation class PostListServlet
 */
@WebServlet("/post/list")
public class PostListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 인코딩 - 필터
		
		//2. 값 추출 - ?
		String postTypeCd = request.getParameter("postTypeCd");
		String postTypeNm = request.getParameter("postTypeNm");	
		
		//System.out.println("postTypeCd : " + postTypeCd);
		//System.out.println("postTypeNm : " + postTypeNm);

		
		/*
		 String postTypeCd = request.getParameter("postTypeCd");	//게시글 종류 코드
		System.out.println(postTypeCd);
		String postTypeNm = request.getParameter("postTypeNm");	//게시글 종류 이름
		System.out.println(postTypeNm);
		 */
		int reqPage = request.getParameter("reqPage") == null ? 1 : Integer.parseInt(request.getParameter("reqPage"));	//사용자 요청 페이지 번호
		
		//3. 로직 - 공지사항 리스트 불러오기
		PostService service = new PostService();
		
		//PostPageData pd = service.selectPostList(postTypeCd, reqPage, postTypeNm);
		//pd = ArrayList<Post> post
		PostPageData pd = service.selectNoticeList(postTypeCd, reqPage, postTypeNm);
//		System.out.println(pd.getPageNavi());
//		System.out.println(pd.getList());
		//4. 결과처리
		request.setAttribute("postList", pd.getList());
		request.setAttribute("pageNavi", pd.getPageNavi());
		request.setAttribute("postTypeNm", postTypeNm);
		request.setAttribute("postTypeid", postTypeCd);
		
		
		//System.out.println("pd : " + pd);
		
		request.getRequestDispatcher("/WEB-INF/views/post/postList.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
