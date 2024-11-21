package kr.or.iei.user.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import kr.or.iei.common.JDBCTemplate;
import kr.or.iei.user.model.service.UserService;
import kr.or.iei.user.model.vo.UserSite;

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
		String pwChk = request.getParameter("pwChk");
		System.out.println(userNo);
		System.out.println(pwChk);
		HttpSession session = request.getSession();		
		
		if(session != null) {
			UserSite loginUser = (UserSite)session.getAttribute("loginUser");
			
			//비크립트로 비교한 pw값이 true
		if(BCrypt.checkpw(pwChk, loginUser.getUserPw()) == true) {
			UserService service = new UserService(true);
			int result = service.deleteUser(userNo);
			
			System.out.println(result);
				if(result > 0) {
					session = request.getSession(false);
					
					if(session != null) {
						session.invalidate();
					}
					response.getWriter().print("0");
				}else {
					response.getWriter().print("1");
				}
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
