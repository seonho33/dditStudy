package kr.or.ddit.common.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;

public class FileUploadUtil {

    /**
     * webapp/images/upload/{subDir} 에 이미지 파일 저장
     *
     * @param context   ServletContext (req.getServletContext())
     * @param part      업로드된 Part 객체
     * @param subDir    하위 폴더명 (profile / menu / store 등)
     * @return          저장된 파일명(UUID.ext) 또는 null
     * @throws IOException
     */
    public static String saveImage(ServletContext context, Part part, String subDir) throws IOException {

        // 1️⃣ 파일 없으면 바로 종료
        if (part == null || part.getSize() == 0) {
            return null;
        }

        // 2️⃣ 원본 파일명
        String submittedFileName =
                Paths.get(part.getSubmittedFileName()).getFileName().toString();

        // 3️⃣ 확장자 추출
        String ext = "";
        int dotIndex = submittedFileName.lastIndexOf(".");
        if (dotIndex != -1) {
            ext = submittedFileName.substring(dotIndex).toLowerCase();
        }

        // 5️⃣ 저장 경로 (webapp 기준)
        String uploadPath = context.getRealPath("/images/upload/" + subDir);
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // 6️⃣ UUID 파일명 생성
        String saveFileName = UUID.randomUUID().toString().replace("-", "") + ext;

        // 7️⃣ 실제 파일 저장
        File saveFile = new File(uploadDir, saveFileName);
        part.write(saveFile.getAbsolutePath());

        // 8️⃣ DB에 저장할 파일명 반환
        return saveFileName;
    }

    // 유틸 클래스이므로 생성자 private
    private FileUploadUtil() {}
}
