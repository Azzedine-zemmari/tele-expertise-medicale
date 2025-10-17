package org.medicale.teleexpertisemedicale.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.UUID;

@WebFilter("/*")
public class CsrfFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession();

        if(session.getAttribute("csrfToken") == null) {
            session.setAttribute("csrfToken", UUID.randomUUID().toString());
        }

        if("POST".equalsIgnoreCase(request.getMethod())) {
            String csrfToken = request.getParameter("csrfToken");
            String tokenSession = (String) session.getAttribute("csrfToken");
            if(tokenSession == null || !tokenSession.equals(csrfToken)) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN,"CSRF TOKEN INVALID");
                return;
            }
        }
        filterChain.doFilter(request, response);
    }
}
