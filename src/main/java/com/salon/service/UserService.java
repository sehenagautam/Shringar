package com.salon.service;

import com.salon.dao.UserDAO;
import com.salon.model.User;

public class UserService {

    private UserDAO dao = new UserDAO();

    public boolean login(User user) {
        return dao.login(user);
    }
}