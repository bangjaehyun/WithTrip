package kr.or.iei.post.model.service;

import java.io.File;
import java.sql.Connection;
import java.util.ArrayList;

import kr.or.iei.common.JDBCTemplate;
import kr.or.iei.post.model.dao.PostDao;
import kr.or.iei.post.model.vo.Post;
import kr.or.iei.post.model.vo.PostComment;
import kr.or.iei.post.model.vo.PostFile;
import kr.or.iei.post.model.vo.PostPageData;
import kr.or.iei.post.model.vo.PostType;
import kr.or.iei.spot.model.vo.Spot;
import kr.or.iei.user.model.vo.User;

public class PostService {
	
	private PostDao dao;
	
	public PostService() {
		dao = new PostDao();
	}

	//공지사항 리스트 조회
	public PostPageData selectPostList(String postTypeCd, int reqPage, String postTypeNm) {
		Connection conn = JDBCTemplate.getConnection();
		
		//한 페이지에서 보여줄 게시글의 갯수
		int viewPostCnt = 10;
		
		int end = reqPage * viewPostCnt;
		int start = end - viewPostCnt + 1;
		
		ArrayList<Post> list = dao.selectPostList(conn, postTypeCd, start, end);
		
		for(Post post : list) {
			User user = dao.selectUser(conn,post.getUserNo());
			post.setUser(user);
		}
		
		//전체 게시글의 갯수
		int totCnt = dao.selectPostCount(conn, postTypeCd);
		
		//전체 페이지의 갯수
		int totPage = 0;
		
		if(totCnt % viewPostCnt > 0) {
			totPage = totCnt / viewPostCnt + 1;
		} else {
			totPage = totCnt / viewPostCnt;
		}
		
		
		//페이지 하단에 보여줄 페이지 네비게이션 사이즈
		int pageNaviSize = 5;
		
		//페이지 시작번호 연산식
		int pageNo = ((reqPage - 1) / pageNaviSize) * pageNaviSize + 1;	
		
		
		//페이지 네비게이션 HTML 태그 생성
		String pageNavi = "<ul class = 'pagination circle-style'>";
		
		//이전버튼 생성
		if(pageNo != 1) {
			//6,7,8,9,10 or 11,12,13,14,15 or 16,17,18,19,20 ................
			pageNavi += "<li>";
			pageNavi += "<a class = 'page-item' href='/post/list?reqPage=" + (pageNo - 1) + "&postTypeCd=" + postTypeCd + "&postTypeNm=" + postTypeNm+"'>";
			pageNavi += "<span class='material-icons'>chevron_left</span></a>";
			pageNavi += "</li>";
		}
		
		//페이지 네비게이션 사이즈만큼 반복하며, 태그 생성
		for( int i=0; i<pageNaviSize; i++) {
			pageNavi += "<li>";
			
			//선택한 페이지와, 선택하지 않은 페이지를 시각적으로 다르게 표현
			if(reqPage == pageNo) {
				pageNavi += "<a class='page-item active-page' href='/post/list?reqPage="+pageNo+"&postTypeCd="+postTypeCd+"&postTypeNm="+postTypeNm+"'>";
			} else {
				pageNavi += "<a class='page-item' href='/post/list?reqPage="+pageNo+"&postTypeCd="+postTypeCd+"&postTypeNm="+postTypeNm+"'>";
			}
			pageNavi += pageNo + "</a></li>";
			pageNo++;
			
			if(pageNo > totPage) {
				break;
			}
		}
		
		//시작번호 <= 전체 페이지 갯수
		if(pageNo <= totPage) {
			//6,7,8,9,10 or 11,12,13,14,15 or 16,17,18,19,20 ................
			pageNavi += "<li>";
			pageNavi += "<a class = 'page-item' href='/post/list?reqPage=" + pageNo + "&postTypeCd=" + postTypeCd + "&postTypeNm=" + postTypeNm+"'>";
			pageNavi += "<span class='material-icons'>chevron_right</span></a>";
			pageNavi += "</li>";
		}
		
		pageNavi += "</ul>";
		
		
		PostPageData pd = new PostPageData();
		pd.setList(list);
		pd.setPageNavi(pageNavi);
		
		JDBCTemplate.close(conn);		
		return pd;
	}

