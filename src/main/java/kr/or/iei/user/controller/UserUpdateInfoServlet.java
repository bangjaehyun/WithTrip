package kr.or.iei.user.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.iei.user.model.service.UserService;
import kr.or.iei.user.model.vo.User;

/**
 * Servlet implementation class UserUpdateInfoServlet
 */
@WebServlet("/user/updateInfo")
public class UserUpdateInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserUpdateInfoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userNo = request.getParameter("userNo");
		String updNickname = request.getParameter("userNickName");
		String updUserPhone = request.getParameter("userPhone");
		
		User updUser = new User();
		updUser.setUserNickname(updNickname);
		updUser.setUserPhone(updUserPhone);
		
		UserService service = new UserService();
		int result = service.updateUserInfo(userNo, updNickname, updUserPhone);
		
		if(result > 0) {
			request.setAttribute("title", "알림");
			request.setAttribute("text", "회원정보 수정이 완료되었습니다");
			request.setAttribute("icon", "success");
			request.setAttribute("loc", "/user/mypage");
			
			//로그인중인 회원 닉네임, 전화번호 변경
			HttpSession session = request.getSession(false);
			User sessionUser = (User) session.getAttribute("loginUser");
			sessionUser.setUserNickname(updNickname);
			sessionUser.setUserPhone(updUserPhone);
		}else {
			request.setAttribute("title", "알림");
			request.setAttribute("text", "회원정보 수정 중 오류가 발생했습니다");
			request.setAttribute("icon", "error");
			request.setAttribute("loc", "/user/mypage");
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
