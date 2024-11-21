package kr.or.iei.admin.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.iei.admin.service.AdminService;
import kr.or.iei.comment.vo.Comment;
import kr.or.iei.post.model.vo.Post;

/**
 * Servlet implementation class AdminMainPageFrm
 */
@WebServlet("/admin/adminMain")
public class AdminMainPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminMainPageServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		
		int pOrC = Integer.parseInt(request.getParameter("pOrC"));// post or comment / if문으로 1 또는 0일시 게시글/댓글 리스트 반환
		int post = Integer.parseInt(request.getParameter("pOrC"));
		int comment = Integer.parseInt(request.getParameter("pOrC"));
		//서비스 호출
		AdminService service = new AdminService();
		
		
		Gson gson = new Gson();
		ArrayList<Post> pList = null;
		ArrayList<Comment> cList = null;
		String jsonStr = null;
		
		if(post == 1) {
			pList = service.selectIndexPostList();
			jsonStr = gson.toJson(pList);
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json");
			response.getWriter().print(jsonStr);
			
		}else if(comment == 0){
			cList =  service.selectIndexCommentList();
			jsonStr = gson.toJson(cList);
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json");
			System.out.println(jsonStr);
			response.getWriter().print(jsonStr);
		}else if(pOrC > 1){
			request.setAttribute("title", "알림");
			request.setAttribute("msg", "잘못된 접근 방식입니다.");
			request.setAttribute("icon", "error");
			request.setAttribute("loc", "/admin/adminPage");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
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
