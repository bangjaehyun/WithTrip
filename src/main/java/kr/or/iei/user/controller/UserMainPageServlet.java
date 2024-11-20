package kr.or.iei.user.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.iei.comment.vo.Comment;
import kr.or.iei.common.model.vo.PageData;
import kr.or.iei.common.vo.Pagination;
import kr.or.iei.post.model.vo.Post;
import kr.or.iei.user.model.service.UserService;

/**
 * Servlet implementation class AdminMainPageFrm
 */
@WebServlet("/user/userPage")
public class UserMainPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserMainPageServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		int page = Integer.parseInt(request.getParameter("page"));// post or comment / if문으로 1 또는 0일시 게시글/댓글 리스트 반환
		String userNo = request.getParameter("userNo");		
		String title = null;
		
		//서비스 호출
		UserService service = new UserService();
		if(page==1) {
			title = "작성";
		}else if(page==3) {
			title = "좋아요";
		}
		
		Gson gson = new Gson();
		ArrayList<Post> pList = null;
		ArrayList<Comment> cList = null;
		
		
		
		if(page == 1) {
			
			pList = service.selectIndexPostList();
			String jsonStr = gson.toJson(pList);
			
			request.setAttribute("title", title);
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json");
			response.getWriter().print(jsonStr);
			request.getRequestDispatcher("/WEB-INF/views/user/userPage.jsp").forward(request, response);
		}else if(page == 2){
			cList =  service.selectIndexCommentList();
			String jsonStr = gson.toJson(cList);
			
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json");
			response.getWriter().print(jsonStr);
			request.getRequestDispatcher("/WEB-INF/views/user/userPage.jsp").forward(request, response);
		}else if(page == 3){
			pList =  service.selectIndexLikedList(userNo);
			String jsonStr = gson.toJson(cList);
			
			request.setAttribute("title", title);
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json");
			response.getWriter().print(jsonStr);
			request.getRequestDispatcher("/WEB-INF/views/user/userPage.jsp").forward(request, response);
		}else if(page < 1){
			request.setAttribute("title", "알림");
			request.setAttribute("msg", "잘못된 접근 방식입니다.");
			request.setAttribute("icon", "error");
			request.setAttribute("loc", "/user/mypageFrm");
			return;
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
