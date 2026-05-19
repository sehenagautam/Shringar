package com.salon.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.salon.model.User;
import com.salon.util.DBConnection;

public class UserDAO {

    public boolean login(User user) {

        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "select * from User where UserEmail=? and UserPassword=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, user.getUserEmail());
            ps.setString(2, user.getUserPassword());

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                status = true;
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }
}