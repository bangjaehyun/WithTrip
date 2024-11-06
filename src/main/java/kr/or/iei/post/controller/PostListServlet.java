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
import kr.or.iei.post.model.vo.PostType;

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
		String postTypeCd = request.getParameter("postTypeCd"); //게시글 종류 코드
		String postTypeNm = request.getParameter("postTypeNm");	//게시글 종류 이름
		
		int typeName = Integer.parseInt(postTypeNm)-1; 

		int reqPage = request.getParameter("reqPage") == null ? 1 : Integer.parseInt(request.getParameter("reqPage"));	//사용자 요청 페이지 번호
		
		//3. 로직 - 공지사항 리스트 불러오기
		PostService service = new PostService();

		PostPageData pd = service.selectPostList(postTypeCd, reqPage, postTypeNm);

		//4. 결과처리
		request.setAttribute("postList", pd.getList());
		request.setAttribute("pageNavi", pd.getPageNavi());
		request.setAttribute("postTypeNm", PostType.type[typeName]);
		request.setAttribute("postTypeid", postTypeCd);

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
