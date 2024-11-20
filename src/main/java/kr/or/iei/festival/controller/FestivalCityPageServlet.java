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
 * Servlet implementation class FestivalCityServlet
 */
@WebServlet("/festival/cityPage")
public class FestivalCityPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FestivalCityPageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String areaCode = "";
		
		FestivalService service = new FestivalService();
		ArrayList<FestivalMain> list = service.cityInfo("12", areaCode , "1");
		
		request.setAttribute("list", list);
		request.getRequestDispatcher("/WEB-INF/views/festival/cityMainPage.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
