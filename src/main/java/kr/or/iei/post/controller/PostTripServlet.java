package kr.or.iei.post.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import kr.or.iei.post.model.service.PostService;
import kr.or.iei.post.model.vo.Post;
import kr.or.iei.post.model.vo.PostType;
import kr.or.iei.user.model.vo.User;

/**
 * Servlet implementation class PostTripServlet
 */
@WebServlet("/post/trip")
public class PostTripServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PostTripServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 2. 값 추출
		String postNo = request.getParameter("postNo");
		String commentChk = request.getParameter("commentChk");
		
		// 3. 로직
		PostService service = new PostService();
		Post post = service.selectModifyPost(postNo,commentChk);
		int userLike = -1;
		if(post != null) {
			HttpSession session = request.getSession();
			User loginUser = (User) session.getAttribute("loginUser");
			if(loginUser != null) {
				userLike = service.selectLoginUserPostLike(loginUser.getUserNo(), postNo);
			}
			
			Gson gson = new Gson();
			String spotList = gson.toJson(post.getSpotList());
			String fileList = gson.toJson(post.getFileList());
			String tagList = gson.toJson(post.getTagList());
			request.setAttribute("userLike", userLike);
			request.setAttribute("post", post);
			request.setAttribute("spotList", spotList);
			request.setAttribute("fileList", fileList);
			request.setAttribute("tagList", tagList);
			request.getRequestDispatcher("/WEB-INF/views/post/trip.jsp").forward(request, response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
