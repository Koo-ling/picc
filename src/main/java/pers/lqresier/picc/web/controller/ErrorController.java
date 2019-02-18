package pers.lqresier.picc.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("error")
@Controller
public class ErrorController {

    @RequestMapping("404")
    public String error_404(){
        return "error/404.html";
    }

    @RequestMapping("500")
    public String error_500(){
        return "error/500.html";
    }

    @RequestMapping("403")
    public String error_403(){
        return "error/403.html";
    }
}
