package kr.jkh.khbank.service;

import org.apache.logging.log4j.core.config.Scheduled;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

@Component
public class InterestScheduler {

	@Autowired
	private AccountService accountService;

	@org.springframework.scheduling.annotation.Scheduled(cron = "0 */1 * * * ?")
	public void scheduledInterestApplication() {
		accountService.applyInterest();
		System.out.println("이자적용^^");
	}

}
