package kr.or.iei.post.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.iei.post.model.service.PostService;

/**
 * Servlet implementation class PostCancelCmtLike
 */
@WebServlet("/post/cancelCmtLike")
public class PostCancelCmtLike extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostCancelCmtLike() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String postNo = request.getParameter("postNo");
		String commentId = request.getParameter("commentId");
		String userNo = request.getParameter("userNo");
		int like = Integer.parseInt(request.getParameter("like"));
		
		System.out.println("댓글좋아요취소서블릿 postNo : " + postNo);
		System.out.println("댓글좋아요취소서블릿 commentId : " + commentId);
		System.out.println("댓글좋아요취소서블릿 userNo : " + userNo);
		System.out.println("댓글좋아요취소서블릿 like : " + like);
		
		PostService service = new PostService();
		int result = service.chkTblCmtLike(postNo, commentId, userNo, like);
		
		if(result > 0) {
			response.getWriter().print("1");
		}else {
			response.getWriter().print("0");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
