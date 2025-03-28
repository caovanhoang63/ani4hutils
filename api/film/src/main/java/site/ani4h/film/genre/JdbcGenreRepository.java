package site.ani4h.film.genre;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Component;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.List;
import java.util.Objects;

@Component
public class JdbcGenreRepository implements GenreRepository {
    private final JdbcTemplate jdbcTemplate;
    public JdbcGenreRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    @Override
    public void create(GenreCreate genreCreate) {
        //language=MySQL
        String sql = "insert into `genres` (name, description, image) VALUE (?,?,?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(con -> {
            PreparedStatement ps = con.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
        ps.setString(1,genreCreate.getName());
        ps.setString(2,genreCreate.getDescription());
        ps.setObject(3,genreCreate.getImage());
        return ps;
        },keyHolder);
        genreCreate.setId(Objects.requireNonNull(keyHolder.getKey()).intValue());
    }

    @Override
    public List<Genre> getGenre() {
        //language=MySQL
        String sql = "SELECT * FROM `genres` WHERE status = 1 ORDER BY id DESC";
        return jdbcTemplate.query(sql,
                new BeanPropertyRowMapper<>(Genre.class)
        );
    }

    @Override
    public void update(int id ,GenreUpdate genreUpdate)    {
        //language=MySQL
        String sql = """
                UPDATE `genres`
                SET name = COALESCE(?,name),
                    description = COALESCE(?,description),
                    image = ?
                WHERE id = ?
                """;
        try {
            var objectMapper = new ObjectMapper().writer().writeValueAsString(genreUpdate.getImage());
            jdbcTemplate.update(sql,
                    genreUpdate.getName(),
                    genreUpdate.getDescription(),
                    genreUpdate.getImage() == null ? null : objectMapper ,
                    id);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void delete(int id ) {

    }
}
