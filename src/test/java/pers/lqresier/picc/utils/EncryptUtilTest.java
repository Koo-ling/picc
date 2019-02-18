package pers.lqresier.picc.utils;

import org.junit.Test;

import static org.junit.Assert.*;

public class EncryptUtilTest {

    @Test
    public void MD5Encrypt() {
        System.out.println(EncryptUtil.MD5Encrypt("123456","AKA123458"));
    }
}