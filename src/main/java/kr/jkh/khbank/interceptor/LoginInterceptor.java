package kr.jkh.khbank.interceptor;

import java.io.PrintWriter;

import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class LoginInterceptor extends HandlerInterceptorAdapter{
	/*
	 * @Autowired MemberService memberService;
	 * 
	 * @Override public void postHandle( HttpServletRequest request,
	 * HttpServletResponse response, Object handler, ModelAndView modelAndView)
	 * throws Exception { SiteManagement user =
	 * (SiteManagement)modelAndView.getModel().get("user"); String url =
	 * (String)modelAndView.getModel().get("url"); String msg =
	 * (String)modelAndView.getModel().get("msg"); System.out.println("url " + url);
	 * System.out.println("msg " + msg);
	 * response.setContentType("text/html; charset=UTF-8"); PrintWriter out =
	 * response.getWriter(); if(user == null) {
	 * out.println("<script>alert('"+msg+"');location.href='"+request.getContextPath
	 * ()+url+"'</script>"); out.flush(); response.flushBuffer(); return; }
	 * request.getSession().setAttribute("user", user); //자동 로그인을 체크했으면
	 * if(user.isAutoLogin()) { //쿠키를 생성해서 String value =
	 * request.getSession().getId(); Cookie cookie = new Cookie("loginCookie", value
	 * ); cookie.setPath("/"); //1주일 int time = 7 * 24 * 60 * 60; //7일을 초로 환산
	 * cookie.setMaxAge(time); //화면에 전송 response.addCookie(cookie); //DB에 관련 정보를 추가
	 * //세션 아이디와 만료시간 user.setSite_cookie(value); Date date = new
	 * Date(System.currentTimeMillis() + time * 1000);
	 * user.setSite_cookie_limit(date); memberService.updateMemberCookie(user); }
	 * //되돌아갈 url이 있으면 해당 url로 돌아감 String prevUrl =
	 * (String)request.getSession().getAttribute("prevUrl"); if(prevUrl != null) {
	 * //response.sendRedirect(prevUrl);
	 * request.getSession().removeAttribute("prevUrl"); //url = prevUrl;
	 * out.println("<script>alert('"+msg+"');location.href='"+prevUrl+"'</script>");
	 * out.flush(); response.flushBuffer(); return; }
	 * 
	 * out.println("<script>alert('"+msg+"');location.href='"+request.getContextPath
	 * ()+url+"'</script>"); out.flush(); response.flushBuffer(); }
	 */
}