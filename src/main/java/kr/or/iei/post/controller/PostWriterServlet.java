package kr.or.iei.post.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import kr.or.iei.common.vo.MyRenamePolicy;
import kr.or.iei.post.model.vo.PostFile;

/**
 * Servlet implementation class postInsertServlet
 */
@WebServlet("/post/writer")
public class PostWriterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostWriterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String today = sdf.format(date); // 오늘날짜

		String rootPath = request.getSession().getServletContext().getRealPath("/");// webapp 폴더 경로
		String savePath = rootPath + "resources/upload/" + today + "/"; // 파일 저장 경로
		
		int maxSize = 1024 * 1024 * 10; // 10MB

		File dir = new File(savePath);// 오늘날짜로 지정한 폴더
		
		if (!dir.exists()) { // 해당 경로에 폴더가 생성되어 있지 않을 떄
			dir.mkdir();// 폴더 생성
		}
		
		
		MultipartRequest mRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyRenamePolicy());
		
		String postTitle = mRequest.getParameter("postTitle");
		String postContent = mRequest.getParameter("postContent");
		
		Enumeration<String> files = mRequest.getFileNames(); // input type이 file인 태그들의, name 속성값
		
		
		ArrayList<PostFile> fileList = new ArrayList<PostFile>();
		while (files.hasMoreElements()) {
			String name = files.nextElement(); // input type이 file인 태그의 name 속성값
			String fileName = mRequest.getOriginalFileName(name); // 원본 파일명
			String filePath = mRequest.getFilesystemName(name);// 변경된 파일명
			if (filePath != null) {
				PostFile file = new PostFile();
				file.setFileName(fileName);
				file.setFilePath(filePath);
				
				fileList.add(file);
				System.out.println(file);
			}
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
