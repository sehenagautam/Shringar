package com.shringar.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.shringar.model.Booking;
import com.shringar.utils.DBConnection;
import com.shringar.utils.ExceptionUtil;

public class BookingDAO {

    private Booking mapRow(ResultSet rs) throws Exception {
        Booking b = new Booking();
        b.setBookingId(rs.getInt("booking_id"));
        b.setUserId(rs.getInt("user_id"));
        b.setServiceId(rs.getInt("service_id"));
        Timestamp ts = rs.getTimestamp("appointment_datetime");
        if (ts != null) {
            b.setAppointmentDatetime(ts.toLocalDateTime());
        }
        b.setStatus(rs.getString("status"));
        b.setNotes(rs.getString("notes"));
        b.setServiceName(rs.getString("service_name"));
        b.setStylistName(rs.getString("stylist_name"));
        b.setCategory(rs.getString("category"));
        return b;
    }

    public List<Booking> findByUserId(int userId) {
        List<Booking> list = new ArrayList<>();
        String sql = """
                SELECT b.*, s.service_name, s.stylist_name, s.category
                FROM bookings b
                JOIN services s ON s.service_id = b.service_id
                WHERE b.user_id = ?
                ORDER BY b.appointment_datetime DESC
                """;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (Exception e) {
            ExceptionUtil.log("Failed to load bookings by user.", e);
        }
        return list;
    }

    public int countByUserId(int userId) {
        String sql = "SELECT COUNT(*) FROM bookings WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            ExceptionUtil.log("Failed to count bookings by user.", e);
        }
        return 0;
    }

    public boolean insert(int userId, int serviceId, LocalDateTime appointment, String notes) {
        String sql = """
                INSERT INTO bookings (user_id, service_id, appointment_datetime, status, notes)
                VALUES (?,?,?,?,?)
                """;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, serviceId);
            ps.setTimestamp(3, Timestamp.valueOf(appointment));
            ps.setString(4, "CONFIRMED");
            ps.setString(5, notes);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            ExceptionUtil.log("Failed to create booking.", e);
        }
        return false;
    }
}
