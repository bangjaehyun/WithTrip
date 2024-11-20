package kr.or.iei.post.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.iei.post.model.service.PostService;
import kr.or.iei.post.model.vo.PostPageData;
import kr.or.iei.post.model.vo.PostType;

/**
 * Servlet implementation class PostOrderSeacrchServlet
 */
@WebServlet("/post/orderSearch")
public class PostOrderSeacrchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PostOrderSeacrchServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 1. 인코딩 - 필터

		// 2. 값 추출 - 게시글 종류 코드와 이름 1.공지사항 / 2.여행정보 / 3.FAQ / 4.Q&A /5.사이트 이용안내
		String postTypeCd = request.getParameter("postTypeCd"); // 게시글 종류 코드
		String postTypeNm = request.getParameter("postTypeNm"); // 게시글 종류 이름
		String searchName = request.getParameter("searchName");
		int typeName = Integer.parseInt(postTypeNm) - 1;
		int reqPage = request.getParameter("reqPage") == null ? 1 : Integer.parseInt(request.getParameter("reqPage")); // 사용자
		System.out.println("1111111111111"+searchName);

		// 3. 로직 - 공지사항 리스트 불러오기
		PostService service = new PostService();
		PostPageData pd = null;
		if(searchName.equals("latest")) {
			System.out.println("111111111111111111");
			 pd = service.selectPostList(postTypeCd, reqPage, postTypeNm);
		}else if(searchName.equals("read")) {
			System.out.println("2222222222222222222222");
			 pd = service.selectPostReadList(postTypeCd, reqPage, postTypeNm);
			 request.setAttribute("searchName", searchName);
		}else if(searchName.equals("like")){
			System.out.println("3333333333333333333333333333");
			 pd = service.selectPostlikeList(postTypeCd, reqPage, postTypeNm);
			 request.setAttribute("searchName", searchName);
		}

		// 4. 결과처리
		request.setAttribute("postList", pd.getList());
		request.setAttribute("pageNavi", pd.getPageNavi());
		request.setAttribute("postTypeNm", PostType.type[typeName]);
		request.setAttribute("postTypeId", postTypeCd);
		request.getRequestDispatcher("/WEB-INF/views/post/postList.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
