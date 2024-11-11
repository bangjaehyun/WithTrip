package kr.or.iei.common;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import kr.or.iei.festival.model.service.FestivalService;
import kr.or.iei.festival.model.vo.FestivalMain;

/**
 * Application Lifecycle Listener implementation class FestivalLoadListener
 *
 */
public class FestivalLoadListener implements ServletContextListener {

    /**
     * Default constructor. 
     */
    public FestivalLoadListener() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent sce)  { 
         // TODO Auto-generated method stub
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent sce)  {
    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
    	Date date = new Date(); 
    	
    	Calendar cal = Calendar.getInstance();
    	cal.set(Calendar.MONTH, 11);
    	int dayOfMonth = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
    	cal.set(Calendar.DAY_OF_MONTH, dayOfMonth);
    	
    	String toDay = dateFormat.format(date);
    	String lastDay = dateFormat.format(cal.getTime());
    	
    	FestivalService service = new FestivalService();
    	ArrayList<FestivalMain> list =  service.festivalLoad(toDay,lastDay,"4","1");
    	sce.getServletContext().setAttribute("festivalList", list);
    }
	
}
