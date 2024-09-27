package xyz.itwill.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SecurityAuth {
    private String authUserId; // 권한을 가진 사용자의 ID
    private String auth; // 권한
}
