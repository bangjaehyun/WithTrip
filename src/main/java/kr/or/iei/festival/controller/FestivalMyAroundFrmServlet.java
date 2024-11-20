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
 * Servlet implementation class FesivalMyAroundServlet
 */
@WebServlet("/festival/myAroundFrm")
public class FestivalMyAroundFrmServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FestivalMyAroundFrmServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String lat = request.getParameter("lat");
		String lon = request.getParameter("lon");
		String page = request.getParameter("page");
		
		FestivalService service = new FestivalService();
		ArrayList<FestivalMain> list = service.festivalMyAround(lon, lat, page);
		
		request.setAttribute("list", list);
		request.setAttribute("totalCount", list.get(0).getFestivalTotalCount());
		request.setAttribute("pageNo", page);
		request.setAttribute("lat", lat);
		request.setAttribute("lon", lon);
		request.getRequestDispatcher("/WEB-INF/views/festival/myAroundFrm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
