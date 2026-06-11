package kr.or.ddit.udp;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketException;
import java.net.UnknownHostException;

public class UdpFileSender {
	private DatagramSocket ds;
	private DatagramPacket dp;
	
	private InetAddress recvAddr;
	private int  port;
	private File file;
	
	public UdpFileSender(String recvIp, int port) {
		
		try {
			ds = new DatagramSocket();
			
			this.port = port;
			recvAddr = InetAddress.getByName(recvIp);
			file = new File("d:/D_Other/Tulips33.jpg");
			
			if(!file.exists()) {
				System.out.println("전송할 파일이 존재하지 않습니다");
				System.exit(0);
			}
					
		} catch (SocketException e) {
			e.printStackTrace();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
	}
	
	//시작 메서드
	public void start() throws IOException {
		
		long fileSize = file.length();	// 파일 크기
		long totalReadBytes = 0;			// 전송 진행상황 확인용
		
		long startTime = System.currentTimeMillis();
		
		
		//전송 시작을 알려주기 위해 start 문자열 보내주기
		sendData("start".getBytes());
		
		//파일명 전송
		sendData(file.getName().getBytes());
		
		//총 파일 크기정보 전송
		sendData(String.valueOf(file.length()).getBytes());
		
		FileInputStream fis = new FileInputStream(file);
		byte[] buffer = new byte[1000];
		
		while(true) {
			try {
				Thread.sleep(10);	// 패킷 전송간의 간격을 주기 위해서...
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			
			int readBytes = fis.read(buffer, 0, buffer.length);
			
			if(readBytes == -1) {	// 모든 파일 내용을 읽은 경우...
				break;
			}
			
			sendData(buffer, readBytes);
			
			totalReadBytes += readBytes;
			System.out.println("진행 상태 : " + totalReadBytes + "/"
					+ fileSize + " Bytes (" + (totalReadBytes*100/fileSize)
					+ " %)");
		}
		
		long endTime = System.currentTimeMillis();
		long diffTime = endTime - startTime;	//걸린 시간
		double transferSpeed = fileSize / diffTime ;	//전송 속도
		
		System.out.println("걸린 시간 : " + diffTime + "(ms)" +
							"평균 전송 속도 : " + transferSpeed + "(Bytes/ms)");
		System.out.println("전송 완료...");
		
		fis.close();
		ds.close();
	}

	/**
	 * 바이트 배열 데이터 전송하기
	 * @param data 전송할 바이트 배열 데이터
	 * @throws IOException 
	 */
	private void sendData(byte[] data) throws IOException {
		
		sendData(data, data.length);
	}
	
	/**
	 * 바이트 배열 데이터 전송하기
	 * @param data 전송할 바이트 배열 데이터
	 * @param length 실제 전송할 바이트 크기
	 * @throws IOException 
	 */
	private void sendData(byte[] data,int length) throws IOException {
		dp = new DatagramPacket(data, length, recvAddr, port);
		ds.send(dp);
	}
	
	public static void main(String[] args) throws IOException {
		new UdpFileSender("192.168.34.77", 8888).start();;
		
	}
}