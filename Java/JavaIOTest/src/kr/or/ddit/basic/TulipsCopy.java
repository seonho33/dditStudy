package kr.or.ddit.basic;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;

public class TulipsCopy {
	public static void main(String[] args) throws IOException {
		File f1 = new File("d:/D_Other/Tulips.jpg");
		
		File f2 = new File(f1.getPath()+"/..","복사본"+f1.getName());
		
		if(f2.createNewFile()) {
			System.out.println("복사");
		}
		
		try(FileInputStream fis = new FileInputStream(f1);
			FileOutputStream fw = new FileOutputStream(f2);
				){
		
			int data = 0;
			while((data = fis.read())!=-1) {
				fw.write(data);
			}
		}
	}
}