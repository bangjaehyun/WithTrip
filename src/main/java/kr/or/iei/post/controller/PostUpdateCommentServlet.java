package kr.or.iei.post.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.iei.post.model.service.PostService;
import kr.or.iei.post.model.vo.PostComment;

/**
 * Servlet implementation class PostUpdateCommentServlet
 */
@WebServlet("/post/updateComment")
public class PostUpdateCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostUpdateCommentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String commentId = request.getParameter("commentId");
		String postNo = request.getParameter("postNo");
		String commentVal = request.getParameter("commentVal");
		
		PostComment comment = new PostComment();
		comment.setCommentId(commentId);
		comment.setCommentRef(postNo);
		comment.setCommentVal(commentVal);
		
		PostService service = new PostService();
		int result = service.updateComment(comment);
		if(request.getParameter("trip") != null) {
			if(result > 0) {
				request.setAttribute("title", "알림");
				request.setAttribute("msg", "댓글 수정이 완료되었습니다.");
				request.setAttribute("icon", "success");
				request.setAttribute("loc", "/post/trip?postNo="+postNo+"&commentChk=chk");
			} else {
				request.setAttribute("title", "알림");
				request.setAttribute("msg", "댓글 수정 중, 오류가 발생했습니다.");
				request.setAttribute("icon", "error");
				request.setAttribute("loc", "/post/trip?postNo="+postNo+"&commentChk=chk");
			}	
		}else {
			if (result > 0) {
				request.setAttribute("title", "알림");
				request.setAttribute("msg", "댓글 수정이 완료되었습니다.");
				request.setAttribute("icon", "success");
				request.setAttribute("loc", "/post/view?postNo=" + postNo + "&commentChk=chk");
			} else {
				request.setAttribute("title", "알림");
				request.setAttribute("msg", "댓글 수정 중, 오류가 발생했습니다.");
				request.setAttribute("icon", "error");
				request.setAttribute("loc", "/post/view?postNo=" + postNo + "&commentChk=chk");
			}
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