	/*
	//게시글 상세 보기
	public Post selectOnePost(String postNo) {
		Connection conn = JDBCTemplate.getConnection();
		
		Post p = dao.selectOnePost(conn, postNo);
		
		User user = dao.selectUser(conn, p.getUserNo());
		p.setUser(user);
		
		JDBCTemplate.close(conn); 
		return p;
	}
	*/
	
	//게시글 - 조회수 +1 처리 없이 하나 상세보기
	public Post getOnePost (String postNo) {
		Connection conn = JDBCTemplate.getConnection();
		Post p = dao.selectOnePost(conn, postNo);
		if( p != null) {
			ArrayList<PostFile> fileList = dao.selectPostFileList(conn, postNo);
			p.setFileList(fileList);
		}
		
		JDBCTemplate.close(conn);
		return p;
	}
	

	//게시글 상세보기 + 댓글
	///다양한 서블릿에서 상세보기 메소드를 호출하고 있는데, 댓글확인이 항상 있는 것이 아님 -> commentChk는 있을수도, 없을수도 있음  -> 댓글을 작성을 하고 요청하는 경우가 아니라면 commentChk 의 값은 null
	public Post selectOnePost(String postNo, String commentChk) {
		Connection conn = JDBCTemplate.getConnection();
		
		Post p = dao.selectOnePost (conn, postNo);
		//System.out.println("1" +n);
		
		//조회해온 다음에 조회수 +1 처리
		if(p != null) {
			int result = 0;	 
			//commentChk == null 인 것은, 댓글을 작성하고 상세보기 이동하는 경우를 제외한 모든 요청
			
			///일반적으로 상세보기하는 경우에는 result == 0
			if(commentChk == null) {
				result = dao.updateReadCount(conn, postNo);				
			}
			
			User user = dao.selectUser(conn, p.getUserNo());
			p.setUser(user);
			
			//게시글 파일정보 불러오기
			//commentChk != null 인 것은 댓글을 작성하고 상세보기 이동하는 경우에도, 파일 정보를 select 할 수 있도록
			if(result > 0 || commentChk != null) {
				JDBCTemplate.commit(conn);
				
				//파일 리스트, 댓글리스트 모두 1개의 게시글에 종속적인 데이터이므로, 별도의 클래스를 생성하지 않고(PostPageData.java를 만들었던것 처럼이 아니라), Notice 클래스에 변수로 추가
				ArrayList<PostFile> fileList = dao.selectPostFileList(conn, postNo);
				p.setFileList(fileList);
				
				///해당 게시글에 대한 댓글정보도 읽어와야 함
				ArrayList<PostComment> commentList = dao.selectCommentList (conn, postNo);
				p.setCommentList(commentList);
				
				for(int i =0; i<commentList.size(); i++) {
					//유저 정보 조회
					User cmtUser = dao.selectUser(conn, commentList.get(i).getUserNo());
					if(cmtUser != null) {						
						commentList.get(i).setUser(cmtUser);
					}
				}
				
			} else {
				JDBCTemplate.rollback(conn);
			}
		}
		
		JDBCTemplate.close(conn);
		
		return p;
	}
	
