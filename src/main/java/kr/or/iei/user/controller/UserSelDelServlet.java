package kr.or.iei.user.controller;

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
@WebServlet("/user/userSelDel")
public class UserSelDelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserSelDelServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//체크박스 선택된 게시글 삭제 메소드
		int pOrC = Integer.parseInt(request.getParameter("pOrC"));
		String idArr = request.getParameter("idArr");
		AdminService service = new AdminService();
		int result = 0;
		if(pOrC > 0) {
			result = service.allPostSelDel(idArr);
			
		}else {
			result = service.allCmtSelDel(idArr);
		}
		response.getWriter().print(result);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
