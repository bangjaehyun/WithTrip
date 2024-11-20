package kr.or.iei.admin.controller.frm;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AdminPOrCFrm
 */
@WebServlet("/admin/adminList")
public class AdminListFrmServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminListFrmServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pOrC = Integer.parseInt(request.getParameter("pOrC"));
	
		int postTypeId = Integer.parseInt(request.getParameter("postTypeId"));
		String postTypeName = request.getParameter("postTypeName");
		
		
		request.setAttribute("pOrC", pOrC);
		request.setAttribute("postTypeId", postTypeId);
		request.setAttribute("postTypeName", postTypeName);
		
		request.getRequestDispatcher("/WEB-INF/views/admin/adminListPage.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
