package com.shringar.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;

import com.shringar.model.User;
import com.shringar.model.UserModel;
import com.shringar.utils.DBConnection;
import com.shringar.utils.ExceptionUtil;
import com.shringar.utils.PasswordUtil;

public class UserDAO {

    private static User mapUser(ResultSet rs) throws Exception {
        // One place to translate raw SQL rows into the richer domain model.
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setPasswordHash(rs.getString("password_hash"));

        Date dob = rs.getDate("date_of_birth");
        if (dob != null) {
            user.setDateOfBirth(dob.toLocalDate());
        }

        user.setStatus(rs.getString("status"));
        user.setMembershipLevel(rs.getString("membership_level"));

        int memberSinceYear = rs.getInt("member_since_year");
        if (!rs.wasNull()) {
            user.setMemberSinceYear(memberSinceYear);
        }

        user.setPreferredServices(rs.getString("preferred_services"));
        user.setImage(rs.getString("profile_image"));
        return user;
    }

    private static String normalizeEmail(String email) {
        // Lower-casing here avoids duplicate accounts that differ only by case.
        return email == null ? "" : email.trim().toLowerCase();
    }

    public User findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, normalizeEmail(email));
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (Exception e) {
            ExceptionUtil.log("Failed to find user by email.", e);
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
            ExceptionUtil.log("Failed to find user by id.", e);
        }
        return null;
    }

    public boolean isEmailTakenByOther(String email, int excludeUserId) {
        String sql = "SELECT 1 FROM users WHERE email = ? AND user_id <> ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, normalizeEmail(email));
            ps.setInt(2, excludeUserId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            ExceptionUtil.log("Failed to check duplicate email for profile update.", e);
        }
        return false;
    }

    public boolean isEmailTaken(String email) {
        return findByEmail(email) != null;
    }

    public void ensureAdminAccount() {
        // The project expects one default admin account, so we upsert it instead
        // of assuming the database was pre-seeded correctly.
        String sql = """
                INSERT INTO users (full_name, email, phone, password_hash, date_of_birth, status,
                    membership_level, member_since_year, preferred_services, profile_image)
                VALUES (?,?,?,?,?,?,?,?,?,?)
                ON DUPLICATE KEY UPDATE
                    full_name = VALUES(full_name),
                    password_hash = VALUES(password_hash),
                    status = VALUES(status),
                    membership_level = VALUES(membership_level),
                    preferred_services = VALUES(preferred_services)
                """;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "Shringar Admin");
            ps.setString(2, "admin@shringar.com");
            ps.setString(3, "9800000001");
            ps.setString(4, PasswordUtil.getHashPassword("password"));
            ps.setDate(5, Date.valueOf("1995-01-01"));
            ps.setString(6, "APPROVED");
            ps.setString(7, "Administration");
            ps.setInt(8, 2024);
            ps.setString(9, "Dashboard management");
            ps.setString(10, null);
            ps.executeUpdate();
        } catch (Exception e) {
            ExceptionUtil.log("Failed to ensure admin account.", e);
        }
    }

    public boolean register(User user, String plainPassword) {
        // Registration always stores a hashed password; plain text never reaches the table.
        String sql = """
                INSERT INTO users (full_name, email, phone, profile_image, password_hash, date_of_birth,
                    status, membership_level, member_since_year, preferred_services)
                VALUES (?,?,?,?,?,?,?,?,?,?)
                """;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getName());
            ps.setString(2, normalizeEmail(user.getEmail()));
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getImage());
            ps.setString(5, PasswordUtil.getHashPassword(plainPassword));

            if (user.getDateOfBirth() != null) {
                ps.setDate(6, Date.valueOf(user.getDateOfBirth()));
            } else {
                ps.setNull(6, Types.DATE);
            }

            String status = user.getStatus();
            ps.setString(7, status == null || status.isBlank() ? "PENDING" : status.trim().toUpperCase());
            ps.setString(8, user.getMembershipLevel());

            if (user.getMemberSinceYear() != null) {
                ps.setInt(9, user.getMemberSinceYear());
            } else {
                ps.setNull(9, Types.SMALLINT);
            }

            ps.setString(10, user.getPreferredServices());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            ExceptionUtil.log("Failed to register user.", e);
        }
        return false;
    }

    public User authenticate(String email, String plainPassword) {
        // Email lookup and password verification stay separate so the rest of
        // the app never needs to know how password hashing is implemented.
        User user = findByEmail(email);
        if (user == null || user.getPasswordHash() == null) {
            return null;
        }
        if (!PasswordUtil.checkPassword(plainPassword, user.getPasswordHash())) {
            return null;
        }
        return user;
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
                ps.setNull(3, Types.DATE);
            }

            ps.setString(4, user.getMembershipLevel());

            if (user.getMemberSinceYear() != null) {
                ps.setInt(5, user.getMemberSinceYear());
            } else {
                ps.setNull(5, Types.SMALLINT);
            }

            ps.setString(6, user.getPreferredServices());
            ps.setString(7, user.getImage());
            ps.setInt(8, user.getUserId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            ExceptionUtil.log("Failed to update user profile.", e);
        }
        return false;
    }

    public boolean updatePasswordHash(int userId, String newPlainPassword) {
        String sql = "UPDATE users SET password_hash=? WHERE user_id=?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, PasswordUtil.getHashPassword(newPlainPassword));
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            ExceptionUtil.log("Failed to update password hash.", e);
        }
        return false;
    }

    public boolean updateEmail(int userId, String newEmail) {
        String sql = "UPDATE users SET email=? WHERE user_id=?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, normalizeEmail(newEmail));
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            ExceptionUtil.log("Failed to update email.", e);
        }
        return false;
    }

    public boolean insertUser(UserModel user) {
        String sql = """
                INSERT INTO users (full_name, email, phone, password_hash, status)
                VALUES (?,?,?,?,?)
                """;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUserName());
            ps.setString(2, normalizeEmail(user.getUserEmail()));
            ps.setString(3, user.getUserPhone());
            ps.setString(4, user.getUserPassword());
            ps.setString(5, "APPROVED");
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            ExceptionUtil.log("Failed to insert legacy user.", e);
        }
        return false;
    }

    public UserModel getUserByEmail(String email) {
        User user = findByEmail(email);
        if (user == null) {
            return null;
        }

        // Legacy pages still expect UserModel, so we adapt the newer User here.
        UserModel legacyUser = new UserModel();
        legacyUser.setUserId(user.getUserId());
        legacyUser.setUserName(user.getName());
        legacyUser.setUserEmail(user.getEmail());
        legacyUser.setUserPhone(user.getPhone());
        legacyUser.setUserPassword(user.getPasswordHash());
        legacyUser.setUserRole("CUSTOMER");
        return legacyUser;
    }
}
