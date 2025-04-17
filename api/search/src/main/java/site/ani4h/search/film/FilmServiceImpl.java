package site.ani4h.search.film;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import site.ani4h.search.film.entity.*;
import site.ani4h.shared.common.PagingSearch;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
public class FilmServiceImpl implements FilmService {
    private final FilmRepository filmRepository;
    private final FilmElasticsearchRepository filmElasticsearchRepository;
    private final FilmCustomElasticRepository filmCustomElasticRepository;

    @Autowired
    public FilmServiceImpl(
            FilmRepository filmRepository,
            FilmElasticsearchRepository filmElRepository,
            FilmCustomElasticRepository filmCustomElasticRepository
    ) {
        this.filmRepository = filmRepository;
        this.filmElasticsearchRepository = filmElRepository;
        this.filmCustomElasticRepository = filmCustomElasticRepository;
    }

    @Override
    public List<FilmModel> getFilms() {
        return filmRepository.getFilms();
    }

    @Override
    public void syncFilmsToElastic() {
        List<FilmModel> films = filmRepository.getFilms();

        if(films.isEmpty()) {
            return;
        }

        // Convert FilmModel to Film
        List<Film> filmList = films.stream()
                .map(filmModel -> {
                    Film film = new Film();
                    film.mapFromFilmModel(filmModel);
                    return film;
                })
                .collect(Collectors.toList());

        filmElasticsearchRepository.saveAll(filmList);
    }

    // Search Films
    @Override
    public SearchResponse searchFilms(SearchRequest request,PagingSearch paging) {
        if(request == null) {
            throw new IllegalArgumentException("Search request must not be null");
        }

        if(paging == null) {
            paging = new PagingSearch();
        }

        return filmCustomElasticRepository.search(request, paging);
    }
}