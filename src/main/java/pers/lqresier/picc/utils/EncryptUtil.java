package pers.lqresier.picc.utils;

import org.apache.shiro.crypto.hash.SimpleHash;

/**
 * 加密工具类
 * @author LQresier
 */
public class EncryptUtil {

    /**
     * md5加密
     * @param source
     * @param salt
     * @return
     */
    public static String MD5Encrypt(String source,String salt){
        SimpleHash md5 = new SimpleHash("MD5", source, salt, 3);
        return md5.toString();
    }
}
