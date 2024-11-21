package kr.or.iei.admin.controller.frm;

import java.util.ArrayList;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import kr.or.iei.admin.service.AdminService;
import kr.or.iei.post.model.vo.Post;

/**
 * Application Lifecycle Listener implementation class AdminPageIndexListener
 *
 */
@WebListener
public class AdminPageIndexListener implements ServletContextListener {

    /**
     * Default constructor. 
     */
    public AdminPageIndexListener() {
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
         // TODO Auto-generated method stub
    	AdminService service = new AdminService();
    	ArrayList<Post> postIdNameList = service.postIdNameList();
    	sce.getServletContext().setAttribute("pList", postIdNameList);
    }
	
}
