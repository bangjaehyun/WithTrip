package kr.or.iei.festival.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.iei.festival.model.service.FestivalService;
import kr.or.iei.festival.model.vo.FestivalSubInfoTema;

/**
 * Servlet implementation class FestivalSubInfoServlet
 */
@WebServlet("/festival/subInfoTema")
public class FestivalSubInfoTemaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FestivalSubInfoTemaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String festivalId = request.getParameter("festivalId");
		String festivalType = request.getParameter("festivalType");
		
		FestivalService service = new FestivalService();
		FestivalSubInfoTema info = service.festivalTemaSubInfo(festivalId, festivalType);
		
		request.setAttribute("festivalId", festivalId);
		request.setAttribute("festivalType", festivalType);
		request.setAttribute("info", info);
		
		
		request.getRequestDispatcher("/WEB-INF/views/festival/subInfoTemaFrm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
