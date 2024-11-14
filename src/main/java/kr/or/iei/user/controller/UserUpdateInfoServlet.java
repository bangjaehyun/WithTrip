package kr.or.iei.user.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.iei.user.model.service.UserService;
import kr.or.iei.user.model.vo.User;
import kr.or.iei.user.model.vo.UserKakao;
import kr.or.iei.user.model.vo.UserNaver;
import kr.or.iei.user.model.vo.UserSite;

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
		String updNickname = request.getParameter("userNickname");
		String updUserPhone = request.getParameter("userPhone");
		String userType = request.getParameter("userType");
		int type = Integer.parseInt(userType);
		
		System.out.println("userNo: " + userNo);
		System.out.println("userNickName: " + updNickname);
		System.out.println("userPhone: " + updUserPhone);
		System.out.println("userType: " + userType);
		
		UserService service = new UserService();
		int result = service.updateUserInfo(userNo, updNickname, updUserPhone, type);
		
		if(result > 0) {
			HttpSession session = request.getSession(false);
			
			if(type == 3) {
				UserNaver sessionNaver = (UserNaver) session.getAttribute("loginUser");
				sessionNaver.setUserNickname(updNickname);
				sessionNaver.setUserPhone(updUserPhone);
			}else if(type == 4) {
				UserKakao sessionKakao = (UserKakao) session.getAttribute("loginUser");
				sessionKakao.setUserNickname(updNickname);
				sessionKakao.setUserPhone(updUserPhone);
			}else if(type == 5) {
				UserSite sessionSite = (UserSite) session.getAttribute("loginUser");
				sessionSite.setUserNickname(updNickname);
				sessionSite.setUserPhone(updUserPhone);
			}
			
			request.setAttribute("title", "알림");
			request.setAttribute("msg", "회원정보 수정이 완료되었습니다");
			request.setAttribute("icon", "success");
			request.setAttribute("loc", "/user/mypageFrm");
		}else {
			request.setAttribute("title", "알림");
			request.setAttribute("msg", "회원정보 수정 중 오류가 발생했습니다");
			request.setAttribute("icon", "error");
			request.setAttribute("loc", "/user/mypageFrm");
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
