package kr.or.iei.post.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import kr.or.iei.common.vo.MyRenamePolicy;

/**
 * Servlet implementation class PostEditorImageServlet
 */
@WebServlet("/post/editorImage")
public class PostEditorImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostEditorImageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String toDay = new SimpleDateFormat("yyyyMMdd").format(new Date());
		
		
		String rootPath = request.getSession().getServletContext().getRealPath("/");
		String savePath = "/resources/upload/editor/" + toDay + "/";
		String resPath = savePath;
		savePath = rootPath + savePath;
		int maxSize = 1024 * 1024 * 100; 
		
		File dir = new File(savePath);
        if (!dir.exists()) {
            dir.mkdirs();  
        }
        
		MultipartRequest mRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyRenamePolicy());
		
		
		response.getWriter().print(resPath+mRequest.getFilesystemName("upfile"));
	}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
