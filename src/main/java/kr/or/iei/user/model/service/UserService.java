package kr.or.iei.user.model.service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.StringTokenizer;

import org.mindrot.jbcrypt.BCrypt;

import kr.or.iei.comment.vo.Comment;
import kr.or.iei.common.JDBCTemplate;
import kr.or.iei.common.model.vo.PageData;
import kr.or.iei.common.service.CommonService;
import kr.or.iei.common.vo.Pagination;
import kr.or.iei.post.model.dao.PostDao;
import kr.or.iei.post.model.vo.Post;
import kr.or.iei.spot.model.vo.Spot;
import kr.or.iei.user.model.dao.UserDao;
import kr.or.iei.user.model.vo.UserSite;

public class UserService {
	UserDao dao;
	PostDao postDao;
	CommonService commonServ;

	public UserService(){
		dao = new UserDao();
		commonServ = new CommonService();
	}
	
	public UserService(boolean chk) {
		dao = new UserDao();
		commonServ = new CommonService();
		postDao = new PostDao();
	}
	
	
	public int deleteUser(String userNo) {
		Connection conn = JDBCTemplate.getConnection();
		int result = 0;
		ArrayList<Post> postList = postDao.selectAllPost(conn, userNo);
		boolean spotDelChk = true;
		for(int i =0; i < postList.size(); i++) {
			ArrayList<Spot> spotList = postDao.selectPostSpot(conn, postList.get(i).getPostNo());
			for(int j = 0; j < spotList.size(); j++) {
				result = postDao.deleteSpot(conn, spotList.get(j).getSpotNo());
				if(result < 1) {
					JDBCTemplate.rollback(conn);
					spotDelChk = false;
					break;
				}
			}
		}
		if(spotDelChk) {
			result = dao.deleteUser(conn, userNo);

			if (result > 0) {
				JDBCTemplate.commit(conn);
			} else {
				JDBCTemplate.rollback(conn);
			}
		}
		JDBCTemplate.close(conn);
		return result;
	}

	public int nicknameChk(String userNickname) {
		Connection conn = JDBCTemplate.getConnection();
		int result = dao.nicknameChk(conn, userNickname);
		JDBCTemplate.close(conn);
		return result;
	}

	public int userPwChg(String userNo, String newUserPw) {
		Connection conn = JDBCTemplate.getConnection();
		newUserPw = BCrypt.hashpw(newUserPw, BCrypt.gensalt());
		
		
		int result = dao.userPwChg(conn, userNo, newUserPw);
		
		if(result > 0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}
	//회원가입
	public int insertUserSite(UserSite usersite) {
		Connection conn = JDBCTemplate.getConnection();
		
		String encPw = BCrypt.hashpw(usersite.getUserPw(), BCrypt.gensalt());
		System.out.println("encPw: " + encPw);
		usersite.setUserPw(encPw);
		
		int result = dao.insertUserSite(conn, usersite);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);	
		return result;
			
		}
	
	public int idDuplChk(String userId) {
		Connection conn = JDBCTemplate.getConnection();
		int result = dao.idDuplChk(conn, userId);
		JDBCTemplate.close(conn);
		return result;
		

}
	// 로그인 BCrypt사용
	public UserSite userLogin(String loginId, String loginPw) {
		Connection conn = JDBCTemplate.getConnection();
		UserSite Usersite = dao.userLogin(conn, loginId);
		
		JDBCTemplate.close(conn);
		
		if(Usersite == null) {
			return null;
		} else {
			boolean login = BCrypt.checkpw(loginPw, Usersite.getUserPw()); //평문과 암호화된 데이터가 일치하는가?
			
			if(login) {
				return Usersite;
			} else {
				return null;
			}
			
		}
		
		
	}
	public ArrayList<Post> selMyPosts(String postTypeId,int reqPg, int pgSize) {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Post> list  = dao.selectAllPostsList(postTypeId, reqPg, pgSize, conn);
		JDBCTemplate.close(conn);
		return list;
	}
	
