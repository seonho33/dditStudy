package kr.or.ddit.basic;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class TulipsCopyBuffered {
	public static void main(String[] args) {
		String name = "사본";
		int number = 1;
		File f1 = new File("d:/D_Other/Tulips.jpg");
		File f2 = new File(f1.getParent(),name+f1.getName());
		
		
		while(true) {
			try {
				if(f2.createNewFile()) {
					System.out.println("복사");
					
					try(FileInputStream fis = new FileInputStream(f1);
						FileOutputStream fos = new FileOutputStream(f2);
						BufferedOutputStream bos = new BufferedOutputStream(fos,10);
						BufferedInputStream bis = new BufferedInputStream(fis,10);
						){
						
							int data = 0;
							while((data = bis.read())!=-1) {
								bos.write(data);
							}
							bos.flush();
						}catch(Exception ex) {
							ex.printStackTrace();
						}
					break;
				}else{
					f2 = new File(f1.getParent(),name+"("+number+")"+f1.getName());
					number++;
				}
			} catch (IOException e) {
				e.printStackTrace();
				System.exit(0);
			}
		}
	}
}