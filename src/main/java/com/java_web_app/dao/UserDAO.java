package com.java_web_app.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;

import org.mindrot.jbcrypt.BCrypt;

import com.java_web_app.model.User;
import com.java_web_app.utils.DBConnection;

public class UserDAO {

    private static User mapUser(ResultSet rs) throws Exception {
        User u = new User();
        u.setUserId(rs.getInt("user_id"));
        u.setName(rs.getString("full_name"));
        u.setEmail(rs.getString("email"));
        u.setPhone(rs.getString("phone"));
        u.setPasswordHash(rs.getString("password_hash"));
        Date dob = rs.getDate("date_of_birth");
        if (dob != null) {
            u.setDateOfBirth(dob.toLocalDate());
        }
        u.setStatus(rs.getString("status"));
        u.setMembershipLevel(rs.getString("membership_level"));
        int y = rs.getInt("member_since_year");
        if (!rs.wasNull()) {
            u.setMemberSinceYear(y);
        }
        u.setPreferredServices(rs.getString("preferred_services"));
        u.setImage(rs.getString("profile_image"));
        return u;
    }

    public User findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email.trim().toLowerCase());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public User findById(int userId) {
        String sql = "SELECT * FROM users WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean isEmailTakenByOther(String email, int excludeUserId) {
        String sql = "SELECT 1 FROM users WHERE email = ? AND user_id <> ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email.trim().toLowerCase());
            ps.setInt(2, excludeUserId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isEmailTaken(String email) {
        return findByEmail(email) != null;
    }

    public boolean register(User user, String plainPassword) {
        String sql = """
                INSERT INTO users (full_name, email, phone, profile_image, password_hash, date_of_birth,
                    status, membership_level, member_since_year, preferred_services)
                VALUES (?,?,?,?,?,?,?,?,?,?)
                """;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail().trim().toLowerCase());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getImage());
            ps.setString(5, BCrypt.hashpw(plainPassword, BCrypt.gensalt()));
            if (user.getDateOfBirth() != null) {
                ps.setDate(6, Date.valueOf(user.getDateOfBirth()));
            } else {
                ps.setDate(6, null);
            }
            ps.setString(7, "PENDING");
            ps.setString(8, user.getMembershipLevel());
            if (user.getMemberSinceYear() != null) {
                ps.setInt(9, user.getMemberSinceYear());
            } else {
                ps.setNull(9, java.sql.Types.SMALLINT);
            }
            ps.setString(10, user.getPreferredServices());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public User authenticate(String email, String plainPassword) {
        User u = findByEmail(email);
        if (u == null || u.getPasswordHash() == null) {
            return null;
        }
        if (!BCrypt.checkpw(plainPassword, u.getPasswordHash())) {
            return null;
        }
        return u;
    }

    public boolean updateProfile(User user) {
        String sql = """
                UPDATE users SET full_name=?, phone=?, date_of_birth=?,
                    membership_level=?, member_since_year=?, preferred_services=?, profile_image=?
                WHERE user_id=?
                """;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getPhone());
            if (user.getDateOfBirth() != null) {
                ps.setDate(3, Date.valueOf(user.getDateOfBirth()));
            } else {
                ps.setNull(3, java.sql.Types.DATE);
            }
            ps.setString(4, user.getMembershipLevel());
            if (user.getMemberSinceYear() != null) {
                ps.setInt(5, user.getMemberSinceYear());
            } else {
                ps.setNull(5, java.sql.Types.SMALLINT);
            }
            ps.setString(6, user.getPreferredServices());
            ps.setString(7, user.getImage());
            ps.setInt(8, user.getUserId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePasswordHash(int userId, String newPlainPassword) {
        String sql = "UPDATE users SET password_hash=? WHERE user_id=?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, BCrypt.hashpw(newPlainPassword, BCrypt.gensalt()));
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateEmail(int userId, String newEmail) {
        String sql = "UPDATE users SET email=? WHERE user_id=?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newEmail.trim().toLowerCase());
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
