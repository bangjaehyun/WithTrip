package kr.or.iei.festival.model.service;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import kr.or.iei.festival.model.vo.FestivalMain;
import kr.or.iei.festival.model.vo.FestivalSubInfo;

public class FestivalService {

	public ArrayList<FestivalMain> festivalLoad(String startDay, String endDay, String numOfRows, String pageNo) {

		// 1. URL을 만들기 위한 StringBuilder.
		StringBuilder urlBuilder = new StringBuilder(
				"http://apis.data.go.kr/B551011/KorService1/searchFestival1"); /* URL */

		BufferedReader rd = null;
		HttpURLConnection conn = null;
		StringBuilder sb = new StringBuilder();
		try {
			urlBuilder.append(
					"?" + URLEncoder.encode("eventStartDate", "UTF-8") + "=" + URLEncoder.encode(startDay, "UTF-8")); // 시작일
			urlBuilder.append(
					"&" + URLEncoder.encode("eventEndDate", "UTF-8") + "=" + URLEncoder.encode(endDay, "UTF-8")); // 종료일
			urlBuilder.append("&" + URLEncoder.encode("areaCode", "UTF-8") + "=" + URLEncoder.encode("", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("sigunguCode", "UTF-8") + "=" + URLEncoder.encode("", "UTF-8"));
			// 2. 오픈 API의요청 규격에 맞는 파라미터 생성, 발급받은 인증키.
			urlBuilder.append("&" + URLEncoder.encode("ServiceKey", "UTF-8") + "="
					+ URLEncoder.encode(
							"AfQfhsnbGileldKwUWQ+BO/64/UexpjEbEYOo6OQNcKt8jfPaOeYcnuLn+I44uDmsfXhYgjRlkPAfbIl/suZxw==",
							"UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("listYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("MobileOS", "UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8"));
			urlBuilder.append(
					"&" + URLEncoder.encode("MobileApp", "UTF-8") + "=" + URLEncoder.encode("AppTest", "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("arrange", "UTF-8") + "=" + URLEncoder.encode("A", "UTF-8"));
			urlBuilder.append(
					"&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode(numOfRows, "UTF-8"));
			urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode(pageNo, "UTF-8"));

			// 3. URL 객체 생성.
			URL url = new URL(urlBuilder.toString());
			// 4. 요청하고자 하는 URL과 통신하기 위한 Connection 객체 생성.
			conn = (HttpURLConnection) url.openConnection();
			// 5. 통신을 위한 메소드 SET.
			conn.setRequestMethod("GET");
			// 6. 통신을 위한 Content-type SET.
			conn.setRequestProperty("Content-type", "application/json");
			// 7. 통신 응답 코드 확인.
			System.out.println("Response code: " + conn.getResponseCode());
			// 8. 전달받은 데이터를 BufferedReader 객체로 저장.

			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			// 9. 저장된 데이터를 라인별로 읽어 StringBuilder 객체로 저장.

			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}

		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				// 10. 객체 해제.
				rd.close();
				conn.disconnect();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		ArrayList<FestivalMain> list = new ArrayList<FestivalMain>();

		try {
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			System.out.println(sb.toString());
			InputStream is = new ByteArrayInputStream(sb.toString().getBytes());
			Document doc = builder.parse(is);
			NodeList nodes = doc.getElementsByTagName("item");

			for (int i = 0; i < nodes.getLength(); i++) {
				Node nNode = nodes.item(i);
				Element element = (Element) nNode;

				FestivalMain festival = new FestivalMain();
				festival.setFestivalId(element.getElementsByTagName("contentid").item(0).getTextContent());
				festival.setFestivalType(element.getElementsByTagName("contenttypeid").item(0).getTextContent());
				festival.setFestivalImage(element.getElementsByTagName("firstimage").item(0).getTextContent());
				festival.setFestivalTitle(element.getElementsByTagName("title").item(0).getTextContent());

				list.add(festival);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;

	}

	public ArrayList<FestivalSubInfo> subInfo(String festivalId, String festivalType) {
		StringBuilder urlBuilder = new StringBuilder(
				"http://apis.data.go.kr/B551011/KorService1/detailCommon1"); /* URL */

		BufferedReader rd = null;
		HttpURLConnection conn = null;
		StringBuilder sb = new StringBuilder();
		try {
			urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "="
					+ URLEncoder.encode(
							"AfQfhsnbGileldKwUWQ+BO/64/UexpjEbEYOo6OQNcKt8jfPaOeYcnuLn+I44uDmsfXhYgjRlkPAfbIl/suZxw==",
							"UTF-8"));
			urlBuilder.append(
					"&" + URLEncoder.encode("contentTypeId", "UTF-8") + "=" + URLEncoder.encode(festivalType, "UTF-8"));
			urlBuilder.append(
					"&" + URLEncoder.encode("contentId", "UTF-8") + "=" + URLEncoder.encode(festivalId, "UTF-8"));
			urlBuilder.append(
					"&MobileOS=ETC&MobileApp=AppTest&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y");
			
			// 3. URL 객체 생성.
			URL url = new URL(urlBuilder.toString());
			// 4. 요청하고자 하는 URL과 통신하기 위한 Connection 객체 생성.
			conn = (HttpURLConnection) url.openConnection();
			// 5. 통신을 위한 메소드 SET.
			conn.setRequestMethod("GET");
			// 6. 통신을 위한 Content-type SET.
			conn.setRequestProperty("Content-type", "application/json");
			// 7. 통신 응답 코드 확인.
			System.out.println("Response code: " + conn.getResponseCode());
			// 8. 전달받은 데이터를 BufferedReader 객체로 저장.

			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			// 9. 저장된 데이터를 라인별로 읽어 StringBuilder 객체로 저장.

			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} // 시작일
		catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		ArrayList<FestivalSubInfo> list = new ArrayList<FestivalSubInfo>();

		try {
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			System.out.println(sb.toString());
			InputStream is = new ByteArrayInputStream(sb.toString().getBytes());
			Document doc = builder.parse(is);
			NodeList nodes = doc.getElementsByTagName("item");

			for (int i = 0; i < nodes.getLength(); i++) {
				Node nNode = nodes.item(i);
				Element element = (Element) nNode;

				FestivalSubInfo festival = new FestivalSubInfo();
				festival.setFestivalAddr(element.getElementsByTagName("addr1").item(0).getTextContent());
				festival.setFestivalLat(element.getElementsByTagName("mapx").item(0).getTextContent());
				festival.setFestivalLng(element.getElementsByTagName("mapy").item(0).getTextContent());
				festival.setFestivalTitle(element.getElementsByTagName("title").item(0).getTextContent());
				festival.setFestivalContent(element.getElementsByTagName("overview").item(0).getTextContent());
				festival.setFestivalTel(element.getElementsByTagName("tel").item(0).getTextContent());
				list.add(festival);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
		
	}

}
