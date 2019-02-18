package pers.lqresier.picc.shiro;

import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import pers.lqresier.picc.entity.User;
import pers.lqresier.picc.service.UserService;

import java.util.HashSet;
import java.util.Set;

public class UserRealm extends AuthorizingRealm {
    //    private static Logger logger= LoggerFactory.getLogger(UserRealm.class);
    @Autowired
    UserService userService;

    @Override
    public String getName() {
        return "UserRealm";
    }

    /**
     * 赋予权限
     *
     * @param principalCollection
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        User user = (User) principalCollection.getPrimaryPrincipal();
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        Set<String> roleSet = new HashSet<>();
        if (user != null) {
            if (user.getRole() == 0) {
                //出单人员
                //跳转到前台页面
                roleSet.add("front");
            } else if (user.getRole() == 1) {
                //保险公司管理员
                //跳转到后台页面
                roleSet.add("admin");
            } else {
                //景区管理人员
                //跳转到后台页面
                roleSet.add("admin");
            }
            info.addRoles(roleSet);
        }
        return info;
    }

    /**
     * 验证登录
     *
     * @param authenticationToken
     * @return
     * @throws UnknownAccountException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws UnknownAccountException {
        UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
        User user = null;
        try {
            user = userService.login(token.getUsername());
        } catch (Exception e) {
            throw new UnknownAccountException();
        }
        if (user != null) {
            SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(user, user.getPassword(), ByteSource.Util.bytes(user.getUsername()), getName());
            return info;
        } else {
            throw new UnknownAccountException();
        }
    }
}
