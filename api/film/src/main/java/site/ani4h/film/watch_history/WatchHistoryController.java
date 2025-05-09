package site.ani4h.film.watch_history;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import site.ani4h.film.watch_history.entity.EpisodeWatchHistory;
import site.ani4h.film.watch_history.entity.WatchHistoryRequest;
import site.ani4h.shared.common.Paging;
import site.ani4h.shared.common.Uid;

import java.util.List;

@RestController
@RequestMapping("v1/watch-history")
public class WatchHistoryController {
    private final WatchHistoryService watchHistoryService;

    public WatchHistoryController(WatchHistoryService watchHistoryService) {
        this.watchHistoryService = watchHistoryService;
    }

    @GetMapping("/is-watched")
    public boolean isWatched(@ModelAttribute WatchHistoryRequest request) {
        return watchHistoryService.isWatched(request);
    }

    @PostMapping("/upsert")
    public void upsert(@RequestBody WatchHistoryRequest request) {
        watchHistoryService.upsert(request);
    }

    @DeleteMapping("/delete")
    public void delete(@ModelAttribute WatchHistoryRequest request) {
        watchHistoryService.delete(request);
    }

    @GetMapping
    public ResponseEntity<?> getWatchHistoryByUserId(@ModelAttribute WatchHistoryRequest request, @ModelAttribute Paging paging) {
        List<EpisodeWatchHistory> watchHistory = watchHistoryService.getWatchHistoryByUserId(request, paging);
        return ResponseEntity.ok(watchHistory);
    }

    @GetMapping("/recent")
    public ResponseEntity<?> getRecentByUserId(@RequestParam Uid userId, @RequestParam int limit) {
        List<Integer> recentEpisodes = watchHistoryService.getRecentByUserId(userId.getLocalId(), limit);
        return ResponseEntity.ok(recentEpisodes);
    }
}
