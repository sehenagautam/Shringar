package com.shringar.service;

import com.shringar.dao.UserDAO;
import com.shringar.model.UserModel;
import com.shringar.utils.PasswordUtil;

public class RegisterService {
    UserDAO dao = new UserDAO();

    public boolean addUser(String userName, String userEmail, String userPhone, String password) throws Exception {
        String hashedPassword = PasswordUtil.getHashPassword(password);
        
        UserModel user = new UserModel();
        user.setUserName(userName);
        user.setUserEmail(userEmail);
        user.setUserPhone(userPhone);
        user.setUserPassword(hashedPassword);
        user.setUserRole("CUSTOMER");

        return dao.insertUser(user);
    }
}