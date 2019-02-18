package pers.lqresier.picc.shiro;

import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authz.AuthorizationFilter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class CustomRolesAuthorizationFilter extends AuthorizationFilter {
    @Override
    protected boolean isAccessAllowed(ServletRequest servletRequest, ServletResponse servletResponse, Object o) throws Exception {
        Subject subject = getSubject(servletRequest, servletResponse);
        String[] rolesArray = (String[]) o;
        if(rolesArray==null||rolesArray.length==0){
            return true;
        }
        for(int i=0;i<rolesArray.length;i++){
            if(subject.hasRole(rolesArray[i])){
                //如果用户有其中任意一个角色就有权限
                return true;
            }
        }
        return false;
    }
}
