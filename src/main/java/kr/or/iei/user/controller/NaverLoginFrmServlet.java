package kr.or.iei.user.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.iei.user.model.service.NaverLoginService;
import kr.or.iei.user.model.vo.UserNaver;

/**
 * Servlet implementation class LoginFrmServlet
 */
@WebServlet("/user/naverLoginFrm")
public class NaverLoginFrmServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NaverLoginFrmServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String code = request.getParameter("code");
	    String state = request.getParameter("state");
	    
		System.out.println(code);
		System.out.println(state);
		NaverLoginService service = new NaverLoginService();
		UserNaver n = service.createToken(code, state);
		    
		//일단 네이버 로그인하면 세션에 값 넣어줌
		if(n != null) {
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", n);
			//request.getRequestDispatcher("/").forward(request, response);
		
		
			//세션에서 아이디가 널값이면 추가 정보 입력 페이지로 널값이 아니면 바로 홈페이지로
				request.getRequestDispatcher("/").forward(request, response);
		}else {
			request.getRequestDispatcher("/WEB-INF/views/user/addNaverInfo.jsp").forward(request, response);
		}
		
		RequestDispatcher view = request.getRequestDispatcher("/WEB-INF/views/user/login.jsp");
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
