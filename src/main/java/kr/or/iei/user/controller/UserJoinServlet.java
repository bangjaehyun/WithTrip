package kr.or.iei.user.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.iei.user.model.service.UserService;

import kr.or.iei.user.model.vo.UserSite;

/**
 * Servlet implementation class UserJoinServlet
 */
@WebServlet("/user/join")
public class UserJoinServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserJoinServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		//2. 값 추출
		String userId = request.getParameter("userId");
		String userPw = request.getParameter("userPw");
		String userName = request.getParameter("userName");
		String userPhone = request.getParameter("userPhone");
		String userEmail = request.getParameter("userEmail");
		String userNickname = request.getParameter("userNickname");
		
		//3. 비즈니스 로직 - 회원가입
		UserSite usersite = new UserSite();
		usersite.setUserId(userId);
		usersite.setUserPw(userPw);
		usersite.setUserName(userName);
		usersite.setUserPhone(userPhone);
		usersite.setUserEmail(userEmail);
		usersite.setUserNickname(userNickname);
		
		UserService service = new UserService();
		int result =service.insertUserSite(usersite);
		
		//4. 결과처리 - 로그인 화면으로 이동
		if(result > 0) {
			//정상적으로 회원가입이 되었을 경우
			request.setAttribute("title", "성공");
			request.setAttribute("msg", "회원가입이 완료되었습니다. 로그인 페이지로 이동합니다.");
			request.setAttribute("icon", "success");
			request.setAttribute("loc", "/user/loginFrm");
		} else {
			request.setAttribute("title", "실패");
			request.setAttribute("msg", "회원가입에 실패하였습니다. 메인페이지로 이동합니다.");
			request.setAttribute("icon", "error");
			request.setAttribute("loc", "/localhost");
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
