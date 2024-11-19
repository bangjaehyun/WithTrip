package kr.or.iei.festival.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;



import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.iei.festival.model.service.FestivalService;
import kr.or.iei.festival.model.vo.FestivalMain;

/**
 * Servlet implementation class FestivalSelectPageServlet
 */
@WebServlet("/festival/selectPage")
public class FestivalSelectPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FestivalSelectPageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchType = request.getParameter("searchType");
		String toDay = request.getParameter("toDay");
		String lastDay = request.getParameter("lastDay");
		String keyword = request.getParameter("keyword");
		String selectPage = request.getParameter("selectPage");
		String areaCode = request.getParameter("areaCode");
		
		ArrayList<FestivalMain> list = null;
		if(searchType.equals("1")) {
			FestivalService service = new FestivalService();
				list = service.festivalDate(toDay, lastDay, areaCode, selectPage);
		}else {
			// 키워드로 검색할 경우
			FestivalService service = new FestivalService();
			list = service.festivalKeyword(keyword, areaCode, selectPage);
		}
		
		Gson gson = new Gson();
		String jsonStr = gson.toJson(list);
		
		response.setContentType("text/plain;charset=utf-8");
		response.setContentType("application/json");
		
		response.getWriter().print(jsonStr);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
