package kr.or.iei.user.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.iei.user.model.service.GoogleLoginService;
import kr.or.iei.user.model.vo.GoogleApiSave;
import kr.or.iei.user.model.vo.UserGoogle;
import kr.or.iei.user.model.vo.UserNaver;

/**
 * Servlet implementation class LoginFrmServlet
 */
@WebServlet("/user/googleLoginFrm")
public class GoogleLoginFrmServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GoogleLoginFrmServlet() {
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
	    
		GoogleLoginService service = new GoogleLoginService();
		UserGoogle g = service.createToken(code, state);
		    
		if(g != null) {
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", g);
			request.getRequestDispatcher("/").forward(request, response);
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
