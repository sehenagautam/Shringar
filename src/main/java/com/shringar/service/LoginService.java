package com.shringar.service;

import com.shringar.dao.UserDAO;
import com.shringar.model.UserModel;
import com.shringar.utils.PasswordUtil;

public class LoginService {
    UserDAO userDAO = new UserDAO();

    public String authenticate(String email, String password) {
        if (email == null || email.trim().isEmpty()) return "Email is required";
        if (password == null || password.isEmpty()) return "Password is required";

        try {
            UserModel user = userDAO.getUserByEmail(email);
            if (user == null) return "User doesn't exist";
            if (PasswordUtil.checkPassword(password, user.getUserPassword())) {
                return "Success";
            } else {
                return "Password is incorrect";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "Error in Database";
        }
    }
}