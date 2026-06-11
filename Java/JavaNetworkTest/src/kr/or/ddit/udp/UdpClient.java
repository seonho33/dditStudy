package kr.or.ddit.udp;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketException;

public class UdpClient {
	private DatagramSocket ds;
	private DatagramPacket dp;
	
	private byte[] msg;
	
	public UdpClient() {
		msg = new byte[100];
		
		try {
			// 포트번호를 명시하지 않으면 포트번호는 이용가능한 임의의 포트번호로
			// 할당된다.
			ds = new DatagramSocket();
		} catch (SocketException e) {
			e.printStackTrace();
		}
	}
		
	public void start() throws IOException {
		InetAddress serverAddr = InetAddress.getByName("192.168.34.98");
		
		dp = new DatagramPacket(msg, 1, serverAddr, 8888);
		ds.send(dp);	//데이터 전송
		
		dp = new DatagramPacket(msg, msg.length);
		ds.receive(dp);	//데이터 수신
		
		System.out.println("현재 서버 시간 => " + new String(dp.getData()));
		
		ds.close();
	}
		
	public static void main(String[] args) throws IOException {
		new UdpClient().start();
	}
}
