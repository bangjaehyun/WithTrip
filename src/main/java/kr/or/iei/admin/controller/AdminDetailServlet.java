package kr.or.iei.admin.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kr.or.iei.admin.service.AdminService;
import kr.or.iei.comment.vo.Comment;
import kr.or.iei.common.model.vo.PageData;
import kr.or.iei.common.vo.Pagination;
import kr.or.iei.post.model.service.PostService;
import kr.or.iei.post.model.vo.Post;
import kr.or.iei.user.model.vo.User;

/**
 * Servlet implementation class AdminDetail
 */
@WebServlet("/admin/adminDetail")
public class AdminDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminDetailServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String postNo = request.getParameter("postNo");
		String commentId = request.getParameter("commentId");
		String userNo = request.getParameter("userNo");//userNo?
		System.out.println("userNo : " + userNo);
		String commentChk = request.getParameter("commentChk");//chk
		String pstTypeName = request.getParameter("webName");
		AdminService adService = new AdminService();
		
		HttpSession session = request.getSession(false);
		User loginUser = (User)session.getAttribute("loginUser");
		
		Comment commentContent = adService.selectComment(userNo, commentId);
		
		// 3. 로직
		PostService service = new PostService();
		Post post = service.selectModifyPost(postNo, commentChk);
		System.out.println("post : "+post);
		if (post != null) {
			Gson gson = new Gson();
			String spotList = gson.toJson(post.getSpotList());
			String fileList = gson.toJson(post.getFileList());
			String tagList = gson.toJson(post.getTagList());
			request.setAttribute("post", post);
			request.setAttribute("loginUser", loginUser);
			request.setAttribute("spotList", spotList);
			request.setAttribute("fileList", fileList);
			request.setAttribute("tagList", tagList);
			request.setAttribute("comment", commentContent);
			request.getRequestDispatcher("/WEB-INF/views/admin/adminDetail.jsp").forward(request, response);
		}

		// 3. 로직

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
