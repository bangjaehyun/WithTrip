package kr.or.iei.user.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.iei.comment.vo.Comment;
import kr.or.iei.common.model.vo.PageData;
import kr.or.iei.common.vo.Pagination;
import kr.or.iei.post.model.vo.Post;
import kr.or.iei.user.model.service.UserService;
import kr.or.iei.user.model.vo.User;

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

		HttpSession session = request.getSession(false);
		User loginUser = (User) session.getAttribute("loginUser");
		
		System.out.println(loginUser);
		
		String mapAddr = "/user/userPageFrm";
		int pOrC = Integer.parseInt(request.getParameter("pOrC"));// post or comment
		int pg = Integer.parseInt(request.getParameter("page"));// post or comment
		String page = request.getParameter("page");
		int reqPage = Integer.parseInt(request.getParameter("reqPage"));
		int pageSize = Integer.parseInt(request.getParameter("pageSize"));
		String userNo = loginUser.getUserNo();

		String postTypeId = null;
		String postTypeName = null;

		UserService service = new UserService();
		Pagination pageInfo = null;
		PageData pd = new PageData();
		
		if (session == null) {
			request.setAttribute("title", "알림");
			request.setAttribute("msg", "로그인을 먼저 해 주십시오");
			request.setAttribute("icon", "error");
			request.setAttribute("loc", "/");
			
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
		}else {
		request.setAttribute("page", page);
		request.setAttribute("pOrC", pOrC);
		request.setAttribute("loginUser", loginUser);

		if (pg == 1) {

			postTypeId = request.getParameter("postTypeId");
			postTypeName = request.getParameter("postTypeName");
			ArrayList<Post> pgList = service.selectPostList(userNo, postTypeId, reqPage, pageSize);
			pageInfo = service.pagiNationPost(mapAddr, postTypeId, reqPage, pageSize, pgList, pOrC, userNo);

			pd = service.pageListPost(pageInfo, page);

			request.setAttribute("pOrC", pOrC);
			request.setAttribute("postTypeId", postTypeId);
			request.setAttribute("postTypeName", postTypeName);
			request.setAttribute("title", "내가 작성한 게시글");
			request.setAttribute("pgList", pd.getList());
			request.setAttribute("pageNavi", pd.getPageNavi());

		}
		if (pg == 2) {
			ArrayList<Comment> pgList = service.selectCommentList(userNo, reqPage, pageSize);
			System.out.println(pgList);
			pageInfo = service.pagiNationCmt(mapAddr, reqPage, pageSize, pgList, pOrC, userNo);
			pd = service.pageListCmt(pageInfo, page);
			request.setAttribute("pOrC", pOrC);
			request.setAttribute("title", "내가 작성한 댓글");
			request.setAttribute("pgList", pd.getList());
			System.out.println(pd.getList());
			System.out.println(pd.getPageNavi());
			request.setAttribute("pageNavi", pd.getPageNavi());

		}
		if (pg == 3) {
			postTypeId = request.getParameter("postTypeId");
			postTypeName = request.getParameter("postTypeName");
			ArrayList<Post> pgList = service.selectLikedPostList(userNo, postTypeId, reqPage, pageSize);
			pageInfo = service.pagiNationPost(mapAddr, postTypeId, reqPage, pageSize, pgList, pOrC, userNo);
			System.out.println(postTypeName);
			pd = service.pageListPost(pageInfo, page);

			request.setAttribute("pOrC", pOrC);
			request.setAttribute("postTypeId", postTypeId);
			request.setAttribute("postTypeName", postTypeName);
			request.setAttribute("title", "내가 좋아요 한 게시글");
			request.setAttribute("pgList", pd.getList());
			request.setAttribute("pageNavi", pd.getPageNavi());

		}
		request.getRequestDispatcher("/WEB-INF/views/user/userPage.jsp").forward(request, response);
		}
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
