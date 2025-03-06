package site.ani4h.api.auth;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class RefreshTokenResponse {
    private String email;
    private String accessToken;
    private String refreshToken;
}
