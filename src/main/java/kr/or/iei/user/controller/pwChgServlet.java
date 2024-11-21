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
		String userPwChk = request.getParameter("userPwChk");
		String newUserPw = request.getParameter("newUserPw");
		String newUserPwChk = request.getParameter("newUserPwChk");
		
		//기존 비밀번호와 입력한 비밀번호가 일치하지 않을때
		if(!BCrypt.checkpw(userPwChk, userPw)) {
			response.getWriter().print(1);
			return;
		}else if(!newUserPw.equals(newUserPwChk)) {
			//새로운 비밀번호와 새로운 비밀번호 체크가 일치하지 않을 때
			response.getWriter().print(2);
			return;
		}else {			
		
			HttpSession session = request.getSession(false);
			UserService service = new UserService();
			int result = service.userPwChg(userNo, newUserPw);
			
			//비밀번호 변경 성공 시
			if(result > 0) {			
				response.getWriter().print(0);
				session.invalidate();
				return;
			}else {
				//비밀번호 변경 중 오류 발생 시
				response.getWriter().print(3);
				return;
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
