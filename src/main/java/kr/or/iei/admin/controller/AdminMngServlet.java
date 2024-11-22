	package kr.or.iei.admin.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.iei.admin.service.AdminService;
import kr.or.iei.common.model.vo.PageData;
import kr.or.iei.post.model.vo.Post;
import kr.or.iei.user.model.vo.User;

/**
 * Servlet implementation class AdminMngServlet
 */
@WebServlet("/admin/adminUserMng")
public class AdminMngServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminMngServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		User loginUser = (User)session.getAttribute("loginUser");
		String mapAddr = "/admin/adminUserMng";
		int reqPage = Integer.parseInt(request.getParameter("reqPage"));
		int pageSize = Integer.parseInt(request.getParameter("pageSize"));
		
		PageData pd = new PageData();
		AdminService service = new AdminService();
		ArrayList<Post> pgList = service.selectUserList();
		System.out.println(pgList);
		pd = service.pageListUser(mapAddr,reqPage,pageSize,pgList);

		request.setAttribute("loginUser", loginUser);
		request.setAttribute("pgList", pd.getList());
		request.setAttribute("pageNav", pd.getPageNavi());
		request.getRequestDispatcher("/WEB-INF/views/admin/adminMng.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
