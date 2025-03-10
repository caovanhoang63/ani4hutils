package site.ani4h.api.user;


import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import lombok.Getter;
import lombok.Setter;
import site.ani4h.api.common.Image;
import site.ani4h.api.utils.MaskDataSerializer;
import site.ani4h.api.utils.UnmaskDataDeserializer;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
public class User {
    public User(){};
    public User(int id, String phoneNumber, String firstName, String lastName, String displayName, LocalDate dateOfBirth, Gender gender, Role role, Image avatar, Integer status, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.id = id;
        this.phoneNumber = phoneNumber;
        this.firstName = firstName;
        this.lastName = lastName;
        this.displayName = displayName;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.role = role;
        this.avatar = avatar;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    public void setGender(String gender) {
        this.gender = Gender.fromString(gender);
    }

    public void setRole(String role) {
        this.role = Role.fromString(role);
    }
    @JsonSerialize(using = MaskDataSerializer.class)
    @JsonDeserialize(using =  UnmaskDataDeserializer.class)
    private int id;
    private String phoneNumber;
    private String firstName;
    private String lastName;
    private String displayName;
    private LocalDate dateOfBirth;
    private Gender gender;
    private Role role;
    private Image avatar;
    private Integer status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
