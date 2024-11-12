package kr.or.iei.user.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.iei.user.model.service.UserService;

/**
 * Servlet implementation class UserSrchInfoIdServlet
 */
@WebServlet("/user/srchInfoId")
public class UserSrchInfoIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserSrchInfoIdServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userEmail = request.getParameter("userEmail");
		
		UserService service = new UserService();
		String userId = service.srchInfoId(userEmail);
		
		if(userId != null) {
			//조회한 아이디 전부 보여주기 , * 마스킹 처리
			
			int idLen = userId.length(); // 조회 아이디길이ㅣ
			
			String first = userId.substring(0,2); // 아이디 앞 두자리
			String last = userId.substring(idLen-2); // 아이디 뒤 두자리
			String marker = "*".repeat(idLen-4); // 아이디 길이-4 제외하고 *로 보여주기
			
			userId = first + marker + last;   //qwer1234 -> qw****34
			
		} else {
			userId = "";
		}
		response.getWriter().print(userId);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
