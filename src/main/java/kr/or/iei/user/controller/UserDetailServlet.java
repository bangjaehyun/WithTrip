package kr.or.iei.user.controller;

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
@WebServlet("/user/userDetailFrm")
public class UserDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserDetailServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int page = Integer.parseInt(request.getParameter("page"));
		String postNo = request.getParameter("postNo");
		String commentId = request.getParameter("commentId");
		
		HttpSession session = request.getSession(false);
		User loginUser = (User)session.getAttribute("loginUser");

		AdminService adService = new AdminService();
		Comment commentContent = adService.selectComment(loginUser.getUserNo(), commentId);

		request.setAttribute("loginUser", loginUser);
		request.setAttribute("comment", commentContent);

		String commentChk = request.getParameter("commentChk");
		
		// 3. 로직
		PostService service = new PostService();
		Post post = service.selectModifyPost(postNo, commentChk);
		
		Gson gson = new Gson();
		String spotList = gson.toJson(post.getSpotList());
		String fileList = gson.toJson(post.getFileList());
		String tagList = gson.toJson(post.getTagList());
		
		
		if(page==1) {
			if (post != null) {
				
				request.setAttribute("page", page);
				request.setAttribute("post", post);
				request.setAttribute("spotList", spotList);
				request.setAttribute("fileList", fileList);
				request.setAttribute("tagList", tagList);
				
				request.getRequestDispatcher("/WEB-INF/views/user/userDetail.jsp").forward(request, response);
			}
			
		}else if(page==2) {
			request.setAttribute("post", post);
			request.setAttribute("page", page);
			request.getRequestDispatcher("/WEB-INF/views/user/userDetail.jsp").forward(request, response);
		}else if(page==3) {
			if (post != null) {
				request.setAttribute("post", post);
				request.setAttribute("page", page);
				request.setAttribute("spotList", spotList);
				request.setAttribute("fileList", fileList);
				request.setAttribute("tagList", tagList);
				request.getRequestDispatcher("/WEB-INF/views/user/userDetail.jsp").forward(request, response);
			}
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
