package kr.or.ddit.Tcp;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class TcpChatServer {
	public static void main(String[] args) throws IOException {
		
		/*
			서버소켓 객체를 생성하고, 클라이언트가 접속하면 생성된 소켓을 이용하여
			클라이언트와 통신(대화) 한다. 이때 송신 및 수신 작업을 위한 스레드를
			생성하여 처리한다.
		*/
		
		ServerSocket server = new ServerSocket(7777);
		System.out.println("채팅서버 준비완료...");
		Socket socket = server.accept();
		
		Sender sender = new Sender(socket);
		sender.start();
			
		Receiver receiver = new Receiver(socket);
		receiver.start();
		
	}
}