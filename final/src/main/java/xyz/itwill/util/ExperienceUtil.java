package xyz.itwill.util;

public class ExperienceUtil {

    // 각 레벨에 도달하기 위한 경험치 계산 (예: 레벨마다 100 포인트 증가)
    public static int getExperienceForNextLevel(int level) {
        return level * 100; // 레벨당 필요한 경험치 계산
    }

    // 현재 경험치에 대한 진행률 계산
    public static int calculateProgressPercentage(int currentExperience, int experienceForNextLevel) {
        return (int) ((double) currentExperience / experienceForNextLevel * 100);
    }
}
