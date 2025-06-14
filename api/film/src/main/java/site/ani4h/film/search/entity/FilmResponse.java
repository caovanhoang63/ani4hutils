package site.ani4h.film.search.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.elasticsearch.annotations.Document;
import site.ani4h.shared.common.Image;
import site.ani4h.shared.common.Uid;

import java.util.List;

@Document(indexName = "films")
@Getter
@Setter
public class FilmResponse {
    private Uid id;
    private String title;
    private String synopsis;
    private String synonyms;
    private String jaName;
    private String enName;
    private List<Image> images;
    private List<GenreResponse> genres;
    private float avgStar;
    private int totalStar;
    private int maxEpisodes;
    private int numEpisodes;
    private int year;
    private String season;
    private String state;

    @JsonIgnore
    public static final int type = 3;

    public void setId(int id) {
        this.id = new Uid(id,0,type);
    }
}
