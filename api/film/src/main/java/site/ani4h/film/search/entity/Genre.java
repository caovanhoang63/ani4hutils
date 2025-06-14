package site.ani4h.film.search.entity;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

@Getter
@Setter
public class Genre {
    @Field(type = FieldType.Integer)
    private int id;
    @Field(type = FieldType.Text)
    private String name;

    public Genre() {}

    public Genre(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public GenreResponse mapToGenreResponse() {
        GenreResponse genreResponse = new GenreResponse();
        genreResponse.setId(id);
        genreResponse.setName(name);
        return genreResponse;
    }
}
