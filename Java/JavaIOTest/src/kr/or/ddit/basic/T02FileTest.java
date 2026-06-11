package kr.or.ddit.basic;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

public class T02FileTest {
	public static void main(String[] args) throws Exception {

		File f1 = new File("d:/D_Other/sample.txt");
		File f2 = new File("d:/D_Other/test.txt");
		
		if(f1.exists()) {
			System.out.println(f1.getAbsolutePath() + "은 존재합니다");
		}else {
			System.out.println(f1.getAbsolutePath() + "은 없는 파일입니다.");
	
			if(f1.createNewFile()) {
				System.out.println(f1.getAbsolutePath() + "파일을 새로 만들었습니다.");
			}
		 }
		
		if(f1.exists()) {
			System.out.println(f1.getAbsolutePath() + "은 존재합니다");
		}else {
			System.out.println(f1.getAbsolutePath() + "은 없는 파일입니다.");
		 }
		System.out.println("----------------------------------------------");
		
		File f3 = new File("d:/D_Other");
		File[] files = f3.listFiles();
		
		for(File f : files) {
			
			System.out.print(f.getName() + " => ");
			
			if(f.isFile()) {
				System.out.println("파일");
			}else if(f.isDirectory()) {
				System.out.println("디렉토리(폴더)");
			}
		}
		System.out.println(files.length+ "개의 파일 + 디렉토리(폴더) 가 존재합니다");
		System.out.println("==============================================");
		
		for(String fileName : f3.list()) {
			System.out.println(fileName);
		}
		System.out.println("=============================================");
		
		displayFileList(new File("d:/D_Other"));	
	}
	/*
		지정된 디렉토리(폴더)에 포함된 파일과 디렉토리 목록을 보여주기 위한 메서드
		@param = dir 목록 조회를 원하는 경로
	*/	
	
	private static void displayFileList(File dir) {
		System.out.println("[" + dir.getAbsolutePath() + "] 디렉토리의 내용");
		
		// 디렉토리 안의 모든 파일목록을 가져오기
		File[] files = dir.listFiles();
		
		// 날짜 정보를 출력하기 위한 포멧팅 설정하기
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd a hh:mm");
		
		int dirCnt = 0;
		
		for(File f : files) {
			String attr = "";	//파일의 속성(읽기, 쓰기, 히든, 디렉토리 구분)
			String size = "";
			
			if(f.isDirectory()) {
				attr = "<DIR>";
				dirCnt++;
			} /*
				 * else { if(f.canRead()) { attr = "R"; }else { attr = " "; } if(f.canWrite()) {
				 * attr += "W"; }else { attr += " "; } if(f.isHidden()) { attr += "H"; }else {
				 * attr += " "; } }
				 */
			else {
				attr = f.canRead() ? "R" : " ";
				attr += f.canWrite() ? "W" : " ";
				attr += f.isHidden() ? "H" : " ";
				
				size = String.valueOf(f.length());
			}

			System.out.printf("%s %5s %12s %s\n",
					sdf.format(new Date(f.lastModified())),
					attr,size,f.getName()
					);
		}
		int fileCnt = files.length - dirCnt;	//파일 갯수
		System.out.println();
		System.out.println(fileCnt + "개의 파일, " + dirCnt + "개의 디렉토리(폴더)");
		System.out.println();
		
	}
}

