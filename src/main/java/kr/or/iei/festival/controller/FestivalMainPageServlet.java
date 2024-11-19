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

import kr.or.iei.festival.model.service.FestivalService;
import kr.or.iei.festival.model.vo.FestivalMain;

/**
 * Servlet implementation class FestivalMainPageServlet
 */
@WebServlet("/festival/mainPage")
public class FestivalMainPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public FestivalMainPageServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		Calendar cal = Calendar.getInstance();
		
		String searchType = request.getParameter("searchType");
		String monthSearch = request.getParameter("month");
		String toDay = null;
		String lastDay = null;
		ArrayList<FestivalMain> list = null;
		
		FestivalService service = new FestivalService();
		if(monthSearch == null) {
			// 처음 페이지에 불러올 기간 세팅
			
			cal.setTime(date);
			cal.add(Calendar.MONTH, 2);
			
			toDay = dateFormat.format(date);
			lastDay = dateFormat.format(cal.getTime());
			
			list = service.festivalLoad(toDay, lastDay, "12", "1");
			
			// 날짜를 yyyy-MM-dd 형식으로 변경
			toDay = df.format(date);
			lastDay = df.format(cal.getTime());
		}else {
			// 월별 페이지 세팅
			
			// 년,월을 세팅 및 날짜 포맷 생성
			int month = Integer.parseInt(monthSearch);
			int year = Calendar.getInstance().get(Calendar.YEAR);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			
			// 해당 월에 초일 구하기
			Calendar firstDayOfMonth = Calendar.getInstance();
	        firstDayOfMonth.set(year, month, 1);
			
	        // 해당 월에 말일 구하기
	        Calendar lastDayOfMonth = (Calendar) firstDayOfMonth.clone();
	        lastDayOfMonth.add(Calendar.MONTH, 1);
	        lastDayOfMonth.set(Calendar.DAY_OF_MONTH, 0);
			
	        // 문자열로 변환
	        toDay = sdf.format(firstDayOfMonth.getTime());
	        lastDay = sdf.format(lastDayOfMonth.getTime());
			
			list = service.festivalLoad(toDay, lastDay, "12", "1");
			
			// 날짜를 yyyy-MM-dd 형식으로 변경
			toDay = df.format(firstDayOfMonth.getTime());
	        lastDay = df.format(lastDayOfMonth.getTime());
		}
		
		
		request.setAttribute("list", list);
		request.setAttribute("searchType", searchType);
		request.setAttribute("toDay", toDay);
		request.setAttribute("lastDay", lastDay);
		
		request.getRequestDispatcher("/WEB-INF/views/festival/festivalMainPage.jsp").forward(request, response);
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
