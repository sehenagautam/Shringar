package com.shringar.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;

import com.shringar.model.ContactMessage;
import com.shringar.utils.DBConnection;
import com.shringar.utils.ExceptionUtil;

public class ContactMessageDAO {

    private static final String CREATE_TABLE_SQL = """
            CREATE TABLE IF NOT EXISTS contact_messages (
                message_id INT AUTO_INCREMENT PRIMARY KEY,
                full_name VARCHAR(120) NOT NULL,
                email VARCHAR(150) NOT NULL,
                phone VARCHAR(32) NULL,
                message TEXT NOT NULL,
                created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
            )
            """;

    public boolean save(ContactMessage contactMessage) {
        String sql = """
                INSERT INTO contact_messages (full_name, email, phone, message)
                VALUES (?,?,?,?)
                """;
        try (Connection conn = DBConnection.getConnection()) {
            ensureTableExists(conn);
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, contactMessage.getFullName());
                ps.setString(2, contactMessage.getEmail());
                ps.setString(3, contactMessage.getPhone());
                ps.setString(4, contactMessage.getMessage());
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            ExceptionUtil.log("Failed to save contact message.", e);
        }
        return false;
    }

    private void ensureTableExists(Connection connection) throws Exception {
        try (Statement statement = connection.createStatement()) {
            statement.executeUpdate(CREATE_TABLE_SQL);
        }
    }
}
