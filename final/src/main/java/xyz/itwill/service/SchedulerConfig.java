package xyz.itwill.service;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;

//root-context 에서 정의해둠

//Spring 설정 클래스
@Configuration
//Spring 스케쥴러 기능 활성화
@EnableScheduling
public class SchedulerConfig {
   
   //Spring Bean 생성
    @Bean
    public ThreadPoolTaskScheduler taskScheduler() {
       
        ThreadPoolTaskScheduler scheduler = new ThreadPoolTaskScheduler();
        //스레프 풀의 크기 설정 - 동시 최대 10 작업 가능
        scheduler.setPoolSize(10);
        //스레드 이름의 접두사 생성 - 로깅,디버그 용도
        scheduler.setThreadNamePrefix("scheduled-task-");
        //스케쥴러 초기화
        scheduler.initialize();
        return scheduler;
    }
}