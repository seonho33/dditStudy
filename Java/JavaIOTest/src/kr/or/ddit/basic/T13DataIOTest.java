package kr.or.ddit.basic;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class T13DataIOTest {
	public static void main(String[] args) {
		
		try(FileOutputStream fos = new FileOutputStream("d:/D_Other/test.dat");
			//DataOutputStream은 출력용 데이터를 기본 자료형에 맞게 출력해준다...
			//기본타입 자료를 IO 하고싶을때 사용...
			DataOutputStream dos = new DataOutputStream(fos);
			){
			dos.writeUTF("홍길동");	// 문자열 데이터 출력(UTF-8)
			dos.writeInt(17);		// 정수형 데이터 출력
			dos.writeFloat(3.14f);	// 실수형 데이터 출력
			dos.writeDouble(3.14);	// 실수형(double) 데이터 출력
			dos.writeBoolean(true);	// 논리형 데이터 출력
			//////////////////////////////////////////
			
			System.out.println("저장 완료...");
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		try(FileInputStream fis = new FileInputStream("d:/D_Other/test.dat");
			DataInputStream dis = new DataInputStream(fis);
			){
				System.out.println("문자열 데이터 : " + dis.readUTF());
				System.out.println("정수형 데이터 : " + dis.readInt());
				System.out.println("실수형(Float) 데이터 : " + dis.readFloat());
				System.out.println("실수형(Double)데이터 : " + dis.readDouble());
				System.out.println("논리형 데이터 : " + dis.readBoolean());
				System.out.println("\n읽기 작업 완료 !!!");
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	}
}
