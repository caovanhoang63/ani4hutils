package site.ani4h.auth.auth.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@AllArgsConstructor
@Setter
@Getter
public class RefreshTokenRequest {
    public RefreshTokenRequest() {

    }
    private String refreshToken;
}
