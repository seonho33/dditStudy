package kr.or.ddit.reservation.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Arrays;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType0Font;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;
import org.json.JSONArray;
import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.reservation.service.IReservationService;
import kr.or.ddit.reservation.service.ReservationServiceImpl;
import kr.or.ddit.store.vo.ReservationVO;
import kr.or.ddit.store.vo.StoreVO;

@WebServlet("/reservation/downloadPDF.do")
public class ReservationPDFController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IReservationService reservationService = ReservationServiceImpl.getInstance();

    // 🔑 카카오 REST API 키
    private static final String KAKAO_REST_KEY = "7ed0b1ca9bb2803effb423c76255e900";
//    private static final String KAKAO_REST_KEY = System.getenv("KAKAO_REST_KEY");


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	long reservId = Long.parseLong(request.getParameter("reservId"));

    	ReservationVO reservation;
    	try {
    	    reservation = reservationService.getReservationById(reservId);
    	} catch (Exception e) {
    	    e.printStackTrace();
    	    response.sendError(
    	        HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
    	        "예약 정보를 불러오는 중 오류가 발생했습니다."
    	    );
    	    return;
    	}

    	
    	System.out.println("=== PDF Reservation Debug ===");
    	System.out.println("storeName = " + reservation.getStoreName());
    	System.out.println("storeAddr = " + reservation.getStoreAddr());
    	System.out.println("storeId   = " + reservation.getStoreId());
        System.out.println("storePicture = " + reservation.getStorePicture());


        if (reservation == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        String storeName = reservation.getStoreName();
        String storeAddr = reservation.getStoreAddr();
        String storePicture = reservation.getStorePicture();      
        
        String reservTime = reservation.getReservTime();
        int guestCount = reservation.getGuestCount();

        PDDocument doc = new PDDocument();
        PDPage page = new PDPage();
        doc.addPage(page);

        PDType0Font font;
        try (InputStream fontStream =
        		
                getServletContext().getResourceAsStream("/WEB-INF/fonts/HakgyoansimBareondotumR.ttf")) {
            font = PDType0Font.load(doc, fontStream, true);
        }
        
        
        
     // ================= 표 설정 =================
        PDPageContentStream content =
                new PDPageContentStream(doc, page, PDPageContentStream.AppendMode.APPEND, true);
      
       
        // --- 제목 (중앙) ---
        content.beginText();
        content.setFont(font, 20);
        String title = "[ 예약 확인서 ]";
        float titleWidth = font.getStringWidth(title) / 1000 * 20;
        float pageWidth = page.getMediaBox().getWidth();
        float titleY = 750;
        content.newLineAtOffset((pageWidth - titleWidth) / 2, titleY);
        content.showText(title);
        content.endText();

        float lineHeight = 18f;
        float textFontSize = 12f;

        float textCellWidth = 280f;
        float imageCellWidth = 180f;
        float cellPadding = 10f;

        float tableWidth = textCellWidth + imageCellWidth;
        float startY = 700;

        // 텍스트 줄
        String[] lines = new String[] {
            "▶ 매장명: " + storeName,
            "▶ 예약 일시: " + reservTime,
            "▶ 예약 인원: " + guestCount + "명",
            "▶ 예약 번호: R" + reservId,
            "",
            "[ 위치 정보 ]",
            "▶ 주소: " + storeAddr
        };

        // 표 높이
        float tableHeight = lines.length * lineHeight + cellPadding * 2;

        // 중앙 정렬 X
        float startX = (pageWidth - tableWidth) / 2;

        // ================= 표 테두리 =================
        content.setLineWidth(1);

        // 전체 테두리
        content.addRect(startX, startY - tableHeight, tableWidth, tableHeight);

        // 세로 분할선
        content.moveTo(startX + textCellWidth, startY);
        content.lineTo(startX + textCellWidth, startY - tableHeight);

        content.stroke();

        // ================= 텍스트 셀 =================
        content.beginText();
        content.setFont(font, textFontSize);
        content.newLineAtOffset(
            startX + cellPadding,
            startY - cellPadding - textFontSize
        );

        for (String line : lines) {
            content.showText(line);
            content.newLineAtOffset(0, -lineHeight);
        }
        content.endText();

        // ================= 이미지 셀 =================
        if (storePicture != null && !storePicture.isBlank()) {
            String imagePath = "/images/upload/store/" + storePicture;
            String realPath = getServletContext().getRealPath(imagePath);
            File imageFile = new File(realPath);

            if (imageFile.exists()) {
                PDImageXObject storeImage =
                        PDImageXObject.createFromFileByContent(imageFile, doc);

                float maxImageWidth = imageCellWidth - cellPadding * 2;
                float maxImageHeight = tableHeight - cellPadding * 2;

                float scale = Math.min(
                    maxImageWidth / storeImage.getWidth(),
                    maxImageHeight / storeImage.getHeight()
                );

                float drawWidth = storeImage.getWidth() * scale;
                float drawHeight = storeImage.getHeight() * scale;

                // 이미지 셀 중앙 정렬
                float imageX = startX + textCellWidth
                        + (imageCellWidth - drawWidth) / 2;

                float imageY = startY - (tableHeight + drawHeight) / 2;

                PDPageContentStream imgContent =
                        new PDPageContentStream(doc, page,
                                PDPageContentStream.AppendMode.APPEND, true);

                imgContent.drawImage(storeImage, imageX, imageY, drawWidth, drawHeight);
                imgContent.close();
            }
        }
        
        content.close();


        
//        /* ================= 카카오 지도 ================= */
//        double[] latlng = null;
//        
//        System.out.println("=== 확인용 ===");
//        System.out.println("PDF storeAddr = [" + storeAddr + "]");
//        System.out.println("KEY=[" + KAKAO_REST_KEY + "]");
//        System.out.println("============");
//
//
//        if (storeAddr != null && !storeAddr.isBlank()) {
//            latlng = getLatLngFromAddress(storeAddr);
//        } else {
//            System.out.println("❗ 매장 주소가 null 또는 비어있음 (지도 생략)");
//        }
//        
//     // ✅ 여기!
//        System.out.println("latlng = " + Arrays.toString(latlng));
//
//        if (latlng != null) {
//        	String mapUrl =
//        		    "https://dapi.kakao.com/v2/maps/staticmap?"
//        		    + "appkey=" + KAKAO_REST_KEY
//        		    + "&center=" + latlng[1] + "," + latlng[0] // 위도, 경도
//        		    + "&level=3"
//        		    + "&w=500"
//        		    + "&h=300"
//        		    + "&markers=" + latlng[1] + "," + latlng[0]; // 마커 위치
//
//        		// 이미지 다운로드
//        		byte[] imgBytes = new URL(mapUrl).openStream().readAllBytes();
//
//
//        	
//        	// ✅ 그리고 여기!
//            System.out.println("MAP URL = " + mapUrl);
//
//        	try {
//        	    PDImageXObject mapImage = PDImageXObject.createFromByteArray(doc, imgBytes, "kakaoMap");
//        	    PDPageContentStream imgContent = new PDPageContentStream(doc, page, PDPageContentStream.AppendMode.APPEND, true);
//
//        	    imgContent.drawImage(mapImage, 50, 200, 500, 300);
//        	    imgContent.close();
//        	} catch (Exception e) {
//        	    System.out.println("❗ 지도 이미지 로딩 실패 (PDF는 정상 생성)");
//        	}
//        }

        /* ================= PDF 응답 ================= */
        String fileName = URLEncoder.encode(
                "예약확인서_" + storeName + ".pdf",
                StandardCharsets.UTF_8
        ).replaceAll("\\+", "%20");

        response.setContentType("application/pdf");
        response.setHeader(
                "Content-Disposition",
                "attachment; filename*=UTF-8''" + fileName
        );

        doc.save(response.getOutputStream());
        doc.close();
    }
    
    /* ================= 주소 → 위경도 ================= */
    private double[] getLatLngFromAddress(String address) {

        if (address == null || address.isBlank()) {
            return null;
        }

        try {
            String query = URLEncoder.encode(address, "UTF-8");
            URL url = new URL(
                "https://dapi.kakao.com/v2/local/search/address.json?query=" + query
            );

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "KakaoAK " + KAKAO_REST_KEY);
            conn.setRequestProperty("User-Agent", "Mozilla/5.0");
            conn.setRequestProperty("Accept", "application/json");
            conn.setRequestProperty("Referer", "http://localhost"); // ⭐ 중요
            conn.setRequestProperty("Origin", "http://localhost");


            int responseCode = conn.getResponseCode();
            InputStream is = (responseCode == 200)
                    ? conn.getInputStream()
                    : conn.getErrorStream();

            BufferedReader br =
                new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8));

            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }

            String response = sb.toString();
            System.out.println("KAKAO RESPONSE = " + response);

            if (responseCode != 200) {
                return null;
            }

            JSONObject obj = new JSONObject(response);
            JSONArray docs = obj.getJSONArray("documents");

            if (docs.length() == 0) {
                return null;
            }

            JSONObject addr = docs.getJSONObject(0);
            double x = addr.getDouble("x"); // longitude
            double y = addr.getDouble("y"); // latitude

            return new double[]{x, y};

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

}
