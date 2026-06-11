package kr.or.ddit.udp;

import java.io.FileOutputStream;
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.SocketException;

public class UdpFileReceiver {
	private DatagramSocket ds;
	private DatagramPacket dp;
	
	private byte[] buffer;
	
	
	public UdpFileReceiver(int port) {
		try {
			// 데이터 수신을 위한 포트번호 설정
			ds = new DatagramSocket(port);
		} catch (SocketException e) {
			e.printStackTrace();
		}
		
	}
	
	public void start() throws IOException {
		long fileSize = 0;	// 파일 크기
		long totalReadBytes = 0;			// 전송 진행상황 확인용
		
		int readBytes = 0;
		
		System.out.println("파일 수신 대기중...");
		
		String str = new String(receiveData()).trim();

		if(str.equals("start")) { // sender에서 start를 전송한 경우...
			
			//전송 파일명 받기
			str = new String(receiveData()).trim();
			FileOutputStream fos = new FileOutputStream("d:/D_Other/" + str);
			
			//총 파일 크기정보 받기
			str = new String(receiveData()).trim();
			fileSize = Long.parseLong(str);
			
			long startTime = System.currentTimeMillis();
			
			while(true) {
				
				byte[] data = receiveData();
				readBytes = dp.getLength();	//받은 데이터 크기
				fos.write(data, 0, readBytes);
				
				totalReadBytes += readBytes;
				
				System.out.println("진행 상태 : " + totalReadBytes + "/"
						+ fileSize + " Bytes (" + (totalReadBytes*100/fileSize)
						+ " %)");
			
				if(totalReadBytes >= fileSize) {
					break;
				}
			}
			
			long endTime = System.currentTimeMillis();
			long diffTime = endTime - startTime;	//걸린 시간
			double transferSpeed = fileSize / diffTime ;	//전송 속도
			
			System.out.println("걸린 시간 : " + diffTime + "(ms)" +
								"평균 수신 속도 : " + transferSpeed + "(Bytes/ms)");
			System.out.println("수신 완료...");
			
		}else {
			System.out.println("비정상 데이터 발견!!!");
			ds.close();
		}
	}

	
	/**
	 * 데이터 수신하기
	 * @return 수신된 바이트배열 데이터
	 * @throws IOException 
	 */
	private byte[] receiveData() throws IOException {
		
		buffer = new byte[1000];	//버퍼 초기화
		dp = new DatagramPacket(buffer, buffer.length);
		ds.receive(dp);	// 데이터 수신하기
		
		return dp.getData();
	}

	public static void main(String[] args) throws IOException {
		new UdpFileReceiver(8888).start();
	}
}