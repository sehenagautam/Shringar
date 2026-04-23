package com.shringar.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.shringar.model.UserModel;
import com.shringar.utils.DBconfig;

public class UserDAO {

    public boolean insertUser(UserModel user) throws Exception {
        Connection con = DBconfig.getConnection();
        String sql = "INSERT INTO user (user_name, user_email, user_phone, user_password, user_role) "
                   + "VALUES (?, ?, ?, ?, ?)";
        
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, user.getUserName());
        pst.setString(2, user.getUserEmail());
        pst.setString(3, user.getUserPhone());
        pst.setString(4, user.getUserPassword());
        pst.setString(5, user.getUserRole());

        boolean success = pst.executeUpdate() > 0;
        pst.close();
        con.close();
        return success;
    }

    public UserModel getUserByEmail(String email) throws Exception {
        UserModel user = null;
        Connection con = DBconfig.getConnection();
        
        String sql = "SELECT * FROM user WHERE user_email = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, email);
        
        ResultSet rs = pst.executeQuery();
        if (rs.next()) {
            user = new UserModel();
            user.setUserId(rs.getInt("user_id"));
            user.setUserName(rs.getString("user_name"));
            user.setUserEmail(rs.getString("user_email"));
            user.setUserPhone(rs.getString("user_phone"));
            user.setUserPassword(rs.getString("user_password"));
            user.setUserRole(rs.getString("user_role"));
        }
        rs.close();
        pst.close();
        con.close();
        return user;
    }
}