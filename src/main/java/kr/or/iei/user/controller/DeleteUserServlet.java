package kr.or.iei.user.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.iei.common.JDBCTemplate;
import kr.or.iei.user.model.service.UserService;

/**
 * Servlet implementation class DeleteUserServlet
 */
@WebServlet("/user/delUser")
public class DeleteUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userNo = request.getParameter("userNo");
		
		UserService service = new UserService();
		int result = service.deleteUser(userNo);
		
		if(result > 0) {
			HttpSession session = request.getSession(false);
			
			if(session != null) {
				session.invalidate();
			}
			
			request.setAttribute("title", "알림");
			request.setAttribute("msg", "회원 탈퇴가 완료되었습니다");
			request.setAttribute("icon", "success");
			request.setAttribute("loc", "/");		
		}else {
			request.setAttribute("title", "알림");
			request.setAttribute("msg", "회원 탈퇴 중 오류가 발생했습니다");
			request.setAttribute("icon", "error");
			request.setAttribute("loc", "javascript:self.close()");
		}
		request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
