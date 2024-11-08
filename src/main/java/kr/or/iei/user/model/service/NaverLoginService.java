package kr.or.iei.user.model.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import kr.or.iei.common.JDBCTemplate;
import kr.or.iei.user.model.dao.NaverLoginDao;
import kr.or.iei.user.model.vo.UserNaver;

public class NaverLoginService {
	NaverLoginDao dao;
	String id;
	String email;
	String mobile;
	
	public UserNaver createToken(String code, String state) {
		String clientId = "Oc8PVM4NwTiYL085dBsK";
		String clientSecret = "9jPa31qAEO";
		
		Connection conn = JDBCTemplate.getConnection();
		
		try {
			String redirectURI = URLEncoder.encode("http://localhost:80", "UTF-8");//네이버 로그인 성공 시 리다이렉트되는 URL
			String apiURL;
			apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";//접근 토큰의 발급 갱신 삭제 요청
			apiURL += "client_id=" + clientId;
			apiURL += "&client_secret=" + clientSecret;
			apiURL += "&redirect_uri=" + redirectURI;
			apiURL += "&code=" + code;
			apiURL += "&state=" + state;
			String access_token = "";//삭제처리된 접근토큰 = 스타트에서 넘겨줄때 if문 넣고 값이 비어있으면 refresh token???
			String refresh_token = "";//갱신토큰(접근 토큰 만료되었을 때 사용)

			URL url = new URL(apiURL);//설정한 ApiURL HttpURLConnection으로 전달 
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();//정상 작동인지 or 오류가 발생했는지 확인값을 responseCode로 받음
			BufferedReader br;
//		      System.out.print("responseCode="+responseCode);
			if (responseCode == 200) { // 정상 호출코드 = 200
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { //다른 숫자는 에러 발생 추가적으로 오류코드 넣어서 왜 오류 뜨는지 알려주기?
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer res = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {//br.readLine()???
				res.append(inputLine);
			}
			br.close();//버퍼리더 닫기
			if (responseCode == 200) {
				JParser(res.toString());//네이버에서 토큰 받아오고 정상작동하면 JParser로 전달\
				
				UserNaver n = dao.naverLogin(conn, id, email, mobile);
				n.setUserId(id);
				n.setUserEmail(email);
				n.setUserPhone(mobile);				
				
				return n;
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		JDBCTemplate.close(conn);
		return null;
	}
	
	
	public void JParser(String json) {
		JSONParser parser = new JSONParser();//JSONParser 선언	    
	    Object obj;
	    
		try {
			obj = parser.parse(json);
			
			JSONObject jsonObj = (JSONObject) obj;
			
		    String access_token = (String) jsonObj.get("access_token");//API 요청에 필요한 인증 토큰.
		    
		    NaverLoginService service = new NaverLoginService();//선언만 하고 안쓴다???
		    start(access_token);//토큰을 스타트에 넘겨줌
			
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

	public void start(String token) {
		String header = "Bearer " + token; // Bearer : 접근 토큰 타입
		try {
			String apiURL = "https://openapi.naver.com/v1/nid/me";//네이버 회원의 프로필을 조회하는 url
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Authorization", header); //HTTP 요청의 Authorization 헤더에 포함될 값으로, 액세스 토큰을 포함.
			//Authorization : 접근 토큰을 전달하는 헤더 토큰 타입은 Bearer로 고정되어 있음	
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();
			System.out.println(responseCode);
			System.out.println(response.toString());
			loginInfo(response.toString());
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	
	public void loginInfo(String response){
		JSONParser parser = new JSONParser();//JSONParser 선언	    
	    Object obj;
	    
		try {
			obj = parser.parse(response);
			
			JSONObject jsonObj = (JSONObject) obj;
			
			JSONObject responseObj = (JSONObject) jsonObj.get("response");
			
		     id = (String) responseObj.get("id");
		     email = (String) responseObj.get("email");
		     mobile = (String) responseObj.get("mobile");
		    
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

}
