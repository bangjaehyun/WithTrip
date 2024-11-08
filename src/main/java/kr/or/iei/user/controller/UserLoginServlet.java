package kr.or.iei.user.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.iei.user.model.service.UserService;
import kr.or.iei.user.model.vo.User;

/**
 * Servlet implementation class UserLoginServlet
 */
@WebServlet("/user/login")
public class UserLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserLoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 값 추출
		String loginId = request.getParameter("loginId");
		String loginPw = request.getParameter("loginPw");
		
		// 비즈니스 로직 -> 로그인
		UserService service = new UserService();
		User loginUser = service.userLogin(loginId, loginPw);
		
		// 결과 처리
		if(loginUser != null) {
			
		HttpSession session = request.getSession(true);
		session.setAttribute("loginUser", loginUser);
		session.setMaxInactiveInterval(600);
		
		Cookie cookie = new Cookie("saveId",loginId);
		if(request.getParameter("saveId") != null) {
			cookie.setMaxAge(60*60*24*30);
		}else {
			cookie.setMaxAge(0);
		}
		cookie.setPath("/user/loginFrm");
		
		response.addCookie(cookie);
		
		response.sendRedirect("/");
		}else {
			//null일때 == 입력한 아이디 비번 일치하는회원이 없을 때 == 로그인 실패
			request.setAttribute("title", "알림");
			request.setAttribute("msg","아이디 또는 비밀번호를 확인하세요.");
			request.setAttribute("lcon", "error");
			request.setAttribute("loc","/user/loginFrm"); //다시 로그인 페이지로 이동
			
			RequestDispatcher view = request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp");
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
