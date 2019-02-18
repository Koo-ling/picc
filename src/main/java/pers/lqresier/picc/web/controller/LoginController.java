package pers.lqresier.picc.web.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import pers.lqresier.picc.entity.User;
import pers.lqresier.picc.service.LogService;
import pers.lqresier.picc.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

@Controller
public class LoginController {
    private Logger logger = LoggerFactory.getLogger(LoginController.class);
    @Autowired
    private UserService userService;
    @Autowired
    private LogService logService;

//    /**
//     * 登录
//     * 登录成功，把user放入session中
//     *
//     * @return
//     */
//    @RequestMapping("login")
//    public String login(@RequestParam("user.username") String username, @RequestParam("user.password") String password, HttpServletRequest request, HttpSession session) {
//        User user=null;
//        try {
//            user = userService.login(username, password);
//        } catch (Exception e) {
//            logger.debug("登录查询失败");
//            logger.error("登录查询失败");
//        }
//        if (user == null) {
//            //用户名或密码错误
//            String errorMessage = "用户名或密码错误,请重新登录";
//            request.setAttribute("errorMessage", errorMessage);
//            return "login.html";
//        }
//        session.setAttribute("user", user);
//        try {
//            logService.addLog(user, "登录模块", "login", null);
//        } catch (Exception e) {
//            logger.debug("登录：添加日志失败");
//            logger.error("登录：添加日志失败");
//        }
//        if (user.getRole() == 0) {
//            //出单人员
//            //跳转到前台页面
//            return "redirect:/view/system/individual";
//        } else if (user.getRole() == 1) {
//            //保险公司管理员
//            //跳转到后台页面
//            return "redirect:/view/system/main";
//        } else {
//            //景区管理人员
//            //跳转到后台页面
//            return "redirect:/view/system/main";
//        }
//    }

//    /**
//     * 处理登录失败
//     * @return
//     */
//    @RequestMapping("login")
//    public String login(HttpServletRequest request) {
//        String exception= (String)request.getAttribute("shiroLoginFailure");
//        if(exception!=null){
//            if(UnknownAccountException.class.getName().equals(exception)){
//                request.setAttribute("errorMessage","用户名错误");
//            }else if(IncorrectCredentialsException.class.getName().equals(exception)){
//                request.setAttribute("errorMessage","密码错误");
//            }else{
//                request.setAttribute("errorMessage","未知错误");
//            }
//        }
//        System.out.println("登陆失败");
//        return "forward:login.html";
//    }

    /**
     * 登录
     *
     * @return
     */
    @RequestMapping("login")
    public String login(String username, String password, HttpServletRequest request, HttpSession session) {
        UsernamePasswordToken token = new UsernamePasswordToken(username, password);
        Subject subject = SecurityUtils.getSubject();
        try {
            subject.login(token);
            User user = (User) subject.getPrincipal();
            session.setAttribute("user", user);
            if (subject.hasRole("admin")) {
                //保险公司管理员
                //跳转到后台页面
                return "redirect:/view/system/main";
            } else if(subject.hasRole("front")){
                //出单人员
                //跳转到前台页面
                return "redirect:/view/system/individual";
            }
        } catch (UnknownAccountException e1) {
            request.setAttribute("errorMessage", "用户名错误");
        } catch (IncorrectCredentialsException e2) {
            request.setAttribute("errorMessage", "密码错误");
        } catch (Exception e) {
        }
        return "login.html";
    }

    /**
     * 登出
     * 将session销毁
     *
     * @return
     */
    @RequestMapping("logout")
    public String logout(HttpSession session) {
        //将session销毁
        session.invalidate();
        //跳转到登录界面
        return "login.html";
    }
}
