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
		//정보 가져와서 DB에 정보 넣기
		String userName = request.getParameter("userName");
		String userId = request.getParameter("userId");
		String userEmail = request.getParameter("userEmail");
		String userPhone = request.getParameter("userPhone");
		String userNickname = request.getParameter("userNickname");

		HttpSession session = request.getSession();
		
		UserNaver joinNaver = new UserNaver();
		joinNaver.setUserId(userId);
		joinNaver.setUserName(userName);
		joinNaver.setUserEmail(userEmail);
		joinNaver.setUserPhone(userPhone);
		joinNaver.setUserNickname(userNickname);
		
		NaverLoginService service = new NaverLoginService();
		int result = service.addNaverInfo(joinNaver);
		
		//정보 넣기에 성공하면 세션값 초기화 후 email 정보로 다시 세션에 값 넣기
		if(result > 0) {
			UserNaver loginUser = service.naverUserLogin(userEmail);			
			session.setAttribute("loginUser", loginUser);
			session.setMaxInactiveInterval(3600);//1시간 -> 필터에서 페이지 넘어갈 때 마다 값 초기화
			
			//성공시 0 전달
			response.getWriter().print("0");
		}else {
			//실패시 1 전달
			response.getWriter().print("1");
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
