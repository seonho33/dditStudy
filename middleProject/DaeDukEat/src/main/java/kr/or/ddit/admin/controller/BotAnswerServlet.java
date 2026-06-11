package kr.or.ddit.admin.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.admin.service.BotServiceImpl;
import kr.or.ddit.admin.service.IBotService;
import kr.or.ddit.admin.vo.BotVO;


@WebServlet("/BotAnswer.do")
public class BotAnswerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IBotService botService = BotServiceImpl.getInstance();
    private final Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json; charset=UTF-8");

        String input = req.getParameter("keyword");
        if (input == null) input = "";
        input = input.trim();

        Map<String, Object> out = new HashMap<>();
        out.put("success", true);

        if (input.isEmpty()) {
            out.put("message", "메뉴나 음식 키워드를 입력해줘! (예: 치킨, 피자, 국밥)");
            out.put("items", Collections.emptyList());
            resp.getWriter().write(gson.toJson(out));
            return;
        }

        String parsed = input; // 원문 그대로 매칭

        BotVO matched = botService.findBestMatch(parsed);

        if (matched == null) {
            out.put("message", "음… 아직 관련 답변이 준비되지 않았어! 다른 키워드로 물어봐줘 🙏");
            out.put("items", Collections.emptyList());
            resp.getWriter().write(gson.toJson(out));
            return;
        }

        String storeCategory = matched.getCategoryName();
        String menuKeyword   = extractMenuKeyword(input);

        // ✅ 1) 의도형(선택유도) 응답이면: 추천 검색 없이 메시지만
        if (storeCategory != null && storeCategory.endsWith("_선택유도")) {
            out.put("message", matched.getAnswerContent());
            out.put("category", storeCategory);
            out.put("keyword", "");
            out.put("items", Collections.emptyList());
            resp.getWriter().write(gson.toJson(out));
            return;
        }

        // ✅ 2) 일반 메뉴 트리거면: TOP3 추천
        List<Map<String, Object>> items = botService.searchTop3Mixed(storeCategory, menuKeyword);

        out.put("message", matched.getAnswerContent());
        out.put("category", storeCategory);
        out.put("keyword", menuKeyword);
        out.put("items", items);

        resp.getWriter().write(gson.toJson(out));
    }



    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doPost(req, resp);
    }
    
    private String extractMenuKeyword(String input) {
        if (input == null) return "";
        String s = input.trim();

        // 흔한 군더더기 제거
        String[] remove = {"추천", "먹고싶", "먹고 싶", "땡긴", "찾아", "싶어", "주세요", "요", "좀", "집", "가게"};
        for (String r : remove) s = s.replace(r, "");

        // 특수문자 제거
        s = s.replaceAll("[^가-힣0-9a-zA-Z\\s]", " ").trim();
        s = s.replaceAll("\\s+", " ");

        // 여러 단어면 첫 단어(원하면 가장 긴 단어로 바꿔도 됨)
        if (s.contains(" ")) s = s.split(" ")[0];

        return s.isEmpty() ? input.trim() : s;
    }

    
    private String pickBestKeyword(String input, String keywords) {
        if (keywords == null) return input;
        String in = normalize(input); // "치킨집" -> "치킨집"

        // 콤마/슬래시/파이프/공백 등으로 분리
        String[] parts = keywords.split("[,|/\\s]+");

        String best = null;
        int bestLen = -1;

        for (String p : parts) {
            String k = normalize(p);
            if (k.isEmpty()) continue;

            // ✅ 입력에 키워드가 포함되면 그 키워드를 선택(가장 긴 키워드 우선)
            if (in.contains(k)) {
                if (k.length() > bestLen) {
                    bestLen = k.length();
                    best = p.trim();
                }
            }
        }

        // 포함 매칭이 없으면, 그냥 첫 키워드(또는 input)로 fallback
        if (best != null) return best;

        // 첫 토큰 반환(예: "햄버거")
        for (String p : parts) {
            if (p != null && !p.trim().isEmpty()) return p.trim();
        }
        return input;
    }

    private String normalize(String s) {
        if (s == null) return "";
        // 한글/영문/숫자만 남김
        return s.toLowerCase().replaceAll("[^가-힣0-9a-z]", "");
    }

    
}

