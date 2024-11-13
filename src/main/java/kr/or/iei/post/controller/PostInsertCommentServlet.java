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
 * Servlet implementation class PostInsertCommentServlet
 */
@WebServlet("/post/insertComment")
public class PostInsertCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostInsertCommentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 인코딩
		
		//2. 값 추출
		String commentRef = request.getParameter("commentRef");
		String commentWriter = request.getParameter("commentWriter");
		String commentVal = request.getParameter("commentVal");
		
		System.out.println("게시글번호 : " +commentRef);
		System.out.println("댓글 작성한 사람 회원번호 :  " + commentWriter);
		System.out.println("댓글내용 : " + commentVal);
		
		//3. 로직
		PostComment comment = new PostComment();
		comment.setCommentRef(commentRef);
		comment.setUserNo(commentWriter);
		comment.setCommentVal(commentVal);
		
		PostService service = new PostService();
		int result = service.insertComment(comment);
		
		System.out.println("서블릿 result : " + result);
		System.out.println("서블릿 commentRef : " + commentRef);
		//4. 결과처리
		if(result > 0 ) {
			request.setAttribute("title", "알림");
			request.setAttribute("msg", "댓글이 작성되었습니다.");
			request.setAttribute("icon", "success");
			request.setAttribute("loc", "/post/view?postNo="+commentRef+"&commentChk=chk");
		} else {
			request.setAttribute("title", "실패");
			request.setAttribute("msg", "댓글 작성 중, 오류가 발생하였습니다.");
			request.setAttribute("icon", "error");
			request.setAttribute("loc", "/post/view?postNo="+commentRef+"&commentChk=chk");
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
