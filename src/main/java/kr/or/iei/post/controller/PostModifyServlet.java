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

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.oreilly.servlet.MultipartRequest;

import kr.or.iei.common.vo.MyRenamePolicy;
import kr.or.iei.post.model.service.PostService;
import kr.or.iei.post.model.vo.Post;
import kr.or.iei.post.model.vo.PostFile;
import kr.or.iei.spot.model.vo.Spot;

/**
 * Servlet implementation class PostModifyServlet
 */
@WebServlet("/post/modify")
public class PostModifyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostModifyServlet() {
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
		String saveFolder = rootPath + "resources/upload/";
		
		File folder = new File(saveFolder);
		if(!folder.exists()) {
			folder.mkdir();
		}
		
		String savePath = rootPath + "resources/upload/" + today + "/"; // 파일 저장 경로
		
		int maxSize = 1024 * 1024 * 10; // 10MB

		File dir = new File(savePath);// 오늘날짜로 지정한 폴더
		if (!dir.exists()) { // 해당 경로에 폴더가 생성되어 있지 않을 떄
			dir.mkdir();// 폴더 생성
		}
		
		
		MultipartRequest mRequest = new MultipartRequest(request, savePath, maxSize, "UTF-8", new MyRenamePolicy());
		
		String postNo = mRequest.getParameter("postNo");
		String postTitle = mRequest.getParameter("postTitle");
		String postContent = mRequest.getParameter("postContent");
		String tripDate = mRequest.getParameter("tripDate");
		String mapList = mRequest.getParameter("mapList");
		String tagList = mRequest.getParameter("tagList");
		String removeFileList = mRequest.getParameter("removeFileList");
		ArrayList<Spot> spotList = new ArrayList<Spot>();
		JsonParser jsonParser = new JsonParser();
		
		if(!mapList.equals("null")) {
		JsonArray jArray = jsonParser.parse(mapList).getAsJsonArray();
		for (JsonElement pa : jArray) {
			JsonObject paymentObj = pa.getAsJsonObject();
			Spot spot = new Spot();
			spot.setSpotAddr(paymentObj.get("address_name").getAsString());
			spot.setSpotName(paymentObj.get("place_name").getAsString());
			spot.setSpotLat(paymentObj.get("x").getAsString());
			spot.setSpotLng(paymentObj.get("y").getAsString());
			if(paymentObj.has("phone")) {
				spot.setSpotPhone(paymentObj.get("phone").getAsString());
			}
			spot.setKakaoMapId(paymentObj.get("id").getAsString());
			spotList.add(spot);
		}
	}
		
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
				file.setPostNo(postNo);
				fileList.add(file);
			}
		}
		
		Post post = new Post();
		post.setPostNo(postNo);
		post.setPostTitle(postTitle);
		post.setPostContent(postContent);
		post.setTripDate(tripDate);
		if(tagList != null) {
			post.setTagList(tagList);
		}
		if(removeFileList != null) {
			String delrootPath = request.getSession().getServletContext().getRealPath("/resources/upload/");
				JsonArray jFileArray = jsonParser.parse(removeFileList).getAsJsonArray();
				ArrayList<PostFile> list = new ArrayList<PostFile>(); 
				for (JsonElement pa : jFileArray) {
					JsonObject obj = pa.getAsJsonObject();
					PostFile postFile = new PostFile();
					postFile.setFileNo(obj.get("fileNo").getAsString());
					String fileName = obj.get("fileName").getAsString();
					postFile.setFileName(fileName);
					String delFilePath = delrootPath + fileName.substring(0,8) + fileName + "/";
					postFile.setFilePath(delFilePath);
					postFile.setPostNo(postNo);
					list.add(postFile);
				}
				post.setFileList(list);
		}
		System.out.println("date" + tripDate);
		PostService service = new PostService();
		int result = service.modifyPost(post, fileList, spotList);
		
		if(result > 0) {
			response.getWriter().print("1");
		}else {
			response.getWriter().print("0");
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
