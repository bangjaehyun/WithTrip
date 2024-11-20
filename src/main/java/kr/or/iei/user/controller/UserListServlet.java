package kr.or.iei.user.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.iei.admin.service.AdminService;
import kr.or.iei.comment.vo.Comment;
import kr.or.iei.common.model.vo.PageData;
import kr.or.iei.common.vo.Pagination;
import kr.or.iei.post.model.vo.Post;

/**
 * Servlet implementation class AdminListServlet
 */
@WebServlet("/user/userList")
public class UserListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserListServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String mapAddr = "/admin/adminList";
		int pOrC = Integer.parseInt(request.getParameter("pOrC"));// post or comment
		int reqPage = Integer.parseInt(request.getParameter("reqPage"));
		int pageSize = Integer.parseInt(request.getParameter("pageSize"));
		int srchMtd = Integer.parseInt(request.getParameter("srchMtd"));
		
		String inptVal = request.getParameter("inptVal");
		
		String postTypeId = null;
		String postTypeName = null;
		String webName = null;

		AdminService service = new AdminService();
		Pagination pageInfo = null;
		PageData pd = new PageData();
		Gson gson = new Gson();
		
		
		
		if (pOrC > 0) {
			postTypeId = request.getParameter("postTypeId");
			postTypeName = request.getParameter("postTypeName");
			if(srchMtd == 0 ) {
				ArrayList<Post> pgList = service.selectPostList(postTypeId, reqPage, pageSize);
				System.out.println("pgSize : " + pageInfo.getPageSize());

				pd = service.pageListPost(pageInfo);
				webName = postTypeName;
			}
			else if(srchMtd == 1){
				ArrayList<Post> pgList = service.selectSrchPostList(postTypeId, reqPage, pageSize,srchMtd, inptVal);
				System.out.println("pgSize : " + pageInfo.getPageSize());

				pd = service.pageListPost(pageInfo);
				webName = postTypeName;
			}else if(srchMtd == 2){
				ArrayList<Post> pgList = service.selectSrchPostList(postTypeId, reqPage, pageSize,srchMtd, inptVal);
				System.out.println("pgSize : " + pageInfo.getPageSize());

				pd = service.pageListPost(pageInfo);
				webName = postTypeName;
			}
			

		} else {
			webName = request.getParameter("postTypeName");
			ArrayList<Comment> pgList = service.selectCommentList(reqPage, pageSize);
			//pageInfo = service.pagiNationCmt(mapAddr, reqPage, pageSize, pgList);
			pd = service.pageListCmt(pageInfo);
//			
		}
		String jsonStr = gson.toJson(pd.getList());
//		
		if (pOrC > 0) {

			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json"); // 응답 데이터 형식 지정
			response.getWriter().print(jsonStr);
			System.out.println(jsonStr);
		} else {

			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json"); // 응답 데이터 형식 지정
			response.getWriter().print(jsonStr);
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
