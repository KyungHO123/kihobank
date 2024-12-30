package kr.jkh.khbank.interceptor;

import javax.servlet.RequestDispatcher;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class GuestInterceptor extends HandlerInterceptorAdapter {

	/* preHandle에서 return값이 true이면 가려던 컨트롤러로 가서 작업을 진행
	 * return값이 false이면 가려던 컨트롤러로 가지 마세요. 리다이렉트할 경로가 있으면 해당 경로로 이동
	 * */
	/*
	 * @Override public boolean preHandle( HttpServletRequest request,
	 * HttpServletResponse response, Object handler) throws Exception {
	 * SiteManagement user = (SiteManagement)
	 * request.getSession().getAttribute("user"); //로그인 했으면 if (user != null) { //
	 * 메시지와 리다이렉트할 URL을 모델에 추가 request.setAttribute("msg", "접근할 수 없는 페이지입니다.");
	 * request.setAttribute("url", "/");
	 * 
	 * // RequestDispatcher를 사용하여 message.jsp로 포워딩 RequestDispatcher dispatcher =
	 * request.getRequestDispatcher("/WEB-INF/views/message.jsp");
	 * dispatcher.forward(request, response);
	 * 
	 * // false를 반환하여 요청을 중단 return false; }
	 * 
	 * // true를 반환하여 요청을 컨트롤러로 전달 return true; }
	 */

}