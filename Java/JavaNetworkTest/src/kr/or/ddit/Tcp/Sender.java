package kr.or.ddit.Tcp;

import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.util.Scanner;

/**
 * 소켓을 통해 메시지 전송 기능을 담당하기 위한 스레드
 */
public class Sender extends Thread {

	private Scanner scan;
	private String name;
	private DataOutputStream dos;
	
	public Sender(Socket socket) {
		
		scan = new Scanner(System.in);
		
		name = "[" + socket.getLocalAddress() + ":" +
				socket.getLocalPort() + "]";
		
		try {
			dos = new DataOutputStream(socket.getOutputStream());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void run() {
		while(dos != null) {
			try {
				dos.writeUTF(name+" >>> " + scan.nextLine());
			}catch(IOException e){
				e.printStackTrace();
			}
		}	
	}
}
