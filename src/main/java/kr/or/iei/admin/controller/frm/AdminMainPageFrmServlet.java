package kr.or.iei.admin.controller.frm;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.iei.user.model.vo.User;

/**
 * Servlet implementation class AdminMainPageFrmServlet
 */
@WebServlet("/admin/adminPageFrm")
public class AdminMainPageFrmServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminMainPageFrmServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		/*
		HttpSession session = request.getSession(false);
		if (session != null) {
			User loginUser = (User)session.getAttribute("userNo");
			System.out.println(loginUser.getUserType());
		}
			if (loginUser.getUserType() != 1) {
				request.setAttribute("title", "알림");
				request.setAttribute("msg", "해당 메뉴에 대한 접속 권한이 없습니다");
				request.setAttribute("icon", "error");
				request.setAttribute("loc", "/user/mypage");

				request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
				return;*/

		
		System.out.println("asdasda");
		int pOrC = Integer.parseInt(request.getParameter("pOrC"));// post or comment

		request.setAttribute("pOrC", pOrC);
		request.getRequestDispatcher("/WEB-INF/views/admin/adminMainPage.jsp").forward(request, response);
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
