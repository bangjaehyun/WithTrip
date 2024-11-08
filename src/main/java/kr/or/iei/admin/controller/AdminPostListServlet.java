package kr.or.iei.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.iei.admin.service.AdminService;
import kr.or.iei.common.model.vo.PageData;

/**
 * Servlet implementation class AdminPostListServletr
 */
@WebServlet("/admin/list")
public class AdminPostListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminPostListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String postTypeId = request.getParameter("postTypeId");
		String postTypeNm = request.getParameter("postTypeName");
		String callPage = request.getParameter("callPage");//각 jsp에서 해당 jsp파일의 이름을 반환. ex) adminPage.jsp --> adminPage
		
		int reqPage = request.getParameter("reqPage") == null ? 1 : Integer.parseInt(request.getParameter("reqPage")); 
		int pageSize = Integer.parseInt(request.getParameter("pageSize"));
		
		AdminService adService = new AdminService();
		PageData pd = adService.pageList(postTypeId, postTypeNm, reqPage, pageSize);
		
		request.setAttribute("pageList", pd.getList());
		request.setAttribute("pageNavi", pd.getPageNavi());
		request.setAttribute("postTypeId", postTypeId);
		request.setAttribute("postTypeName", postTypeNm);
		//해당 페이지의 jsp위치로 보내줌.
		request.getRequestDispatcher("/WEB-INF/views/admin/"+callPage+".jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
