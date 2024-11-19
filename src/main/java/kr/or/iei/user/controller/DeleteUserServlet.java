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
			
/*			//사이트 회원인 경우 Bcrypt로 기존 비밀번호와 비교해서 일치하지 않으면 return으로 종료
			if(!BCrypt.checkpw(pwChk, loginUser.getUserPw())) {
				request.setAttribute("title", "알림");
				request.setAttribute("text", "기존 비밀번호가 일치하지 않습니다");
				request.setAttribute("icon", "error");
				request.setAttribute("loc", "/user/delUserFrm");

				return;
			}else if(loginUser.getUserType() != 3){
				//네이버 회원이 아닌경우 return 으로 종료
				request.setAttribute("title", "알림");
				request.setAttribute("text", "");
				request.setAttribute("icon", "error");
				request.setAttribute("loc", "/user/delUserFrm");
				
				return;
			}
*/
			//비크립트로 비교한 pw값이 true or 유저타입이 3인경우
		if(BCrypt.checkpw(pwChk, loginUser.getUserPw()) == true || loginUser.getUserType() == 3) {
			UserService service = new UserService();
			int result = service.deleteUser(userNo);
			
			System.out.println(result);
				if(result > 0) {
					session = request.getSession(false);
					
					if(session != null) {
						session.invalidate();
					}
					response.getWriter().print(1);
				}else {
					response.getWriter().print(0);
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
