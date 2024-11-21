package kr.or.iei.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.iei.admin.service.AdminService;

/**
 * Servlet implementation class PstAllSelDelServlet
 */
@WebServlet("/admin/adminSelDel")
public class AdminPostSelDelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminPostSelDelServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 체크박스 선택된 게시글 삭제 메소드
		int pOrC = Integer.parseInt(request.getParameter("pOrC"));
		System.out.println(pOrC);
		String idArr = request.getParameter("idArr");
		System.out.println("idArr : " + idArr);
		AdminService service = new AdminService();

		int result = 0;

		if (pOrC == 1) {
			result = service.allPostSelDel(idArr);
		} else if (pOrC == 0) {
			result = service.allCmtSelDel(idArr);
		} else if (pOrC == 2) {
			result = service.allUserSelDel(idArr);
		}

		System.out.println("result : " + result);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		response.getWriter().print(result);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