	//게시글 등록
		public int insertPost(Post post, ArrayList<PostFile> fileList, ArrayList<Spot> spotList) {
			Connection conn = JDBCTemplate.getConnection();
			
			String postNo = dao.selectPostNo(conn);
			post.setPostNo(postNo);
			int result = dao.insertPost(conn,post);
			
			if(result > 0) {
				boolean fileChk = true;
				for (PostFile file : fileList) {
					file.setPostNo(postNo);
					result = dao.insertPostFile(conn, file);
					
					if(result < 1) {
						JDBCTemplate.rollback(conn);
						fileChk = false;
						break;
					}
				}
				
				//commit 시점
	            if(fileChk) {
	                boolean soptChk = true;
	                for(int i =0; i < spotList.size(); i++) {
	                	String spotNo = dao.selectSpotNo(conn);
	                	spotList.get(i).setSpotNo(spotNo);
	                    result = dao.insertPostSpot(conn, spotList.get(i));
	                    if(result < 1) {
	                        JDBCTemplate.rollback(conn);
	                        soptChk = false;
	                        break;
	                    }
	                    result = dao.insertPostSpotManageMent(conn,postNo,spotNo);
	                    	
	                    if(result < 1) {
	                    JDBCTemplate.rollback(conn);
	                    soptChk = false;
	                     break;
	                    }
	                }
	                
	                if(soptChk) {
	                    JDBCTemplate.commit(conn);
	                }
				}
			}else {
				JDBCTemplate.rollback(conn);
			}
			JDBCTemplate.close(conn);
			
			return result;
		}

	//댓글 작성(등록)
	public int insertComment(PostComment comment) {
		Connection conn = JDBCTemplate.getConnection();
		
		//comment_id 임시테이블에서 생성
		String commentId = dao.selectCommentId(conn);
		comment.setCommentId(commentId);
		
		System.out.println("postService - comment 0 : " + commentId);
		
		int result = dao.insertComment(conn, comment);
		
		System.out.println("postService - comment 1 : " + comment);
		
		if(result > 0 ) {
			//댓글 작성 후 댓글관리 테이블에 넣어주기
			result = dao.insertCmtManagement(conn, comment);
			
			System.out.println("postService - comment 2 : " + comment);
			
			if(result > 0) {
				JDBCTemplate.commit(conn);
			} else {
				JDBCTemplate.rollback(conn);
			}			
		} 
		JDBCTemplate.close(conn);
		return result;
	}
	
