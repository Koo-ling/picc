package pers.lqresier.picc.configuration;

import at.pollux.thymeleaf.shiro.dialect.ShiroDialect;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.apache.shiro.mgt.SecurityManager;
import pers.lqresier.picc.shiro.CustomRolesAuthorizationFilter;
import pers.lqresier.picc.shiro.UserRealm;

import javax.servlet.Filter;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

@Configuration
public class ShiroConfig {

    @Bean
    public ShiroDialect shiroDialect() {
        return new ShiroDialect();
    }

    /**
     * 配置shiro过滤器
     *
     * @param securityManager
     * @return
     */
    @Bean("shiroFilter")
    public ShiroFilterFactoryBean shiroFilter(SecurityManager securityManager) {
        ShiroFilterFactoryBean shiroFilter = new ShiroFilterFactoryBean();
        shiroFilter.setSecurityManager(securityManager);
        Map<String, Filter> filters=new HashMap<>();
        filters.put("customRoles",new CustomRolesAuthorizationFilter());
        shiroFilter.setFilters(filters);
        Map<String, String> filterChainMap = new LinkedHashMap<>();
        filterChainMap.put("/static/**", "anon");
        filterChainMap.put("/login", "anon");
        filterChainMap.put("/logout", "logout");
        filterChainMap.put("/system/policy/addPolicy", "authc,customRoles[front,admin]");
        filterChainMap.put("/system/product/queryProductAjax", "authc,customRoles[front,admin]");
        filterChainMap.put("/view/system/individual", "authc,roles[front]");
        filterChainMap.put("/system/**", "authc,roles[admin]");
        filterChainMap.put("/view/**", "authc,roles[admin]");
        filterChainMap.put("/**", "authc");
        shiroFilter.setLoginUrl("/");
        shiroFilter.setUnauthorizedUrl("/error/403.html");
        shiroFilter.setFilterChainDefinitionMap(filterChainMap);
        return shiroFilter;
    }

    @Bean
    public SecurityManager securityManager() {
        DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
        securityManager.setRealm(userRealm());
        return securityManager;
    }

    @Bean
    public UserRealm userRealm() {
        UserRealm userRealm = new UserRealm();
        return userRealm;
    }

    /**
     * 使权限注解生效
     *
     * @param securityManager
     * @return
     */
    @Bean
    public AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor(SecurityManager securityManager) {
        AuthorizationAttributeSourceAdvisor advisor = new AuthorizationAttributeSourceAdvisor();
        advisor.setSecurityManager(securityManager);
        return advisor;
    }
}
