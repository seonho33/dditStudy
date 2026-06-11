package kr.or.ddit.controller.chapt09.item02;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.jspecify.annotations.Nullable;
import org.springframework.util.FileCopyUtils;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class UploadFileUtils {
	
	
	/*
		1. '/년/월/일/' 폴더 경로를 만들고, 해당 경로를 리턴받는다.
		2. 업로드 경로 + /년/월/일/ + UUID_월본파일명을 형태로 파일 복사를 진행합니다.
		3. 업로드 한 파일이 이미지라면 's_'가 붙은 썸네일 이미지를 만든다
		
	*/
	public static String uploadFile(String uploadPath, @Nullable String originalFilename, byte[] bytes) throws Exception {
		// UUID_원본파일명으로 저장 파일명 짓기
		String savedName = UUID.randomUUID().toString()+"_"+ originalFilename;
		
		// 2026/03/20 폴더 경로 만들고, /2026/03/20 폴더 경로를 리턴한다.
		String savedPath = calcPath(uploadPath);
		
		// 서버 업로드 경로 + /2026/03/20 + UUID_원본파일명으로 File target을 하나 만듭니다.
		File target = new File(uploadPath + savedPath, savedName);
		FileCopyUtils.copy(bytes, target);	// 파일 복사
		
		// \2026\03\20 경로를 '/' 경로로 변경 후 원본 파일명을 붙인다
		// File.separatorChar는 시스템에 따라 달라지는 기본 이름 구분 기호입니다.
		// UNIX 시스템에서는 이 필드의 값이 '/' 이고, Microsoft Windows 시스템에서는 '//'입니다.
		String uploadedFileName = savedPath.replace(File.separatorChar,'/')+"/"+savedName;	
		
		String formatName = originalFilename.substring(originalFilename.lastIndexOf(".")+1);
		
		if(MediaUtils.getMediaTye(formatName) !=null) {//이미지라는것.
			makeThumbnail(uploadPath, savedPath, savedName);
		}
		
		return uploadedFileName;
	}
	
	//썸네일 이미지 만들기
	private static void makeThumbnail(String uploadPath, String savedPath, String savedName) throws Exception {
		//썸네일 이미지를 만들기 위해 원본 이미지를 읽는다.
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath + savedPath, savedName));

		// 썸네일 이미지를 만들기 위한 설정을 진행
		// # Scalr.Method - 품질 및 속도
		// - 이미지를 줄이거나 늘릴 때 어떤 옵션을 사용할지 설정합니다.
		// > AUTOMATIC : 이미지 크기에 따라 알아서 최적의 방법을 선택합니다.(가장 많이 사용)
		// > SPEED : 품질보다는 처리 속도에 포컿스를 맞춰 썸네일 대량 생성에 사용합니다.
		// > BALANCED : 품질, 속도 모두 중간레벨로 설정합니다
		// > ULTRA_QUALITY : 가장 좋은 최상의 품질을 제공하지만 속도가 느려집니다.
		// # Scalr.Mode - 비율 유지 방식
		// -이미지의 가로/세로 비율을 어떻게 맞출지 결정합니다.
		// > FIT_TO_HEIGHT : 지정한 높이에 맞춰, 가로는 비율에 따라 자동으로 계산
		// > FIT_TO_WIDTH : 지정한 너비에 맞추고, 높이는 비율에 따라 자동 계산
		// > FIT_EXACT : 비율을 무시하고 지정한 가로, 세로 크기에 강제로 맞춤(이미지가 찌그러질 수 있음)
		// > BEST_FIT_WH : 지정한 가로/세로 범위 내에서 원본 비율을 최대한 유지(꽉 차게 맞춤)
		
		// targetSize : 값 100, 정사각형 사이즈로 100x100
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);

		// 업로드 한 원본 이미지를 가지고 's_'를 붙여서 임시 파일로 만들기 위한 썸네일 경로 + 파일명을 작성한다.
		String thumbnailName = uploadPath + savedPath + File.separator + "s_" + savedName;
		
		File newFile = new File(thumbnailName);
		String formatName = savedName.substring(savedName.lastIndexOf(".")+1);
		
		// 's_' 가 붙은 썸네일 이미지를 만든다.
		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
	}

	//년월일 경로 생성
	private static String calcPath(String uploadPath) {
		Calendar cal = Calendar.getInstance();
		String yearPath = File.separator + cal.get(Calendar.YEAR);
		
		
		//DecimalFormat 은 특정 패턴 문자열을 사용하여 객체를 생성 할 때 사용합니다
		// DecimalFormat("00")은 두 자리에서 빈 자리는 0으로 제출, 월 또는 일은 일의 자리가 있기 때문에
		// 비어있는 자리는 0으로 채우기 위해 사용
		String monthPath = yearPath + File.separator + new DecimalFormat("00")
				.format(cal.get(Calendar.MONTH)+1); //2026/03
		String dayPath = monthPath + File.separator + new DecimalFormat("00")
				.format(cal.get(Calendar.DATE));//2026/03/20
		
		//년월일 폴더 구조를 만들었으니 실제 폴더 생성하기
		makeDir(uploadPath,yearPath,monthPath,dayPath);
		//makeDirs(dayPath)
		
		return dayPath;
	}

	// 가변인자(varargs)
	// - 가변인자란 인수의 개수를 동적으로 조절 할 수 있게 해주는 인자입니다.
	// - 가변인자를 사용 시, 컴파일러가 호출 시점에 인수들을 모아 자동으로 배열 형태를 만들어 줍니다.
	// # 가변인자를 사용할 때 주의 사항이 있습니다.
	// - 가변인자는 매개변수의 순서상 마지막으로 선언해야 합니다. 그렇지 않으면 컴파일 에러가 발생할 수 있습니다.
	// - 가변인자는 메서드 1개당 하나의 인자로만 사용할 수 있습니다.
	// # 사용방법
	// - 키워드 '...' 를 사용한다
	// - 타입... 변수명 형태로 사용
	private static void makeDir(String uploadPath, String... paths ) {
		// 2026/03/20 폴더 구조가 존재한다면 return
		// 만들려던 폴더 구조가 이미 만들어서 있는거니까 return
		if(new File(uploadPath + paths[paths.length -1]).exists()) {
			return;
		}
		
		for(String path : paths) {
			File dirPath = new File(uploadPath + path);
				
				// /2026/03/20 과 같은 경로에 각 폴더라 없ㅇ르면 각각 만들어 준다.
				if(!dirPath.exists()) {
					dirPath.mkdirs();
			}
		}
	}
	
	
}