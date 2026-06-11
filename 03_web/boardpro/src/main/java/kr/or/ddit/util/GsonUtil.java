package kr.or.ddit.util;


import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonDeserializer;
import java.time.LocalDate;

public class GsonUtil {

    private GsonUtil() {}

    public static final Gson gson = new GsonBuilder()
        .registerTypeAdapter(LocalDate.class,
            (JsonDeserializer<LocalDate>) (json, type, ctx) ->
                LocalDate.parse(json.getAsString())
        )
        .setPrettyPrinting()
        .create();
}