	//댓글 삭제
	public int deleteComment(String commentId) {
		Connection conn = JDBCTemplate.getConnection();
		int result = dao.deleteComment(conn, commentId);
		
		if(result > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}

	//댓글 수정
	public int updateComment(PostComment comment) {
		Connection conn = JDBCTemplate.getConnection();
		int result = dao.updateComment(conn, comment);
		
		if(result > 0) {
			JDBCTemplate.commit(conn);
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		return result;
	}
	
	public int deletePost(String postNo, String delRootPath) {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Spot> spotList = dao.selectPostSpot(conn, postNo);
		ArrayList<PostComment> commentList = dao.selectCommentList(conn, postNo);
		ArrayList<PostFile> fileList = dao.selectPostFileList(conn, postNo);
		
		int result = dao.deletePost(conn, postNo);
		System.out.println(result);
		if(result > 0) {
			boolean chk = true;
			for(Spot spot : spotList) {
				
				result = dao.deleteSpot(conn, spot.getSpotNo());
				if(result < 1) {
					JDBCTemplate.rollback(conn);
					chk = false;
					break;
				}
			}
			
			if(chk) {
				boolean commentChk = true;
				for(PostComment comment : commentList) {
					result = dao.deleteComment(conn, comment.getCommentId());
					if(result < 1) {
						JDBCTemplate.rollback(conn);
						commentChk = false;
						break;
					}
				}
				if(commentChk) {
					for(PostFile file : fileList) {
						String delFilePath = delRootPath + file.getFilePath().substring(0,8) + "/" + file.getFilePath();
						System.out.println(file);
						System.out.println(delFilePath);
						File delfile = new File(delFilePath);// 파일 경로
						if (delfile.exists()) {
							System.out.println("삭제 완료");
							delfile.delete();
						}
					}
					
					JDBCTemplate.commit(conn);
				}
			}
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}
	
	public Post selectModifyPost(String postNo, String commentChk) {
		Connection conn = JDBCTemplate.getConnection();
		Post post = dao.selectOnePost(conn, postNo);
		post.setPostTypeNm(PostType.type[Integer.parseInt(post.getPostTypeCd())-1]);
		
		if(post != null || commentChk != null) {
			int result = 0;	 
			//commentChk == null 인 것은, 댓글을 작성하고 상세보기 이동하는 경우를 제외한 모든 요청
			
			///일반적으로 상세보기하는 경우에는 result == 0
			if(commentChk == null) {
				result = dao.updateReadCount(conn, postNo);				
			}
			
			ArrayList<Spot> spotList = dao.selectPostSpot(conn, postNo);
			if(spotList.size() > 0) {
				post.setSpotList(spotList);
			}
			
			ArrayList<PostFile> fileList = dao.selectPostFileList(conn, postNo);
			if(fileList.size() > 0) {
				post.setFileList(fileList);
			}
			
			User user = dao.selectUser(conn, post.getUserNo());
			post.setUser(user);
			
			if(result > 0 || commentChk != null) {
				JDBCTemplate.commit(conn);
				/// 해당 게시글에 대한 댓글정보도 읽어와야 함
				ArrayList<PostComment> commentList = dao.selectCommentList(conn, postNo);
				post.setCommentList(commentList);

				for (int i = 0; i < commentList.size(); i++) {
					// 유저 정보 조회
					User cmtUser = dao.selectUser(conn, commentList.get(i).getUserNo());
					if (cmtUser != null) {
						commentList.get(i).setUser(cmtUser);
					}
				}
			}else {
				JDBCTemplate.rollback(conn);
			}
			
		}
		
		JDBCTemplate.close(conn);
		
		return post;
	}


	public int modifyPost(Post post, ArrayList<PostFile> fileList, ArrayList<Spot> spotList) {
		Connection conn = JDBCTemplate.getConnection();

		int result = dao.modifyPost(conn, post);

		if (result > 0) {
			boolean fileChk = true;
			for (PostFile file : fileList) {
				result = dao.insertPostFile(conn, file);

				if (result < 1) {
					JDBCTemplate.rollback(conn);
					fileChk = false;
					break;
				}
			}

			if (fileChk) {
				ArrayList<Spot> list = dao.selectPostSpot(conn, post.getPostNo());
				boolean spotdelChk = true;
				for (Spot spot : list) {
					result = dao.deleteSpotManageMent(conn, spot.getSpotNo());
					if (result < 1) {

						JDBCTemplate.rollback(conn);
						spotdelChk = false;
						break;
					}

					result = dao.deleteSpot(conn, spot.getSpotNo());

					if (result < 1) {

						JDBCTemplate.rollback(conn);
						spotdelChk = false;
						break;
					}
				}

				if (spotdelChk) {
					boolean soptChk = true;
					for (Spot spot : spotList) {
						String spotNo = dao.selectSpotNo(conn);
						spot.setSpotNo(spotNo);
						result = dao.insertPostSpot(conn, spot);
						if (result < 1) {
							JDBCTemplate.rollback(conn);
							soptChk = false;
							break;
						}
						result = dao.insertPostSpotManageMent(conn, post.getPostNo(), spotNo);

						if (result < 1) {
							JDBCTemplate.rollback(conn);
							soptChk = false;
							break;
						}
					}

					if (soptChk) {
						boolean fileDelChk = true;
						if (post.getFileList() != null && post.getFileList().size() > 0) {
							for (PostFile removeFile : post.getFileList()) {
								result = dao.deletePostFile(conn, removeFile.getFileNo());

								if (result > 0) {
									File file = new File(removeFile.getFilePath());// 파일 경로
									if (file.exists()) {
										file.delete();
									}
								} else {
									fileDelChk = false;
									JDBCTemplate.rollback(conn);
									break;
								}
							}
						}
						if (fileDelChk) {
							JDBCTemplate.commit(conn);
						}

					}
				}

			}
		} else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);

		return result;
	}

}
