package kr.or.iei.post.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.iei.post.model.service.PostService;
import kr.or.iei.post.model.vo.Post;

/**
 * Servlet implementation class PostIndexServlet
 */
@WebServlet("/post/index")
public class PostIndexServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostIndexServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PostService service = new PostService();
		ArrayList<Post> list = service.selectIndexPostList();
		
		Gson gson = new Gson();
		String jsonStr = gson.toJson(list);
		//System.out.println("123" + jsonStr);
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");	//응답 데이터 형식 지정
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
