package kr.or.iei.user.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AdminPOrCFrm
 */
@WebServlet("/user/userListFrm")
public class UserListFrmServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserListFrmServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int pOrC = Integer.parseInt(request.getParameter("pOrC"));
	
		int postTypeId = Integer.parseInt(request.getParameter("postTypeId"));
		String postTypeName = request.getParameter("postTypeName");
		
		
		request.setAttribute("pOrC", pOrC);
		if(pOrC == 1) {
			request.setAttribute("postorcomment", "게시글");
		}else if(pOrC == 0) {
			request.setAttribute("postorcomment", "댓글");
		}
		request.setAttribute("postTypeId", postTypeId);
		request.setAttribute("postTypeName", postTypeName);
		
		request.getRequestDispatcher("/WEB-INF/views//user/userListPage.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
