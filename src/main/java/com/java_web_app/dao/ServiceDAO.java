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

    private String normalizeServiceCode(String code) {
        if (code == null) {
            return null;
        }
        String trimmed = code.trim();
        int lastDash = trimmed.lastIndexOf('-');
        if (lastDash >= 0 && lastDash < trimmed.length() - 1) {
            return trimmed.substring(lastDash + 1);
        }
        return trimmed;
    }

    private Service mapRow(ResultSet rs) throws Exception {
        Service s = new Service();
        s.setServiceId(rs.getInt("service_id"));
        s.setServiceName(rs.getString("service_name"));
        s.setDescription(rs.getString("description"));
        s.setCategory(rs.getString("category"));
        s.setStylistName(rs.getString("stylist_name"));
        s.setServiceCode(normalizeServiceCode(rs.getString("service_code")));
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

    public void ensureDefaultServices() {
        String deleteLegacyDuplicatesSql = """
                DELETE old_s
                FROM services old_s
                JOIN services new_s
                  ON old_s.service_name = new_s.service_name
                WHERE old_s.service_code LIKE 'SRV-%'
                  AND new_s.service_code REGEXP '^[0-9]{3,6}$'
                """;
        String normalizeSql = """
                UPDATE services
                SET service_code = ?
                WHERE service_name = ? AND service_code <> ?
                """;
        String sql = """
                INSERT INTO services (service_name, description, category, stylist_name, service_code, price, duration_minutes, is_active)
                VALUES (?, ?, ?, ?, ?, ?, ?, 1)
                ON DUPLICATE KEY UPDATE service_code = service_code
                """;
        Object[][] defaults = new Object[][] {
                { "Balayage", "Hand-painted highlights", "Hair colour", "Priya Sharma", "100", new BigDecimal("85.00"), 120 },
                { "Classic Manicure", "Shape, cuticle care, polish", "Nails", "Alex Kim", "101", new BigDecimal("35.00"), 45 },
                { "Deep Conditioning", "Repair treatment", "Hair care", "Priya Sharma", "102", new BigDecimal("45.00"), 60 },
                { "Bridal Trial", "Full hair and makeup trial", "Bridal", "Maya Patel", "103", new BigDecimal("120.00"), 150 },
                { "Soft Glam Makeup", "Party-ready soft glam look", "Makeup", "Maya Patel", "104", new BigDecimal("65.00"), 75 },
                { "HD Makeup", "High-definition makeup for photos", "Makeup", "Nisha Rai", "105", new BigDecimal("90.00"), 90 },
                { "Keratin Smooth", "Frizz control and smoothing treatment", "Hair care", "Rina Joshi", "106", new BigDecimal("110.00"), 140 },
                { "Layer Cut + Styling", "Layer haircut with blow dry styling", "Hair care", "Rina Joshi", "107", new BigDecimal("38.00"), 55 },
                { "Global Hair Color", "Single-tone full hair coloring", "Hair colour", "Priya Sharma", "108", new BigDecimal("95.00"), 130 },
                { "Gel Nail Extensions", "Full set gel extensions", "Nails", "Alex Kim", "109", new BigDecimal("70.00"), 90 },
                { "Nail Art Premium", "Creative custom nail art design", "Nails", "Sita Karki", "110", new BigDecimal("55.00"), 75 }
        };
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement deleteLegacyDuplicatesPs = conn.prepareStatement(deleteLegacyDuplicatesSql);
                PreparedStatement normalizePs = conn.prepareStatement(normalizeSql);
                PreparedStatement ps = conn.prepareStatement(sql)) {
            deleteLegacyDuplicatesPs.executeUpdate();
            for (Object[] d : defaults) {
                normalizePs.setString(1, (String) d[4]);
                normalizePs.setString(2, (String) d[0]);
                normalizePs.setString(3, (String) d[4]);
                normalizePs.addBatch();
            }
            normalizePs.executeBatch();
            for (Object[] d : defaults) {
                ps.setString(1, (String) d[0]);
                ps.setString(2, (String) d[1]);
                ps.setString(3, (String) d[2]);
                ps.setString(4, (String) d[3]);
                ps.setString(5, (String) d[4]);
                ps.setBigDecimal(6, (BigDecimal) d[5]);
                ps.setInt(7, (Integer) d[6]);
                ps.addBatch();
            }
            ps.executeBatch();
        } catch (Exception e) {
            e.printStackTrace();
        }
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

    public List<Service> searchAdvanced(String stylist, String codeExact, String keyword, String category) {
        List<Service> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM services WHERE is_active = 1");
        List<String> params = new ArrayList<>();

        if (stylist != null && !stylist.trim().isEmpty()) {
            sql.append(" AND stylist_name LIKE ?");
            params.add("%" + stylist.trim() + "%");
        }
        if (codeExact != null && !codeExact.trim().isEmpty()) {
            sql.append(" AND service_code = ?");
            params.add(codeExact.trim());
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (service_name LIKE ? OR description LIKE ?)");
            String q = "%" + keyword.trim() + "%";
            params.add(q);
            params.add(q);
        }
        if (category != null && !category.trim().isEmpty()) {
            sql.append(" AND category = ?");
            params.add(category.trim());
        }

        sql.append(" ORDER BY category, service_name");

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setString(i + 1, params.get(i));
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

    public List<Service> listByCategories(List<String> categories) {
        List<Service> list = new ArrayList<>();
        if (categories == null || categories.isEmpty()) {
            return list;
        }
        StringBuilder in = new StringBuilder();
        for (int i = 0; i < categories.size(); i++) {
            in.append(i == 0 ? "?" : ",?");
        }
        String sql = "SELECT * FROM services WHERE is_active = 1 AND category IN (" + in + ") ORDER BY service_name";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 0; i < categories.size(); i++) {
                ps.setString(i + 1, categories.get(i));
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
