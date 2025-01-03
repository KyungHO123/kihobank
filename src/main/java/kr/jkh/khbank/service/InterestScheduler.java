package kr.jkh.khbank.service;

import java.sql.Date;
import java.util.Calendar;
import java.util.List;

import org.apache.logging.log4j.core.config.Scheduled;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import kr.jkh.khbank.model.vo.LoanSubscriptionVO;

@Component
public class InterestScheduler {

	@Autowired
	private AccountService accountService;
	@Autowired
	private LoanService loanService;

	@org.springframework.scheduling.annotation.Scheduled(cron = "0 */1 * * * ?")
	public void scheduledInterestApplication() {
		accountService.applyInterest();
		System.out.println("이자적용^^");
	}

	@org.springframework.scheduling.annotation.Scheduled(cron = "0 0 0 * * *")
	public void scheduledLoanRepaymentApplication() {
		List<LoanSubscriptionVO> loanSub = loanService.getLoanSubList();
		for (LoanSubscriptionVO loan : loanSub) {
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(loan.getLsOk());
			calendar.add(Calendar.DAY_OF_MONTH, 30);
			Date repaymentDate = new Date(calendar.getTimeInMillis());
			Date today = new Date(System.currentTimeMillis());
			// 상환 날짜가 현재 날짜 이전인지 확인
			if (!repaymentDate.after(today)) {
				boolean res = loanService.loanRepay(loan);
				if (res) {
					System.out.println(loan.getLsNum() + "성공");
					return;
				} else {
					System.out.println(loan.getLsNum() + "실패");
				}
			}
		}

	}
}
