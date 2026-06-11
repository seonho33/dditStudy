package kr.or.ddit.util;

import java.io.BufferedReader;
import java.io.IOException;

import jakarta.servlet.http.HttpServletRequest;

public class ObjJson {

    private ObjJson() {}

    public static <T> T fromJson(HttpServletRequest request, Class<T> clazz) {

        StringBuilder buf = new StringBuilder();

        try (BufferedReader rd = request.getReader()) {
            String line;
            while ((line = rd.readLine()) != null) {
                buf.append(line);
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        return GsonUtil.gson.fromJson(buf.toString(), clazz);
    }
}
