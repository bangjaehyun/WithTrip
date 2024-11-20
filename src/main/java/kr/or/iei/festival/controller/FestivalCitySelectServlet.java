package kr.or.iei.festival.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.iei.festival.model.service.FestivalService;
import kr.or.iei.festival.model.vo.FestivalMain;

/**
 * Servlet implementation class FestivalCitySelectServlet
 */
@WebServlet("/festival/citySelect")
public class FestivalCitySelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public FestivalCitySelectServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String contentType = request.getParameter("contentType");
		String areaCode = request.getParameter("areaCode");
		String selectPage = request.getParameter("selectPage");

		FestivalService service = new FestivalService();
		ArrayList<FestivalMain> list = service.cityInfo(contentType, areaCode, selectPage);

		Gson gson = new Gson();
		String jsonStr = gson.toJson(list);

		response.setContentType("text/plain;charset=utf-8");
		response.setContentType("application/json");

		response.getWriter().print(jsonStr);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
