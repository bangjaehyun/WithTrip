package kr.or.iei.user.controller;

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
import kr.or.iei.common.model.vo.PageData;
import kr.or.iei.common.vo.Pagination;
import kr.or.iei.post.model.service.PostService;
import kr.or.iei.post.model.vo.Post;

/**
 * Servlet implementation class AdminDetail
 */
@WebServlet("/user/userDetail")
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
		int pOrC = Integer.parseInt(request.getParameter("pOrC"));
		int page = Integer.parseInt(request.getParameter("page"));
		int postTypeId = Integer.parseInt(request.getParameter("postTypeId"));
		String postTypeName = request.getParameter("postTypeName");
		String userNo = request.getParameter("userNo");
		String postNo = request.getParameter("postNo");
		String commentId = request.getParameter("commentId");

		AdminService adService = new AdminService();
		Comment commentContent = adService.selectComment(userNo, commentId);

		request.setAttribute("postTypeName", "게시글");
		request.setAttribute("postTypeName", "댓글");
		request.setAttribute("pOrC", pOrC);
		request.setAttribute("postTypeId", postTypeId);
		request.setAttribute("postTypeName", postTypeName);
		request.setAttribute("comment", commentContent);

		String commentChk = request.getParameter("commentChk");

		// 3. 로직
		PostService service = new PostService();
		Post post = service.selectModifyPost(postNo, commentChk);
		if(page==1) {
			if (post != null) {
				Gson gson = new Gson();
				String spotList = gson.toJson(post.getSpotList());
				String fileList = gson.toJson(post.getFileList());
				String tagList = gson.toJson(post.getTagList());
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
				Gson gson = new Gson();
				String spotList = gson.toJson(post.getSpotList());
				String fileList = gson.toJson(post.getFileList());
				String tagList = gson.toJson(post.getTagList());
				request.setAttribute("post", post);
				request.setAttribute("spotList", spotList);
				request.setAttribute("fileList", fileList);
				request.setAttribute("tagList", tagList);
				request.setAttribute("page", page);
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
