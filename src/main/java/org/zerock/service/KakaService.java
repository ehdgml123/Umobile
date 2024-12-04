package org.zerock.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.KakaoVO;
import org.zerock.domain.UserVO;
import org.zerock.mapper.UserMapper;

import lombok.extern.log4j.Log4j;


import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;


import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;




@Service
@Log4j
public class KakaService {

	@Autowired
	private UserMapper usermapper;
	
	public String getToken(String code) throws IOException {
	    String host = "https://kauth.kakao.com/oauth/token";
	    HttpURLConnection urlConnection = null;
	    String token = "";

	    try {
	        URL url = new URL(host);
	        urlConnection = (HttpURLConnection) url.openConnection();
	        urlConnection.setRequestMethod("POST");
	        urlConnection.setDoOutput(true);
	        urlConnection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

	        try (BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(urlConnection.getOutputStream()))) {
	            StringBuilder sb = new StringBuilder();
	            sb.append("grant_type=authorization_code");  // 수정된 부분
	            sb.append("&client_id=29a88f9c94b409047dcee5163c7e4d8c");
	            sb.append("&redirect_uri=http://localhost:8282/user/login/oauth2/code/kakao");  // 고정된 값 사용
	            sb.append("&code=").append(code);

	            bw.write(sb.toString());
	            bw.flush();
	        }

	        int responseCode = urlConnection.getResponseCode();
	        log.info("responseCode = " + responseCode);

	        if (responseCode == 200) { // 성공한 경우만 처리
	            StringBuilder result = new StringBuilder();
	            try (BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()))) {
	                String line;
	                while ((line = br.readLine()) != null) {
	                    result.append(line);
	                }
	            }

	            log.info("result = " + result.toString());

	            JsonParser parser = new JsonParser();
	            JsonObject elem = parser.parse(result.toString()).getAsJsonObject();

	            token = elem.get("access_token").getAsString();
	        } else {
	            log.error("Failed to get token. Response code: " + responseCode);
	        }

	    } catch (IOException e) {
	        log.error("Error occurred: " + e.getMessage(), e);
	        throw e;
	    } finally {
	        if (urlConnection != null) {
	            urlConnection.disconnect();
	        }
	    }

	    return token;
	}
	
	public KakaoVO userInfo(String access_Token) throws IOException {
	    log.info("사용자 정보 가져오기 시작------------------------");
	    KakaoVO userInfo = new KakaoVO();

	    String reqURl = "https://kapi.kakao.com/v2/user/me";

	    try {
	        URL url = new URL(reqURl);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Authorization", "Bearer " + access_Token);

	        int responseCode = conn.getResponseCode();
	        log.info("응답 코드: " + responseCode);

	        if (responseCode == 200) {  // 성공한 경우에만 처리
	            StringBuilder result = new StringBuilder();
	            try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
	                String line;
	                while ((line = br.readLine()) != null) {
	                    result.append(line);
	                }
	            }

	            log.info("카카오 사용자 정보 응답 내용: " + result.toString());  // 전체 응답 로그 출력

	            JsonParser parser = new JsonParser();
	            JsonObject element = parser.parse(result.toString()).getAsJsonObject();

	            if (element.has("properties")) {
	                JsonObject properties = element.get("properties").getAsJsonObject();
	                String nickname = properties.has("nickname") ? properties.get("nickname").getAsString() : null;
	                userInfo.setNickname(nickname);
	                log.info("nickname: " + nickname);
	            } else {
	                log.warn("properties 객체가 존재하지 않습니다.");
	            }

	            if (element.has("kakao_account")) {
	                JsonObject kakao_account = element.get("kakao_account").getAsJsonObject();
	                String email = kakao_account.has("email") ? kakao_account.get("email").getAsString() : null;
	                userInfo.setKakaoEmail(email);
	                log.info("email: " + email);
	            } else {
	                log.warn("kakao_account 객체가 존재하지 않습니다.");
	            }

	            long id = element.has("id") ? element.get("id").getAsLong() : -1;
	            userInfo.setKakaoId(id);
	            log.info("id: " + id);

	        } else {
	            log.error("사용자 정보를 가져오는 데 실패했습니다. 응답 코드: " + responseCode);
	        }

	    } catch (Exception e) {
	        log.error("사용자 정보 가져오는 중 예외 발생: " + e.getMessage(), e);
	    }

	    return userInfo;
	}
	
	public void setAuthenticationWithSession(String email, HttpSession session) {
	    // 1. 데이터베이스에서 사용자 정보 가져오기
	    UserVO kakaouser = usermapper.findByUsername(email);

	    // 2. 사용자 정보를 세션에 저장하기
	    session.setAttribute("user", kakaouser);

	    // 3. 추가로 필요한 데이터를 세션에 저장할 수 있음
	    session.setAttribute("isAuthenticated", true);
	}
	
}
