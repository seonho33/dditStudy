package kr.or.ddit.basic;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.util.Scanner;

public class MultiChatClient {

	//시작 메서드
	public void start() {
		
		try {
			Socket socket = new Socket("192.168.34.98",7777);
			System.out.println("멀티챗 서버에 접속되었습니다...");
			
			ClientSender sender = new ClientSender(socket);
			sender.start();
			
			ClientReceiver recv = new ClientReceiver(socket);
			recv.start();
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public class ClientSender extends Thread {

		private DataOutputStream dos;
		private Scanner scan;
		
		public ClientSender(Socket socket) {
			scan = new Scanner(System.in);
			
			try {
				dos = new DataOutputStream(socket.getOutputStream());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		@Override
		public void run() {
			
			try {
				//시작하자마자 대화명을 지정하여 서버로 전송하기
				System.out.println("대화명 >> ");
				dos.writeUTF(scan.nextLine());
				
				while(dos !=null) {
					dos.writeUTF(scan.nextLine());
				}
				
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	public class ClientReceiver extends Thread{
		private DataInputStream dis;
		
		public ClientReceiver(Socket socket) {
			try {
				dis = new DataInputStream(socket.getInputStream());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		@Override
		public void run() {
			while(dis !=null ) {
				try {
					// 서버로부터 수신한 메시지 출력하기
					System.out.println(dis.readUTF());
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	public static void main(String[] args) {
		new MultiChatClient().start();
	}
}
