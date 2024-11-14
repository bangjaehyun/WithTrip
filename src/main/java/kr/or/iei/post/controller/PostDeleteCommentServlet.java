package kr.or.iei.post.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.iei.post.model.service.PostService;

/**
 * Servlet implementation class PostDeleteCommentServlet
 */
@WebServlet("/post/deleteComment")
public class PostDeleteCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostDeleteCommentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String postNo = request.getParameter("postNo");
		String commentId = request.getParameter("commentId");
		
		System.out.println("PostDeleteCommentServlet의 postNo : " + postNo);
		System.out.println("PostDeleteCommentServlet의 commentId : " + commentId);		
		
		PostService service = new PostService();
		int result =  service.deleteComment(commentId);
		
		if(result > 0) {
			request.setAttribute("title", "알림");
			request.setAttribute("msg", "댓글을 삭제했습니다.");
			request.setAttribute("icon", "success");
			request.setAttribute("loc", "/post/view?postNo="+postNo+"&commentChk=chk");
		} else {
			request.setAttribute("title", "알림");
			request.setAttribute("msg", "댓글 삭제중, 오류가 발생했습니다.");
			request.setAttribute("icon", "error");
			request.setAttribute("loc", "/post/view?postNo="+postNo+"&commentChk=chk");
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