	public PageData pageList(Pagination pageInfo) {
		int totCnt = commonServ.totalPostCnt(pageInfo.getPstTypeId());
		pageInfo.setTotCnt(totCnt);
		PageData pd = commonServ.Pagination(pageInfo);
		return pd;
	}

	public int allPostSelDel(String postIdArr) {
		Connection conn = JDBCTemplate.getConnection();
		StringTokenizer st = new StringTokenizer(postIdArr, "/");
		boolean rsltChk = true;
		while (st.hasMoreTokens()) {
			String postId = st.nextToken();
			int result = dao.allPostSelDel(conn, postId);
			if (result < 1) {
				rsltChk = false;
				break;
			}
		}
		if (rsltChk) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		if (rsltChk) {
			return 1;
		} else {
			return 0;
		}
	}
	public int updateUserInfo(String userNo, String updNickname, String updUserPhone, int type) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = dao.updateUserPhone(conn, userNo, updNickname ,updUserPhone, type);
		
		if(result > 0) {
			result = dao.updateUserNickname(conn, userNo, updNickname);
			
			if(result > 0) {
				JDBCTemplate.commit(conn);
			}else {
				JDBCTemplate.rollback(conn);
			}
		}
		
		JDBCTemplate.close(conn);
		return result;
	}
	
	//이메일로 아이디 찾기
	public String srchInfoId(String userEmail) {
		Connection conn = JDBCTemplate.getConnection();
		String userId = dao.srchInfoId(conn, userEmail);
		JDBCTemplate.close(conn);
		
		
		return userId;
	}
	
	//이메일과 아이디로 비밀번호 찾기 - 이메일 전송
	    public String srchInfoPw(String userId, String userEmail) {
	       Connection conn = JDBCTemplate.getConnection();
	       String toEmail = dao.srchInfoPw(conn, userId, userEmail);
	       JDBCTemplate.close(conn);
	       return toEmail;
	    }

	    public int updateUserPw(String userId, String newUserPw) {
	       Connection conn = JDBCTemplate.getConnection();
	       
	       newUserPw = BCrypt.hashpw(newUserPw, BCrypt.gensalt());   //새 비밀번호 암호화
	       int result = dao.updateUserPw(conn, userId, newUserPw);
	       
	       if(result > 0) {
	          JDBCTemplate.commit(conn);
	       } else {
	          JDBCTemplate.rollback(conn);
	       }
	       JDBCTemplate.close(conn);
	       
	       return result;
	    }

		public int userIdChk(String userId) {
			Connection conn = JDBCTemplate.getConnection();
			
			int result = dao.userIdChkSite(conn, userId);
			if(result == 0) {
				result = dao.userIdChkNaver(conn, userId);
			}
			JDBCTemplate.close(conn);
			
			return result;
		}
		public ArrayList<Post> selectIndexLikedList(String userNo) {
			Connection conn = JDBCTemplate.getConnection();
			ArrayList<Post> list = dao.selectIndexLikedList(conn, userNo);
			JDBCTemplate.close(conn);
			return list;
		}
		public ArrayList<Post> selectIndexPostList() {
			Connection conn = JDBCTemplate.getConnection();
			ArrayList<Post> list = dao.selectIndexPostList(conn);
			JDBCTemplate.close(conn);
			return list;
		}

		public ArrayList<Comment> selectIndexCommentList() {
			Connection conn = JDBCTemplate.getConnection();
			ArrayList<Comment> list = dao.selectIndexCommentList(conn);
			;
			JDBCTemplate.close(conn);
			return list;
		}

		

		public Pagination pagiNationPost(String mapAddr, String pstTypeId, int reqPage, int pageSize,
			ArrayList<?> list, int pOrC, String userNo) {
		Pagination pgInfo = new Pagination();
		pgInfo.setMapAddr(mapAddr);
		pgInfo.setPstTypeId(pstTypeId);
		pgInfo.setReqPage(reqPage);
		pgInfo.setPageSize(pageSize);
		pgInfo.setList(list);
		pgInfo.setPOrC(pOrC);
		return pgInfo;
		}

		public PageData pageListPost(Pagination pageInfo, int page) {
			int totCnt = commonServ.totalPostCnt(pageInfo.getPstTypeId());
			pageInfo.setTotCnt(totCnt);
			PageData pd = Pagination(pageInfo, page);
			return pd;
		}

		public ArrayList<Comment> selectCommentList(String userNo, int reqPage, int pageSize) {
			Connection conn = JDBCTemplate.getConnection();
			ArrayList<Comment> cList = dao.selectCommentList(conn,userNo, reqPage, pageSize);
			JDBCTemplate.close(conn);
			return cList;
		}
		public ArrayList<Post> selectPostList(String userNo, String postTypeId, int reqPage, int pageSize) {
			Connection conn = JDBCTemplate.getConnection();
			ArrayList<Post> pList = null;
			pList = dao.selectPostList(conn, userNo, postTypeId, reqPage, pageSize);
			JDBCTemplate.close(conn);
			return pList;
		}
		public ArrayList<Post> selectLikedPostList(String userNo, String postTypeId, int reqPage, int pageSize) {
			Connection conn = JDBCTemplate.getConnection();
			ArrayList<Post> pList = null;
			pList = dao.selectLikedPostList(conn,userNo, reqPage, pageSize);
			JDBCTemplate.close(conn);
			return pList;
		}

		public Pagination pagiNationCmt(String mapAddr, int reqPage, int pageSize, ArrayList<Comment> pgList,
				int pOrC, String userNo) {
			Pagination pgInfo = new Pagination();
			pgInfo.setMapAddr(mapAddr);
			pgInfo.setReqPage(reqPage);
			pgInfo.setPageSize(pageSize);
			pgInfo.setList(pgList);
			pgInfo.setPOrC(pOrC);
			return pgInfo;
		}

		public PageData pageListCmt(Pagination pageInfo, int page) {
			int totCnt = commonServ.totalCmntCnt();
			pageInfo.setTotCnt(totCnt);
			PageData pd = Pagination(pageInfo, page);
			return pd;
		}
		
		public PageData Pagination(Pagination pgInfo, int page) {
			Connection conn = JDBCTemplate.getConnection();
			String mapAddr = pgInfo.getMapAddr();
			String userNo = pgInfo.getUserNo();
			int reqPage = pgInfo.getReqPage(); // 현재 페이지, 매개변수로 받아옴
			int pageSize = pgInfo.getPageSize();// 한 페이지당 게시글 수, 매개변수로 받아옴 15, 30, 50
			int totCnt = pgInfo.getTotCnt();
			int pOrC = pgInfo.getPOrC();
			System.out.println("common pOrC : "+pOrC);
			ArrayList<?> list = pgInfo.getList();
			int totPage = 0;
			String pageNavi = null;
			/*
			 * **README** Service.java내 ArrayList<vo객체명> list = dao.객체명List(conn, postType);
			 * 하여 list받아오고, 해당 list를 pagination호출시 매개변수로 넣어줄 것 int endPg = reqPage *
			 * pageSize; // 끝 페이지 int startPg = endPg-pageSize+1; // 시작 페이지
			 */
			if(pOrC>0) {
				if (totCnt % pageSize > 0) {
					totPage = totCnt / pageSize + 1;

				} else {
					totPage = totCnt / pageSize;
				}
				// 페이지 하단에 보여질 페이지 네비게이션 사이즈[1,2,3] or [1,2,3,4,5]
				int pageNavSize = 5;

				int pageNo = ((reqPage - 1) / pageNavSize) * pageNavSize + 1;// 페이지번호 연산식
				pageNavi = "<ul class='pagination cirtle-style'>";

				if (pageNo != 1) {
					pageNavi += "<li>";
					pageNavi += "<a class='page-item' href='" + mapAddr + "?page="+page+"&pOrC="+pOrC+"&reqPage=" + (pageNo - 1) + "&pageSize=" + pageSize +"&userNo="+userNo+ "'>";
					pageNavi += "<span class='material-icons'>chevron_left</span>";
					pageNavi += "</li>";
				}

				for (int i = 0; i < pageNavSize; i++) {
					pageNavi += "<li>";
					// 선택한 페이지와 선택하지 않은 페이지를 시각적으로 다르게 표현
					if (reqPage == pageNo) {
						pageNavi += "<a class='page-item active-page' href='" + mapAddr + "?page="+page+"&pOrC="+pOrC+"&reqPage=" + pageNo
								+ "&pageSize=" + pageSize+"&userNo="+userNo
								+ "'>";
					} else {
						pageNavi += "<a class='page-item' href='" + mapAddr + "?page="+page+"&pOrC="+pOrC+"&reqPage=" + pageNo + "&pageSize=" + pageSize+"&userNo="+userNo + "'>";
					}

					pageNavi += pageNo + "</a></li>";
					pageNo++;

					if (pageNo > totPage) {
						break;
					}
				}
				if (pageNo <= totPage) {
					pageNavi += "<li>";
					pageNavi += "<a class='page-item' href='" + mapAddr + "?page="+page+"&pOrC="+pOrC+"&reqPage=" + pageNo +"&pageSize=" + pageSize+"&userNo="+userNo + "'>";
					pageNavi += "<span class='material-icons'>chevron_right</span>";
					pageNavi += "</li>";
				}
				pageNavi += "</ul>";
				
			}else if(pOrC == 0) {
				if (totCnt % pageSize > 0) {
					totPage = totCnt / pageSize + 1;

				} else {
					totPage = totCnt / pageSize;
				}
				// 페이지 하단에 보여질 페이지 네비게이션 사이즈[1,2,3] or [1,2,3,4,5]
				int pageNavSize = 5;

				int pageNo = ((reqPage - 1) / pageNavSize) * pageNavSize + 1;// 페이지번호 연산식
				pageNavi = "<ul class='pagination cirtle-style'>";

				if (pageNo != 1) {
					pageNavi += "<li>";
					pageNavi += "<a class='page-item' href='" + mapAddr + "?page="+page+"&pOrC="+pOrC+"&reqPage=" + (pageNo - 1) +"&pageSize=" + pageSize+"&userNo="+userNo + "'>";
					pageNavi += "<span class='material-icons'>chevron_left</span>";
					pageNavi += "</li>";
				}

				for (int i = 0; i < pageNavSize; i++) {
					pageNavi += "<li>";
					// 선택한 페이지와 선택하지 않은 페이지를 시각적으로 다르게 표현
					if (reqPage == pageNo) {
						pageNavi += "<a class='page-item active-page' href='" + mapAddr + "?page="+page+"&pOrC="+pOrC+"&reqPage=" + pageNo
								+ "&pageSize=" + pageSize+"&userNo="+userNo+"&userNo="+userNo
								+ "'>";
					} else {
						pageNavi += "<a class='page-item' href='" + mapAddr + "?page="+page+"&pOrC="+pOrC+"&reqPage=" + pageNo+ "&pageSize=" + pageSize+"&userNo="+userNo + "'>";
					}

					pageNavi += pageNo + "</a></li>";
					pageNo++;

					if (pageNo > totPage) {
						break;
					}
				}
				if (pageNo <= totPage) {
					pageNavi += "<li>";
					pageNavi += "<a class='page-item' href='" + mapAddr + "?page="+page+"&pOrC="+pOrC+"&reqPage=" + pageNo +"&pageSize=" + pageSize + "'>";
					pageNavi += "<span class='material-icons'>chevron_right</span>";
					pageNavi += "</li>";
				}
				pageNavi += "</ul>";
				
			}
			PageData pd = new PageData();
			pd.setList(list);//
			pd.setPageNavi(pageNavi);
			JDBCTemplate.close(conn);

			return pd;
		}
		
}
