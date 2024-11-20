package kr.or.iei.user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		int pOrC = Integer.parseInt(request.getParameter("pOrC"));// post or comment
		int page = Integer.parseInt(request.getParameter("page"));// post or comment
		
		request.setAttribute("page", page);
		request.setAttribute("pOrC", pOrC);
		request.setAttribute("title1", "작성");
		request.setAttribute("title2", "좋아요");
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
