package kr.or.iei.user.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.iei.comment.vo.Comment;
import kr.or.iei.common.model.vo.PageData;
import kr.or.iei.common.vo.Pagination;
import kr.or.iei.post.model.vo.Post;
import kr.or.iei.user.model.service.UserService;

/**
 * Servlet implementation class AdminMainPageFrmServlet
 */
@WebServlet("/user/userPageFrm")
public class UserMainPageFrmServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserMainPageFrmServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//		디벨롶 편의상 주석처리		
//		로그인 후 해당 페이지 접속시 세션값==관리자 확인
		/*
		HttpSession session = request.getSession(false);
		if (session != null) {
			User loginUser = (User) session.getAttribute("userNo");

			if (loginUser.getUserType() != 2) {
				request.setAttribute("title", "알림");
				request.setAttribute("msg", "해당 메뉴에 대한 접속 권한이 없습니다");
				request.setAttribute("icon", "error");
				request.setAttribute("loc", "/user/mypage");

				request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
				return;

			}
		}
		*/
		String mapAddr = "/user/userPageFrm";
		int pOrC = Integer.parseInt(request.getParameter("pOrC"));// post or comment
		int page = Integer.parseInt(request.getParameter("page"));// post or comment
		int reqPage = Integer.parseInt(request.getParameter("reqPage"));
		int pageSize = Integer.parseInt(request.getParameter("pageSize"));
		String userNo = request.getParameter("userNo");
		
		request.setAttribute("page", page);
		request.setAttribute("pOrC", pOrC);
		request.setAttribute("title1", "작성");
		request.setAttribute("title2", "좋아요");
		request.setAttribute("userNo", userNo);
		
		String postTypeId = null;
		String postTypeName = null;

		UserService service = new UserService();
		Pagination pageInfo = null;
		PageData pd = new PageData();
		
		if (page == 1) {
			
			postTypeId = request.getParameter("postTypeId");
			postTypeName = request.getParameter("postTypeName");
			ArrayList<Post> pgList = service.selectPostList(userNo, postTypeId, reqPage, pageSize);
			pageInfo = service.pagiNationPost(mapAddr, postTypeId, reqPage, pageSize, pgList, pOrC, userNo);

			pd = service.pageListPost(pageInfo, page);
			
			request.setAttribute("pOrC", pOrC);
			request.setAttribute("postTypeId", postTypeId);
			request.setAttribute("postTypeName", postTypeName);
			request.setAttribute("pgList", pd.getList());
			request.setAttribute("pageNavi", pd.getPageNavi());

		} 
		if(page == 2){
			postTypeName = request.getParameter("postTypeName");
			ArrayList<Comment> pgList = service.selectCommentList(userNo, reqPage, pageSize);
			pageInfo = service.pagiNationCmt(mapAddr, reqPage, pageSize, pgList, pOrC, userNo);
			pd = service.pageListCmt(pageInfo, page);
			System.out.println("asdasd : " +pd.getList());
			request.setAttribute("pOrC", pOrC);
			request.setAttribute("postTypeName", "댓글");
			request.setAttribute("pgList", pd.getList());
			request.setAttribute("pageNavi", pd.getPageNavi());

		}
		if(page == 3){
			postTypeId = request.getParameter("postTypeId");
			postTypeName = request.getParameter("postTypeName");
			ArrayList<Post> pgList = service.selectLikedPostList(userNo, postTypeId, reqPage, pageSize);
			pageInfo = service.pagiNationPost(mapAddr, postTypeId, reqPage, pageSize, pgList, pOrC, userNo);

			pd = service.pageListPost(pageInfo, page);
			
			request.setAttribute("pOrC", pOrC);
			request.setAttribute("postTypeId", postTypeId);
			request.setAttribute("postTypeName", postTypeName);
			request.setAttribute("pgList", pd.getList());
			request.setAttribute("pageNavi", pd.getPageNavi());

		}
		request.getRequestDispatcher("/WEB-INF/views/user/userPage.jsp").forward(request, response);
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
