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
 * Servlet implementation class NaverAddInfoServlet
 */
@WebServlet("/user/naverAddInfo")
public class NaverAddInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NaverAddInfoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userName = request.getParameter("userName");
		String userId = request.getParameter("userId");
		String userEmail = request.getParameter("userEmail");
		String userPhone = request.getParameter("userPhone");
		String userNickname = request.getParameter("userNickname");
		int userType = 3;
		
		UserNaver nLogin = new UserNaver();
		nLogin.setUserId(userId);
		nLogin.setUserName(userName);
		nLogin.setUserEmail(userEmail);
		nLogin.setUserPhone(userPhone);
		nLogin.setUserNickname(userNickname);
		nLogin.setUserType(userType);
		
		NaverLoginService service = new NaverLoginService();
		int result = service.addNaverInfo(nLogin);
		
		if(result > 0) {
			request.setAttribute("title", "알림");
			request.setAttribute("msg", "추가정보 입력이 완료되었습니다");
			request.setAttribute("icon", "success");
			request.setAttribute("loc", "/");
			
			HttpSession session = request.getSession();
			session.setAttribute("naverLogin", nLogin);
			
		}else {
			request.setAttribute("title", "알림");
			request.setAttribute("msg", "추가정보 입력중 오류가 발생했습니다");
			request.setAttribute("icon", "error");
			request.setAttribute("loc", "/user/naverLoginFrm");
		}
		request.getRequestDispatcher("/WEB-INf/views/common/msg.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
