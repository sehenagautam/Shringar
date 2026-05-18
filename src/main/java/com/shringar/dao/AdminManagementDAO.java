package com.shringar.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.shringar.model.Service;
import com.shringar.utils.DBConnection;
import com.shringar.utils.ExceptionUtil;
import com.shringar.utils.PasswordUtil;

public class AdminManagementDAO {

    private static final DateTimeFormatter TIMESTAMP_FORMAT =
            DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");
    private static final DateTimeFormatter DATE_FORMAT =
            DateTimeFormatter.ofPattern("dd MMM yyyy");
    private static final String CREATE_CONTACT_MESSAGES_SQL = """
            CREATE TABLE IF NOT EXISTS contact_messages (
                message_id INT AUTO_INCREMENT PRIMARY KEY,
                full_name VARCHAR(120) NOT NULL,
                email VARCHAR(150) NOT NULL,
                phone VARCHAR(32) NULL,
                message TEXT NOT NULL,
                created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
            )
            """;

    public List<Map<String, Object>> listUsers() {
        List<Map<String, Object>> users = new ArrayList<>();
        String sql = """
                SELECT user_id, full_name, email, phone, status, membership_level, created_at
                FROM users
                ORDER BY created_at DESC
                """;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                row.put("userId", rs.getInt("user_id"));
                row.put("name", rs.getString("full_name"));
                row.put("email", rs.getString("email"));
                row.put("phone", rs.getString("phone"));
                row.put("status", rs.getString("status"));
                row.put("membershipLevel", rs.getString("membership_level"));
                Timestamp createdAt = rs.getTimestamp("created_at");
                row.put("createdAtDisplay", createdAt != null ? DATE_FORMAT.format(createdAt.toLocalDateTime()) : "Unknown");
                users.add(row);
            }
        } catch (Exception e) {
            ExceptionUtil.log("Failed to list admin users.", e);
        }
        return users;
    }

    public boolean updateUserStatus(int userId, String status) {
        String sql = "UPDATE users SET status = ? WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            ExceptionUtil.log("Failed to update user status.", e);
        }
        return false;
    }

    public boolean createCustomer(String fullName, String email, String phone, String plainPassword, String status,
            String membershipLevel) {
        String sql = """
                INSERT INTO users (full_name, email, phone, profile_image, password_hash, date_of_birth,
                    status, membership_level, member_since_year, preferred_services)
                VALUES (?,?,?,?,?,?,?,?,?,?)
                """;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, email == null ? null : email.trim().toLowerCase());
            ps.setString(3, phone);
            ps.setString(4, null);
            ps.setString(5, PasswordUtil.getHashPassword(plainPassword));
            ps.setNull(6, Types.DATE);
            ps.setString(7, status);
            ps.setString(8, membershipLevel);
            ps.setNull(9, Types.SMALLINT);
            ps.setString(10, "Added by salon admin");
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            ExceptionUtil.log("Failed to create customer from admin.", e);
        }
        return false;
    }

    public List<Service> listServicesForAdmin() {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM services ORDER BY is_active DESC, category, service_name";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                services.add(mapService(rs));
            }
        } catch (Exception e) {
            ExceptionUtil.log("Failed to list admin services.", e);
        }
        if (services.isEmpty()) {
            new ServiceDAO().listAllActive();
            try (Connection conn = DBConnection.getConnection();
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    services.add(mapService(rs));
                }
            } catch (Exception e) {
                ExceptionUtil.log("Failed to reload seeded admin services.", e);
            }
        }
        return services;
    }

    public Service findServiceById(int serviceId) {
        String sql = "SELECT * FROM services WHERE service_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapService(rs);
                }
            }
        } catch (Exception e) {
            ExceptionUtil.log("Failed to find admin service.", e);
        }
        return null;
    }

    public boolean createService(Service service) {
        String sql = """
                INSERT INTO services (service_name, description, category, stylist_name, service_code,
                    price, duration_minutes, is_active)
                VALUES (?,?,?,?,?,?,?,?)
                """;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            fillServiceStatement(ps, service);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            ExceptionUtil.log("Failed to create admin service.", e);
        }
        return false;
    }

    public boolean updateService(Service service) {
        String sql = """
                UPDATE services
                SET service_name = ?, description = ?, category = ?, stylist_name = ?, service_code = ?,
                    price = ?, duration_minutes = ?, is_active = ?
                WHERE service_id = ?
                """;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            fillServiceStatement(ps, service);
            ps.setInt(9, service.getServiceId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            ExceptionUtil.log("Failed to update admin service.", e);
        }
        return false;
    }

    public boolean deactivateService(int serviceId) {
        String sql = "UPDATE services SET is_active = 0 WHERE service_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            ExceptionUtil.log("Failed to deactivate admin service.", e);
        }
        return false;
    }

    public List<Map<String, Object>> listBookingsForAdmin() {
        List<Map<String, Object>> bookings = new ArrayList<>();
        String sql = """
                SELECT b.booking_id, b.user_id, b.service_id, b.appointment_datetime, b.status, b.notes,
                       u.full_name, u.email, s.service_name, s.price
                FROM bookings b
                JOIN users u ON u.user_id = b.user_id
                JOIN services s ON s.service_id = b.service_id
                ORDER BY b.appointment_datetime DESC
                """;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                bookings.add(mapBooking(rs));
            }
        } catch (Exception e) {
            ExceptionUtil.log("Failed to list admin bookings.", e);
        }
        return bookings;
    }

    public Map<String, Object> findBookingById(int bookingId) {
        String sql = """
                SELECT b.booking_id, b.user_id, b.service_id, b.appointment_datetime, b.status, b.notes,
                       u.full_name, u.email, s.service_name, s.price
                FROM bookings b
                JOIN users u ON u.user_id = b.user_id
                JOIN services s ON s.service_id = b.service_id
                WHERE b.booking_id = ?
                """;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapBooking(rs);
                }
            }
        } catch (Exception e) {
            ExceptionUtil.log("Failed to find admin booking.", e);
        }
        return null;
    }

    public boolean createBooking(int userId, int serviceId, LocalDateTime appointment, String status, String notes) {
        String sql = """
                INSERT INTO bookings (user_id, service_id, appointment_datetime, status, notes)
                VALUES (?,?,?,?,?)
                """;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, serviceId);
            ps.setTimestamp(3, Timestamp.valueOf(appointment));
            ps.setString(4, status);
            ps.setString(5, notes);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            ExceptionUtil.log("Failed to create admin booking.", e);
        }
        return false;
    }

    public boolean updateBooking(int bookingId, int userId, int serviceId, LocalDateTime appointment, String status,
            String notes) {
        String sql = """
                UPDATE bookings
                SET user_id = ?, service_id = ?, appointment_datetime = ?, status = ?, notes = ?
                WHERE booking_id = ?
                """;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, serviceId);
            ps.setTimestamp(3, Timestamp.valueOf(appointment));
            ps.setString(4, status);
            ps.setString(5, notes);
            ps.setInt(6, bookingId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            ExceptionUtil.log("Failed to update admin booking.", e);
        }
        return false;
    }

    public boolean deleteBooking(int bookingId) {
        String sql = "DELETE FROM bookings WHERE booking_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            ExceptionUtil.log("Failed to delete admin booking.", e);
        }
        return false;
    }

    public List<Map<String, Object>> listUserOptions() {
        List<Map<String, Object>> users = new ArrayList<>();
        String sql = "SELECT user_id, full_name, email FROM users WHERE status = 'APPROVED' ORDER BY full_name";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                row.put("userId", rs.getInt("user_id"));
                row.put("name", rs.getString("full_name"));
                row.put("email", rs.getString("email"));
                users.add(row);
            }
        } catch (Exception e) {
            ExceptionUtil.log("Failed to list user options.", e);
        }
        return users;
    }

    public List<Service> listActiveServiceOptions() {
        return new ServiceDAO().listAllActive();
    }

    public List<Map<String, Object>> listRequestsForAdmin() {
        List<Map<String, Object>> requests = new ArrayList<>();
        String sql = """
                SELECT ar.request_id, ar.preferred_date, ar.message, ar.status, ar.created_at,
                       u.full_name, u.email, s.service_name
                FROM apply_requests ar
                JOIN users u ON u.user_id = ar.user_id
                JOIN services s ON s.service_id = ar.service_id
                ORDER BY ar.created_at DESC
                """;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                row.put("requestId", rs.getInt("request_id"));
                row.put("preferredDate", rs.getDate("preferred_date") != null
                        ? DATE_FORMAT.format(rs.getDate("preferred_date").toLocalDate())
                        : "Not specified");
                row.put("message", rs.getString("message"));
                row.put("status", rs.getString("status"));
                Timestamp created = rs.getTimestamp("created_at");
                row.put("createdAtDisplay", created != null ? TIMESTAMP_FORMAT.format(created.toLocalDateTime()) : "Unknown");
                row.put("userName", rs.getString("full_name"));
                row.put("userEmail", rs.getString("email"));
                row.put("serviceName", rs.getString("service_name"));
                requests.add(row);
            }
        } catch (Exception e) {
            ExceptionUtil.log("Failed to list admin requests.", e);
        }
        return requests;
    }

    public boolean updateRequestStatus(int requestId, String status) {
        String sql = "UPDATE apply_requests SET status = ? WHERE request_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, requestId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            ExceptionUtil.log("Failed to update admin request status.", e);
        }
        return false;
    }

    public List<Map<String, Object>> listMessagesForAdmin() {
        List<Map<String, Object>> messages = new ArrayList<>();
        String sql = """
                SELECT message_id, full_name, email, phone, message, created_at
                FROM contact_messages
                ORDER BY created_at DESC
                """;
        try (Connection conn = DBConnection.getConnection()) {
            ensureContactMessagesTable(conn);
            try (PreparedStatement ps = conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> row = new LinkedHashMap<>();
                    row.put("messageId", rs.getInt("message_id"));
                    row.put("fullName", rs.getString("full_name"));
                    row.put("email", rs.getString("email"));
                    row.put("phone", rs.getString("phone"));
                    row.put("message", rs.getString("message"));
                    Timestamp created = rs.getTimestamp("created_at");
                    row.put("createdAtDisplay",
                            created != null ? TIMESTAMP_FORMAT.format(created.toLocalDateTime()) : "Unknown");
                    messages.add(row);
                }
            }
        } catch (Exception e) {
            ExceptionUtil.log("Failed to list admin messages.", e);
        }
        return messages;
    }

    public boolean deleteMessage(int messageId) {
        String sql = "DELETE FROM contact_messages WHERE message_id = ?";
        try (Connection conn = DBConnection.getConnection()) {
            ensureContactMessagesTable(conn);
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, messageId);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            ExceptionUtil.log("Failed to delete admin message.", e);
        }
        return false;
    }

    private Service mapService(ResultSet rs) throws Exception {
        Service service = new Service();
        service.setServiceId(rs.getInt("service_id"));
        service.setServiceName(rs.getString("service_name"));
        service.setDescription(rs.getString("description"));
        service.setCategory(rs.getString("category"));
        service.setStylistName(rs.getString("stylist_name"));
        service.setServiceCode(rs.getString("service_code"));
        BigDecimal price = rs.getBigDecimal("price");
        service.setPrice(price != null ? price : BigDecimal.ZERO);
        service.setDurationMinutes(rs.getInt("duration_minutes"));
        service.setActive(rs.getInt("is_active") == 1);
        return service;
    }

    private void fillServiceStatement(PreparedStatement ps, Service service) throws Exception {
        ps.setString(1, service.getServiceName());
        ps.setString(2, service.getDescription());
        ps.setString(3, service.getCategory());
        ps.setString(4, service.getStylistName());
        ps.setString(5, service.getServiceCode());
        ps.setBigDecimal(6, service.getPrice());
        ps.setInt(7, service.getDurationMinutes());
        ps.setInt(8, service.isActive() ? 1 : 0);
    }

    private Map<String, Object> mapBooking(ResultSet rs) throws Exception {
        Map<String, Object> row = new LinkedHashMap<>();
        row.put("bookingId", rs.getInt("booking_id"));
        row.put("userId", rs.getInt("user_id"));
        row.put("serviceId", rs.getInt("service_id"));
        Timestamp appointment = rs.getTimestamp("appointment_datetime");
        LocalDateTime appointmentDateTime = appointment != null ? appointment.toLocalDateTime() : null;
        row.put("appointmentValue", appointmentDateTime != null ? appointmentDateTime.toString() : "");
        row.put("appointmentDisplay", appointmentDateTime != null ? TIMESTAMP_FORMAT.format(appointmentDateTime) : "Not scheduled");
        row.put("status", rs.getString("status"));
        row.put("notes", rs.getString("notes"));
        row.put("customerName", rs.getString("full_name"));
        row.put("customerEmail", rs.getString("email"));
        row.put("serviceName", rs.getString("service_name"));
        row.put("price", rs.getBigDecimal("price"));
        return row;
    }

    private void ensureContactMessagesTable(Connection connection) throws Exception {
        try (Statement statement = connection.createStatement()) {
            statement.executeUpdate(CREATE_CONTACT_MESSAGES_SQL);
        }
    }
}
