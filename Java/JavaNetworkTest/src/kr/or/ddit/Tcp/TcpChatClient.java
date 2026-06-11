package kr.or.ddit.Tcp;

import java.io.IOException;
import java.net.Socket;
import java.net.UnknownHostException;

public class TcpChatClient {
	public static void main(String[] args) throws UnknownHostException, IOException {
		
		Socket socket = new Socket("192.168.34.73",7777);
		
		System.out.println("접속완료");
		
		Sender sender = new Sender(socket);
		sender.start();
		
		Receiver receiver = new Receiver(socket);
		receiver.start();
	}
}