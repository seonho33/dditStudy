package kr.or.ddit.http;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.URLConnection;
import java.util.StringTokenizer;

public class MyHttpServer {
	
	private static final int PORT = 80;
	private static final String ENCODING = "UTF-8";
	/*
	 * request Line Get_/main/index
	 * Header	
	 * 
	 * Body
	 * 
	*/
	
	//시작 메서드
	public void start() {
		
		System.out.println("HTTP 서버가 시작되었습니다.");
		
		try(ServerSocket server = new ServerSocket(PORT)) {
			
			while(true) {
				Socket socket = server.accept();
				
				HttpHandler handler = new HttpHandler(socket);
				handler.start();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * Http 요청 처리를 위한 스레드
	 */
	private class HttpHandler extends Thread {
		private Socket socket;
		
		public HttpHandler(Socket socket) {
			this.socket = socket;
		}

		@Override
		public void run() {
			
			BufferedOutputStream bos = null;	//응답 메시지 전송용
			BufferedReader br = null;			//요청 메시지 수신용
			
			try {
				bos = new BufferedOutputStream(socket.getOutputStream());
				br = new BufferedReader(new InputStreamReader(socket.getInputStream()));
				
				// 요청 메시지 헤더정보 파싱하기
				
				// Request Line 
				String reqLine = br.readLine();	// 헤더 첫줄은 요청라인...
				
				/* System.out.println("reqLine => " + reqLine); */
				
				
				// 요청 페이지 정보 가져오기
				String reqPath = "";	//토큰 정보를 담기위함
				StringTokenizer st = new StringTokenizer(reqLine," "); //두번째 파라미터를 기준으로 Token화 시킴	
				while(st.hasMoreTokens()) {
					String token = st.nextToken();
					if(token.startsWith("/")) {
						reqPath = token;	//요청 경로 설정
						break;
					}
				}
				
				System.out.println("reqPath : " + reqPath);
				
				String filePath = "./WebContent" + reqPath;
				
				//해당 파일이름 기준으로 Content-type 정보 추출하기
				String contentType = 
						URLConnection.getFileNameMap()
							.getContentTypeFor(filePath);
				
				System.out.println("contentType : " + contentType);
				
				File file = new File(filePath);
				
				if(!file.exists()) {
					//에러 페이지 발송...
					return;
				}
				
				byte[] body = makeResponseBody(filePath);
				
				byte[] header = 
						makeResponseHeader(body.length, contentType);
				
				
				//응답 메시지 보내기...
				bos.write(header);
				bos.write("\r\n\r\n".getBytes()); //Empty Line 전송
				bos.write(body);
				bos.flush();
				
				
			} catch (IOException e) {
				e.printStackTrace();
			}finally {
				try {
					br.close();
					bos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	/**
	 * 응답 헤더 생성하기...
	 * @param length 응답 내용 크기
	 * @param contentType MIME타입 정보
	 * @return 헤더 내용을 담은 바이트 배열
	 */
	private byte[] makeResponseHeader(int length, String contentType) {
		
		String header = "HTTP/1.1 200 OK\r\n"
					+ "Server: MyHTTPServer 1.0\r\n"
					+ "Content-length: " + length + "\r\n"
					+ "Content-type: " + contentType + "; charset="
					+ ENCODING + " \r\n";
		
		return header.getBytes();
	}
	
	/**
	 * 응답내용 생성하기
	 * @param filePath 응답으로 사용할 파일경로
	 * @return 응답내용으로 사용할 바이트 배열 데이터
	 */
	private byte[] makeResponseBody(String filePath) {

		byte[] data = null;
		
		try(FileInputStream fis = new FileInputStream(filePath)){
			
			File file = new File(filePath);
			data = new byte[(int)file.length()];
			
			fis.read(data);	// 파일 내용 읽어서 바이트 배열에 담기
			
			
		}catch(IOException ex) {
			ex.printStackTrace();
		}
		
		return data;
	}
	
	public static void main(String[] args) {
		new MyHttpServer().start();
	}

}

