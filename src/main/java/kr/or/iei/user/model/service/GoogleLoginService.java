package kr.or.iei.user.model.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import kr.or.iei.common.JDBCTemplate;
import kr.or.iei.user.model.dao.GoogleLoginDao;
import kr.or.iei.user.model.vo.GoogleApiSetting;
import kr.or.iei.user.model.vo.UserGoogle;

public class GoogleLoginService {
    private GoogleLoginDao dao; // 데이터베이스 작업을 수행하는 DAO 객체
    private String email; // 사용자 이메일을 저장하는 변수
    private String clientId = GoogleApiSetting.googleClientId; // Google API 클라이언트 ID
    private String clientSecret = GoogleApiSetting.googleClientSecret; // Google API 클라이언트 비밀키
    private String redirectUrl = GoogleApiSetting.googleRedirectUrl; // 리다이렉트 URL
    private String tokenEnd = "https://oauth2.googleapis.com/token"; // 액세스 토큰 발급을 위한 엔드포인트
    private String userInfoEndpoint = "https://www.googleapis.com/oauth2/v2/userinfo"; // 사용자 정보 요청을 위한 엔드포인트

    // 기본 생성자: DAO 객체를 초기화
    public GoogleLoginService() {
        dao = new GoogleLoginDao();
    }

    // 인증 코드를 받아서 Access Token을 생성하고 사용자 정보를 반환하는 메서드
    public UserGoogle createToken(String code, String state) {
        Connection conn = JDBCTemplate.getConnection(); // 데이터베이스 연결 객체 생성
        try {
            // Google API로 요청할 URL 및 파라미터 설정
            String apiURL = tokenEnd;
            String params = "code=" + URLEncoder.encode(code, "UTF-8") // 인증 코드
                         + "&client_id=" + clientId // 클라이언트 ID
                         + "&client_secret=" + clientSecret // 클라이언트 비밀키
                         + "&redirect_uri=" + URLEncoder.encode(redirectUrl, "UTF-8") // 리다이렉트 URL
                         + "&grant_type=authorization_code"; // OAuth 2.0 인증 타입

            // URL 객체 생성 및 HTTP 연결 설정
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("POST"); // POST 요청 설정
            con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded"); // 요청 헤더 설정
            con.setDoOutput(true); // 출력 스트림을 사용하도록 설정
            // 요청 본문 작성
            try (OutputStream os = con.getOutputStream()) {
                os.write(params.getBytes());
                os.flush();
            }
            // 응답 코드 확인
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if (responseCode == HttpURLConnection.HTTP_OK) { // 200 OK
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else { // 오류 발생 시
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            // 응답 내용을 읽어오기
            StringBuilder response = new StringBuilder();
            String inputLine;
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close(); // BufferedReader 닫기

            // 응답 코드가 200이면 액세스 토큰 파싱
            if (responseCode == HttpURLConnection.HTTP_OK) {
                return parseAccessToken(response.toString(), conn);
            }else {
            }
        } catch (Exception e) {
            e.printStackTrace(); // 예외 발생 시 스택 트레이스 출력
        } finally {
            JDBCTemplate.close(conn); // 데이터베이스 연결 닫기
        }

        return null; // 실패 시 null 반환
    }

    // JSON 응답에서 액세스 토큰을 파싱하는 메서드
    public UserGoogle parseAccessToken(String json, Connection conn) {
        try {
            JSONParser parser = new JSONParser(); // JSON 파싱을 위한 객체
            JSONObject jsonObj = (JSONObject) parser.parse(json); // JSON 문자열을 객체로 파싱
            String accessToken = (String) jsonObj.get("access_token"); // 액세스 토큰 추출

            if (accessToken != null) {
                return getUserInfo(accessToken, conn); // 토큰이 유효하면 사용자 정보 요청
            }
        } catch (ParseException e) {
            e.printStackTrace(); // JSON 파싱 예외 처리
        }
        return null; // 파싱 실패 시 null 반환
    }

    // 액세스 토큰을 사용해 사용자 정보를 가져오는 메서드
    public UserGoogle getUserInfo(String token, Connection conn) {
        String header = "Bearer " + token; // Bearer 토큰 형태로 헤더 생성

        try {
            // 사용자 정보 요청을 위한 URL 객체 생성
            URL url = new URL(userInfoEndpoint);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET"); // GET 요청 설정
            con.setRequestProperty("Authorization", header); // 인증 헤더 설정

            int responseCode = con.getResponseCode(); // 응답 코드 확인
            BufferedReader br;
            if (responseCode == HttpURLConnection.HTTP_OK) { // 200 OK
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else { // 오류 발생 시
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }

            // 응답 내용을 읽어오기
            StringBuilder response = new StringBuilder();
            String inputLine;
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close(); // BufferedReader 닫기

            // 정상적으로 사용자 정보를 가져왔다면 JSON 파싱
            if (responseCode == HttpURLConnection.HTTP_OK) {
                return parseUserInfo(response.toString(), conn);
            }
        } catch (Exception e) {
            e.printStackTrace(); // 예외 발생 시 스택 트레이스 출력
        }

        return null; // 실패 시 null 반환
    }

    // 사용자 정보를 JSON으로 파싱하고 UserGoogle 객체를 반환하는 메서드
    public UserGoogle parseUserInfo(String json, Connection conn) {
    	UserGoogle userGoogle = new UserGoogle();
    	
        try {
            JSONParser parser = new JSONParser(); // JSON 파싱을 위한 객체
            JSONObject jsonObj = (JSONObject) parser.parse(json); // JSON 문자열을 객체로 파싱

            email = (String) jsonObj.get("email"); // 사용자 이메일 추출
            
            userGoogle.setUserEmail(email);

            
        } catch (ParseException e) {
            e.printStackTrace(); // JSON 파싱 예외 처리
        }
        return userGoogle; // 파싱 실패 시 null 반환
    }
}
