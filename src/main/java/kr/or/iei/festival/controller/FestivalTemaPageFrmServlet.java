package kr.or.iei.festival.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.iei.festival.model.service.FestivalService;
import kr.or.iei.festival.model.vo.FestivalMain;

/**
 * Servlet implementation class FestivalTemaPageServlet
 */
@WebServlet("/festival/temaPageFrm")
public class FestivalTemaPageFrmServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FestivalTemaPageFrmServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String temaName = request.getParameter("temaName");
		String pageNo = request.getParameter("pageNo");
		System.out.println(temaName);
		System.out.println(pageNo);
		if(temaName != null) {
			FestivalService service = new FestivalService();
			ArrayList<FestivalMain> list = service.festivalTemaMain(temaName, pageNo);
			request.setAttribute("list", list);
			request.setAttribute("totalCount", list.get(0).getFestivalTotalCount());
			request.setAttribute("temaName", temaName);
		}else {
			request.setAttribute("totalCount", 0);
		}
		
		request.setAttribute("pageNo", pageNo);
		
		request.getRequestDispatcher("/WEB-INF/views/festival/temaPage.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
