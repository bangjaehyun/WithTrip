package kr.or.iei.user.controller;

import java.io.IOException;
import java.security.SecureRandom;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import kr.or.iei.user.model.service.UserService;

/**
 * Servlet implementation class UserSrchInfoPwServlet
 */
@WebServlet("/user/srchInfoPw")
public class UserSrchInfoPwServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserSrchInfoPwServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userEmail = request.getParameter("userEmail");
		String userId = request.getParameter("userId");
		
		UserService service = new UserService();
		String toEmail = service.srchInfoPw(userId, userEmail);
		
		if(toEmail != null) {
			String upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";	//영문자 대문자
			String lower = "abcdefghijklmnopqrstuvwxyz";	//영문자 소문자
			String digit = "0123456789";					//숫자
			String special = "!@#$";						//특수문자
			String allStr = upper + lower + digit + special;
			
			SecureRandom random = new SecureRandom();
			StringBuilder ranPw = new StringBuilder();
			
			//대문자, 소문자, 숫자, 특수문자 각각 최소 1개씩은 임시 비밀번호에 포함되도록
			ranPw.append(upper.charAt(random.nextInt(upper.length())));			//대문자 중 1개 문자
			ranPw.append(lower.charAt(random.nextInt(lower.length())));			//소문자 중 1개 문자
			ranPw.append(digit.charAt(random.nextInt(digit.length())));			//숫자 중 1개 문자
			ranPw.append(special.charAt(random.nextInt(special.length())));		//특수문자 중 1개 문자
			
			//나머지 6자리는 전체 문자열에서 임의의 값 추출
			for (int i=0; i<6; i++) {
				ranPw.append(allStr.charAt(random.nextInt(allStr.length())));
			}
			
			//여기까지 진행하면, 임시 비밀번호 10자리는 만들어진다. 단, 첫 4글자의 형태가 고정이므로 무작위로 섞어주기
			char [] allChars = ranPw.toString().toCharArray();		///임시비밀번호를 10자리의 배열로 만들어줌
			for(int i = 0; i<allChars.length; i++) {
				int ranIdx = random.nextInt(allChars.length);	//0 ~ 9 중, 난수 발생
				
				//현재 i 번째 인덱스 요소 값과 난수번째에 있는 요소값이랑 바꿔치기
				char temp = allChars[i];		
				allChars[i] = allChars[ranIdx];
				allChars[ranIdx] = temp;
			}
			
			//최종적으로 임시 비밀번호가 들어있는 allChars(배열)을 String으로 변환
			String newPw = new String(allChars);
			
			//DB 업데이트
			
			int result = service.updateUserPw(userId, newPw);
			
			if (result > 0) {
				System.out.println("DB 업데이트 완료");
				
				
				Properties prop = new Properties();
				prop.put("mail.smtp.host", "smtp.naver.com");
				prop.put("mail.smtp.port", 465);
				prop.put("mail.smtp.auth", "true");
				prop.put("mail.smtp.ssl.enable", "true");
				prop.put("mail.smtp.ssl.trust", "smtp.naver.com");
				
				//2. 세션 설정 및 인증 정보 설정
				Session session = Session.getDefaultInstance(prop, new Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication("wodnjs5027@naver.com", "wodnjs9950272788");
					}
				
				});
				
				//3. 이메일 관련 정보 세팅
				MimeMessage msg = new MimeMessage(session);
				
				try {
					msg.setSentDate(new Date());
					msg.setFrom(new InternetAddress("wodnjs5027@naver.com", "KH정보교육원 강남2관 M강의장"));
					
					//수신자
					InternetAddress to = new InternetAddress(toEmail);
					msg.setRecipient(Message.RecipientType.TO, to);
					
					msg.setSubject("임시 비밀번호 발급 안내");
					msg.setContent("회원님의 임시 비밀번호는 [<span style = 'color:red; font-weight:bold;'>" + newPw + "</span>] 입니다.", "text/html; charset = utf-8");
				
					Transport.send(msg);
				} catch (MessagingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				//임시 비번 생성 후, 이메일 전송 완료
				response.getWriter().print("0");
			}else {
				response.getWriter().print("1");
			}
			
		}else {
			response.getWriter().print("2");
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
