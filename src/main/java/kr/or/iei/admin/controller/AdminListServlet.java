package kr.or.iei.admin.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kr.or.iei.admin.service.AdminService;
import kr.or.iei.comment.vo.Comment;
import kr.or.iei.common.model.vo.PageData;
import kr.or.iei.common.vo.Pagination;
import kr.or.iei.post.model.vo.Post;

/**
 * Servlet implementation class AdminListServlet
 */
@WebServlet("/admin/adminListFrm")
public class AdminListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminListServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String mapAddr = "/admin/adminListFrm";
		int pOrC = Integer.parseInt(request.getParameter("pOrC"));// post or comment
		int reqPage = Integer.parseInt(request.getParameter("reqPage"));
		int pageSize = Integer.parseInt(request.getParameter("pageSize"));
		System.out.println("pOrC : "+pOrC);
		
		String postTypeId = null;
		String postTypeName = null;

		AdminService service = new AdminService();
		Pagination pageInfo = null;
		PageData pd = new PageData();
//		Gson gson = new Gson();

		if (pOrC == 1) {
			
			postTypeId = request.getParameter("postTypeId");
			postTypeName = request.getParameter("postTypeName");
			ArrayList<Post> pgList = service.selectPostList(postTypeId, reqPage, pageSize);
			pageInfo = service.pagiNationPost(mapAddr, postTypeId, postTypeName, reqPage, pageSize, pgList, pOrC);

			pd = service.pageListPost(pageInfo);
			
			request.setAttribute("pOrC", pOrC);
			request.setAttribute("postTypeId", postTypeId);
			request.setAttribute("postTypeName", postTypeName);
			request.setAttribute("pgList", pd.getList());
			request.setAttribute("pageNavi", pd.getPageNavi());

		} 
		if(pOrC == 0){
			postTypeName = request.getParameter("postTypeName");
			ArrayList<Comment> pgList = service.selectCommentList(reqPage, pageSize);
			pageInfo = service.pagiNationCmt(mapAddr, reqPage, pageSize, pgList, pOrC);
			pd = service.pageListCmt(pageInfo);
			System.out.println("asdasd : " +pd.getList());
			request.setAttribute("pOrC", pOrC);
			request.setAttribute("postTypeName", "댓글");
			request.setAttribute("pgList", pd.getList());
			request.setAttribute("pageNavi", pd.getPageNavi());

		}
		System.out.println(pd.getList());
		request.getRequestDispatcher("/WEB-INF/views/admin/adminListPage.jsp").forward(request, response);

		// String jsonStr = gson.toJson(pd.getList());

//		if (pOrC > 0) {
//			response.setCharacterEncoding("UTF-8");
//			response.setContentType("application/json"); // 응답 데이터 형식 지정
//			response.getWriter().print(jsonStr);
//			System.out.println(jsonStr);
//		} else {

//			response.setCharacterEncoding("UTF-8");
//			response.setContentType("application/json"); // 응답 데이터 형식 지정
//			response.getWriter().print(jsonStr);
//		}
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
