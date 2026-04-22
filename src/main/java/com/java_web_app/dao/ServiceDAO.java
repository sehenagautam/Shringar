package com.java_web_app.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.java_web_app.model.Service;
import com.java_web_app.utils.DBConnection;

public class ServiceDAO {

    private Service mapRow(ResultSet rs) throws Exception {
        Service s = new Service();
        s.setServiceId(rs.getInt("service_id"));
        s.setServiceName(rs.getString("service_name"));
        s.setDescription(rs.getString("description"));
        s.setCategory(rs.getString("category"));
        s.setStylistName(rs.getString("stylist_name"));
        s.setServiceCode(rs.getString("service_code"));
        BigDecimal p = rs.getBigDecimal("price");
        s.setPrice(p != null ? p : BigDecimal.ZERO);
        s.setDurationMinutes(rs.getInt("duration_minutes"));
        s.setActive(rs.getInt("is_active") == 1);
        return s;
    }

    public Service findById(int serviceId) {
        String sql = "SELECT * FROM services WHERE service_id = ? AND is_active = 1";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, serviceId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Service> listAllActive() {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT * FROM services WHERE is_active = 1 ORDER BY category, service_name";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Service> findByIds(List<Integer> ids) {
        List<Service> list = new ArrayList<>();
        if (ids == null || ids.isEmpty()) {
            return list;
        }
        StringBuilder in = new StringBuilder();
        for (int i = 0; i < ids.size(); i++) {
            in.append(i == 0 ? "?" : ",?");
        }
        String sql = "SELECT * FROM services WHERE service_id IN (" + in + ") AND is_active = 1";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 0; i < ids.size(); i++) {
                ps.setInt(i + 1, ids.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Service> searchByStylist(String stylistFragment) {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT * FROM services WHERE is_active = 1 AND stylist_name LIKE ? ORDER BY service_name";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + stylistFragment.trim() + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Service> searchByServiceCode(String codeExact) {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT * FROM services WHERE is_active = 1 AND service_code = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, codeExact.trim());
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Service> searchKeyword(String keyword) {
        List<Service> list = new ArrayList<>();
        if (keyword == null || keyword.trim().isEmpty()) {
            return list;
        }
        String q = "%" + keyword.trim() + "%";
        String sql = """
                SELECT * FROM services WHERE is_active = 1 AND (
                    service_name LIKE ? OR description LIKE ? OR category LIKE ?
                    OR stylist_name LIKE ? OR service_code LIKE ?)
                ORDER BY service_name
                """;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 1; i <= 5; i++) {
                ps.setString(i, q);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Service> listByCategory(String category) {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT * FROM services WHERE is_active = 1 AND category = ? ORDER BY service_name";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, category.trim());
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<String> listDistinctCategories() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT category FROM services WHERE is_active = 1 ORDER BY category";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(rs.getString(1));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Service> findMostBooked(int limit) {
        List<Service> list = new ArrayList<>();
        String sql = """
                SELECT s.*, COUNT(b.booking_id) AS cnt
                FROM services s
                LEFT JOIN bookings b ON b.service_id = s.service_id
                WHERE s.is_active = 1
                GROUP BY s.service_id
                ORDER BY cnt DESC, s.service_name
                LIMIT ?
                """;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
