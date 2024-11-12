package kr.or.iei.admin.controller.frm;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.iei.admin.service.AdminService;
import kr.or.iei.common.model.vo.PageData;
import kr.or.iei.common.vo.Pagination;
import kr.or.iei.post.model.vo.Post;

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
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//공지사항 관리 서블릿
		
		//로그인 후 해당 페이지 접속시 세션값==관리자 확인
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
		String mapAddr = "/admin/adminFrm";
		String pstTypeId = request.getParameter("postTypeId");
		String pstTypeName = request.getParameter("postTypeName");
		int reqPage = Integer.parseInt(request.getParameter("reqPage"));
		int pageSize = Integer.parseInt(request.getParameter("pageSize"));
		int totCnt = 0;
		AdminService adService = new AdminService();
		
		//게시글 리스트 메소드
		
		//게시글 갯수..초기값
	
		
		
		ArrayList<Post> pgList = adService.selectPostList(pstTypeId, reqPage, pageSize);
		
		Pagination pageInfo = new Pagination(mapAddr, pstTypeId, pstTypeName, reqPage, pageSize, pgList, totCnt);
		
		PageData pd = new PageData();
		pd= adService.pageList(pageInfo);
		//게시글 페이징 메소드
		//페이징
		request.setAttribute("pstTypeName", pstTypeName);
		request.setAttribute("pgList", pd.getList());
		request.setAttribute("pageNavi", pd.getPageNavi());
		request.getRequestDispatcher("/WEB-INF/views/admin/adminNtcMng.jsp").forward(request, response);
		
		/*안쓸지도...?
		switch(pstTypeId) {
		case "1":
			//게시글 페이징 메소드
			pgList = adService.selectPostList(pstTypeId, reqPage, pageSize);
			pd= adService.pageList(mapAddr, pstTypeId, "공지사항", reqPage, pageSize, pgList);
			//게시글 페이징 메소드
			//페이징
			request.setAttribute("pgList", pd.getList());
			request.setAttribute("pageNavi", pd.getPageNavi());
			request.getRequestDispatcher("/WEB-INF/views/admin/adminNtcMng.jsp").forward(request, response);
			break;
		
		case "2":
			pgList = adService.selectPostList(pstTypeId, reqPage, pageSize);
			pd= adService.pageList(mapAddr, pstTypeId, "게시글", reqPage, pageSize,pgList);
			
			request.setAttribute("pgList", pd.getList());
			request.setAttribute("pageNavi", pd.getPageNavi());
			request.getRequestDispatcher("/WEB-INF/views/admin/adminPstMng.jsp").forward(request, response);
			break;
		case "3":
			pgList = adService.selectPostList(pstTypeId, reqPage, pageSize);
			pd= adService.pageList(mapAddr, pstTypeId, "파트너", reqPage, pageSize, pgList);
			request.setAttribute("pgList", pd.getList());
			request.setAttribute("pageNavi", pd.getPageNavi());
			request.getRequestDispatcher("/WEB-INF/views/admin/adminPtnMng.jsp").forward(request, response);
			break;
		case "4":
			pgList = adService.selectPostList(pstTypeId, reqPage, pageSize);
			pd= adService.pageList(mapAddr, pstTypeId, "QnA", reqPage, pageSize, pgList);
			request.setAttribute("pgList", pd.getList());
			request.setAttribute("pageNavi", pd.getPageNavi());
			request.getRequestDispatcher("/WEB-INF/views/admin/adminQnaMng.jsp").forward(request, response);
			break;
		case "5":
			pgList = adService.selectPostList(pstTypeId, reqPage, pageSize);
			pd= adService.pageList(mapAddr, pstTypeId, "사이트이용안내", reqPage, pageSize, pgList);
			request.setAttribute("pgList", pd.getList());
			request.setAttribute("pageNavi", pd.getPageNavi());
			request.getRequestDispatcher("/WEB-INF/views/admin/adminUsrManual.jsp").forward(request, response);
			break;
		default:
			break;
		}
		//서비스 함수 호출
		
		//전체 댓글 조회를 위한 commentList ArrayList 생성
		
		//ArrayList 반환
		
		//주소로...
		*/
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
