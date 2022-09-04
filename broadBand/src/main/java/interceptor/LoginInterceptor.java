package interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		String isLogin = (String) session.getAttribute("isLogin");
		if(isLogin!=null&&isLogin=="true") {
			return true;
		}else {
			request.getRequestDispatcher("WEB-INF/login.jsp").forward(request, response);
			return false;
		}
		
	}
	
}
