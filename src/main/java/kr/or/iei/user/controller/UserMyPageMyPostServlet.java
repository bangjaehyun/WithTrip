package kr.or.iei.user.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.iei.common.model.vo.PageData;
import kr.or.iei.common.vo.Pagination;
import kr.or.iei.post.model.vo.Post;
import kr.or.iei.user.model.service.UserService;

/**
 * Servlet implementation class UserMyPageMyPost
 */
@WebServlet("/user/myPageMyPost")
public class UserMyPageMyPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserMyPageMyPostServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mapAddr = "/user/myPageMyPost";
		String srchContent = request.getParameter("srchContent");
		System.out.println(srchContent);
		int totCnt = 0;
		int reqPage = Integer.parseInt(request.getParameter("reqPage"));
		int pageSize = Integer.parseInt(request.getParameter("pageSize"));
		
		UserService userService = new UserService();
		ArrayList<Post> myPostList = userService.selMyPosts("2", reqPage, pageSize);
		
		
		Pagination pageInfo = new Pagination(mapAddr, "2", "게시글", reqPage, pageSize, myPostList, totCnt);
		
		PageData pd = new PageData();
		pd= userService.pageList(pageInfo);
		request.setAttribute("myPostList", pd.getList());
		request.setAttribute("myPostNavi", pd.getPageNavi());
		request.getRequestDispatcher("/WEB-INF/views/user/myPageMyPost.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
