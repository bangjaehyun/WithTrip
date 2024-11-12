package kr.or.iei.user.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.iei.common.model.vo.PageData;
import kr.or.iei.user.model.service.UserService;

/**
 * Servlet implementation class AdminPageCmtMngServlet
 */
@WebServlet("/user/myPageMyCmtList")
public class UserMyPageMyCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserMyPageMyCommentServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String mapAddr ="/user/myPageMyCmtList";
		
		int reqPage = Integer.parseInt(request.getParameter("reqPage"));
		String pgSize = request.getParameter("pageSize");
		int pageSize = 0;//페이지 사이즈의 초기값
		if(pgSize == null) {//String pgSize 파라미터가 0이면
			pageSize = 5;//5로
		}else {//null아니면
			pageSize = Integer.parseInt(pgSize); //재정립
		}
		
		// 서비스 함수 호출
//		UserService userService = new UserService();
//		// 전체 댓글 조회를 위한 commentList ArrayList 생성
//		ArrayList<Comment> cmtList = userService.selectAllCommentsList(reqPage, pageSize);
//		PageData pd = new PageData();
//		pd= userService.pageList();
//		// ArrayList 반환
//		request.setAttribute("cmtList", cmtList);
		// 주소로...
		request.getRequestDispatcher("/WEB-INF/views/admin/adminCmtMng.jsp").forward(request, response);
//									  
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
