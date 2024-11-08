package kr.or.iei.user.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import kr.or.iei.user.model.service.UserService;
import kr.or.iei.user.model.vo.User;
import kr.or.iei.user.model.vo.UserSite;

/**
 * Servlet implementation class pwChgServlet
 */
@WebServlet("/user/pwChg")
public class pwChgServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public pwChgServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userNo = request.getParameter("userNo");
		String userPw = request.getParameter("userPw");
		String newUserPw = request.getParameter("newUserPw");
		
		HttpSession session = request.getSession(false);
		
		RequestDispatcher view = request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp");
		
		if(session != null) {
			UserSite loginUser = (UserSite)session.getAttribute("loginUser");
			
			if(!BCrypt.checkpw(userPw, loginUser.getUserPw())) {
				request.setAttribute("title", "알림");
				request.setAttribute("text", "기존 비밀번호가 일치하지 않습니다");
				request.setAttribute("icon", "error");
				
				view.forward(request, response);
				return;
			}
			
			UserService service = new UserService();
			int result = service.userPwChg(userNo, newUserPw);
			
			if(result > 0) {
				request.setAttribute("title", "알림");
				request.setAttribute("text", "비밀번호 변경이 완료되었습니다. 다시 로그인하세요");
				request.setAttribute("icon", "success");
				request.setAttribute("callback", "self.close(); window.opener.location.href=\"/user/mypage\";");				
				
				session.invalidate();
			}else {
				request.setAttribute("title", "알림");
				request.setAttribute("text", "비밀번호 변경 중 오류가 발생하였습니다.");
				request.setAttribute("icon", "error");
				request.setAttribute("callback", "self.close()");
			}
			view.forward(request, response);
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
