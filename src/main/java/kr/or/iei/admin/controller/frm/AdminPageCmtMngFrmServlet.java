package kr.or.iei.admin.controller.frm;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.iei.admin.service.AdminService;
import kr.or.iei.comment.vo.Comment;

/**
 * Servlet implementation class AdminPageCmtMngServlet
 */
@WebServlet("/admin/adminCmtFrm")
public class AdminPageCmtMngFrmServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminPageCmtMngFrmServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		
		
		// 서비스 함수 호출
		AdminService adService = new AdminService();
		
		// 전체 댓글 조회를 위한 commentList ArrayList 생성
		ArrayList<Comment> cmtList = adService.selectAllCommentsList();
		
		// ArrayList 반환
		request.setAttribute("cmtList", cmtList);
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
