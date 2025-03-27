package site.ani4h.search.film;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/v1/search")
public class FilmController {
    private final FilmService filmService;
    public FilmController(FilmService filmService) {
        this.filmService = filmService;
    }

    @PostMapping("/sync")
    public ResponseEntity<?> syncFilmsToElastic() {
        filmService.syncFilmsToElastic();
        return ResponseEntity.ok().build();
    }

    @GetMapping()
    public ResponseEntity<?> getFilmsByTitle(@RequestParam String title) {
        var films = filmService.getFilmsByTitle(title);
        return ResponseEntity.ok(films);
    }
}
