package kr.or.iei.admin.controller.frm;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.iei.admin.service.AdminService;
import kr.or.iei.post.model.vo.Post;
import kr.or.iei.post.model.vo.PostType;

/**
 * Servlet implementation class AdminPageFrm
 */
@WebServlet("/admin/adminFrm")

//게시글 삭제 페이지를 관리자페이지의 메인페이지로 둘 것임.
public class AdminPagePostMngFrmServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminPagePostMngFrmServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//공지사항 관리 서블릿
//		HttpSession session = request.getSession(false);
//		if (session != null) {
//			User loginUser = (User)session.getAttribute("userNo");
//			
//			if (loginUser.getUserType()!=1) {
//				request.setAttribute("title", "알림");
//				request.setAttribute("msg", "해당 메뉴에 대한 접속 권한이 없습니다");
//				request.setAttribute("icon", "error");
//				request.setAttribute("loc", "/user/mypage");
//
//				request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
//				return;
//
//			}
//		}
		AdminService adService = new AdminService();
		String ntcTp = request.getParameter("ntcTp");
		ArrayList<Post> ntcList = new ArrayList<Post>();
		PostType ntcType = new PostType();
		switch(ntcTp) {
		case "1":
			ntcList = adService.selectAllPostsList("1");
			request.setAttribute("ntcList", ntcList);
			request.setAttribute("ntcType", ntcType);
			request.getRequestDispatcher("/WEB-INF/views/admin/adminNtcMng.jsp").forward(request, response);
			break;
		case "2":
			ntcList = adService.selectAllPostsList("2");
			request.setAttribute("ntcList", ntcList);
			request.setAttribute("ntcType", ntcType);
			request.getRequestDispatcher("/WEB-INF/views/admin/adminQnaMng.jsp").forward(request, response);
			break;
		case "3":
			ntcList = adService.selectAllPostsList("3");
			request.setAttribute("ntcList", ntcList);
			request.setAttribute("ntcType", ntcType);
			request.getRequestDispatcher("/WEB-INF/views/admin/adminPstMng.jsp").forward(request, response);
			break;
		case "4":
			ntcList = adService.selectAllPostsList("4");
			request.setAttribute("ntcList", ntcList);
			request.setAttribute("ntcType", ntcType);
			request.getRequestDispatcher("/WEB-INF/views/admin/adminPtnMng.jsp").forward(request, response);
			break;
		default:
			break;
		}
		//서비스 함수 호출
		
		//전체 댓글 조회를 위한 commentList ArrayList 생성
		
		//ArrayList 반환
		
		//주소로...
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
