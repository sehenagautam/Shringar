package com.shringar.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.shringar.model.Service;
import com.shringar.utils.DBConnection;
import com.shringar.utils.ExceptionUtil;

public class ServiceDAO {

    // Used to bootstrap a friendly starter catalog when the services table is empty.
    private static final String[][] STARTER_SERVICES = {
            {"Rapid Refresh Haircut", "A quick haircut to keep your look clean and refreshed.", "Hair", "Shringar Hair Team", "HAIR-REFRESH-01", "1000.00", "45"},
            {"Rose Reinvention Haircut", "A full style transformation to refresh and redefine your look.", "Hair", "Shringar Hair Team", "HAIR-ROSE-02", "1500.00", "75"},
            {"Long Length Haircut & Style", "A cut for longer hair, keeping it healthy and looking its best.", "Hair", "Shringar Hair Team", "HAIR-LONG-03", "1700.00", "80"},
            {"Curly Haircut", "A haircut designed for natural curls and soft movement.", "Hair", "Shringar Hair Team", "HAIR-CURL-04", "1600.00", "70"},
            {"Short Haircut", "A modern short haircut for a clean and confident style.", "Hair", "Shringar Hair Team", "HAIR-SHORT-05", "1200.00", "50"},
            {"Children's Haircut", "A fresh haircut made just for kids.", "Hair", "Shringar Hair Team", "HAIR-KIDS-06", "1000.00", "35"},
            {"Bridal Makeup", "Long-lasting bridal makeup that enhances natural beauty for the special day.", "Makeup", "Shringar Makeup Team", "MAKEUP-BRIDAL-01", "8000.00", "150"},
            {"Party Glam Makeup", "A glamorous makeup look with bold eyes and glowing skin.", "Makeup", "Shringar Makeup Team", "MAKEUP-PARTY-02", "3000.00", "90"},
            {"Engagement Makeup", "Elegant makeup designed to give a glowing engagement look.", "Makeup", "Shringar Makeup Team", "MAKEUP-ENGAGE-03", "5000.00", "120"},
            {"Natural Everyday Makeup", "Light and breathable makeup for a clean daily look.", "Makeup", "Shringar Makeup Team", "MAKEUP-NATURAL-04", "2000.00", "60"},
            {"HD Makeup", "High-definition makeup for a smooth, photo-ready finish.", "Makeup", "Shringar Makeup Team", "MAKEUP-HD-05", "4500.00", "100"},
            {"Soft Glam Makeup", "A fresh soft glam look with natural tones.", "Makeup", "Shringar Makeup Team", "MAKEUP-SOFT-06", "2500.00", "75"},
            {"Gel Polish Nails", "Glossy gel polish with long-lasting shine.", "Nail", "Shringar Nail Team", "NAIL-GEL-01", "1200.00", "45"},
            {"Nail Art Design", "Creative nail art designs to complete your look.", "Nail", "Shringar Nail Team", "NAIL-ART-02", "1500.00", "60"},
            {"Acrylic Nail Extensions", "Durable nail extensions that add length and beauty.", "Nail", "Shringar Nail Team", "NAIL-ACRYLIC-03", "2000.00", "90"},
            {"French Tip Nails", "Classic white-tip nail styling for a polished finish.", "Nail", "Shringar Nail Team", "NAIL-FRENCH-04", "1300.00", "55"},
            {"Soft Gel / Natural Nude Nails", "A soft nude nail style with an elegant glossy finish.", "Nail", "Shringar Nail Team", "NAIL-NUDE-05", "1400.00", "60"},
            {"Floral Nail Art Design", "Delicate floral nail designs for a charming look.", "Nail", "Shringar Nail Team", "NAIL-FLORAL-06", "1800.00", "75"}
    };

    private Service mapRow(ResultSet rs) throws Exception {
        // Keeps SQL-reading details in one place so search/list methods stay tidy.
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
            ExceptionUtil.log("Failed to find service by id.", e);
        }
        return null;
    }

    public List<Service> listAllActive() {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT * FROM services WHERE is_active = 1 ORDER BY category, service_name";
        try (Connection conn = DBConnection.getConnection()) {
            // Local/dev databases can start empty, so seed before the first read.
            seedStarterServicesIfEmpty(conn);
            try (PreparedStatement ps = conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (Exception e) {
            ExceptionUtil.log("Failed to list active services.", e);
        }
        return list;
    }

    public List<Service> searchServices(String keyword, String category, String stylistFragment, String codeExact) {
        List<Service> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM services WHERE is_active = 1");
        List<String> params = new ArrayList<>();

        // Build up the query from whichever filters the UI actually supplied.
        if (category != null && !category.trim().isEmpty()) {
            sql.append(" AND (category LIKE ? OR service_name LIKE ? OR description LIKE ?)");
            String cat = "%" + category.trim() + "%";
            params.add(cat);
            params.add(cat);
            params.add(cat);
        }
        if (stylistFragment != null && !stylistFragment.trim().isEmpty()) {
            sql.append(" AND stylist_name LIKE ?");
            params.add("%" + stylistFragment.trim() + "%");
        }
        if (codeExact != null && !codeExact.trim().isEmpty()) {
            sql.append(" AND service_code = ?");
            params.add(codeExact.trim());
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("""
                     AND (
                        service_name LIKE ? OR description LIKE ? OR category LIKE ?
                        OR stylist_name LIKE ? OR service_code LIKE ?)
                    """);
            String q = "%" + keyword.trim() + "%";
            for (int i = 0; i < 5; i++) {
                params.add(q);
            }
        }

        sql.append(" ORDER BY category, service_name");

        try (Connection conn = DBConnection.getConnection()) {
            seedStarterServicesIfEmpty(conn);
            try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
                for (int i = 0; i < params.size(); i++) {
                    ps.setString(i + 1, params.get(i));
                }
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        list.add(mapRow(rs));
                    }
                }
            }
        } catch (Exception e) {
            ExceptionUtil.log("Failed to search services.", e);
        }
        return list;
    }

    public List<Service> findByIds(List<Integer> ids) {
        List<Service> list = new ArrayList<>();
        if (ids == null || ids.isEmpty()) {
            return list;
        }
        // Prepared placeholders are built dynamically so the query stays safe
        // even when the wishlist contains an arbitrary number of service IDs.
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
            ExceptionUtil.log("Failed to find services by ids.", e);
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
            ExceptionUtil.log("Failed to search services by stylist.", e);
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
            ExceptionUtil.log("Failed to search services by code.", e);
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
            ExceptionUtil.log("Failed to search services by keyword.", e);
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
            ExceptionUtil.log("Failed to list services by category.", e);
        }
        return list;
    }

    public List<String> listDistinctCategories() {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT category FROM services WHERE is_active = 1 ORDER BY category";
        try (Connection conn = DBConnection.getConnection()) {
            seedStarterServicesIfEmpty(conn);
            try (PreparedStatement ps = conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(rs.getString(1));
                }
            }
        } catch (Exception e) {
            ExceptionUtil.log("Failed to list service categories.", e);
        }
        return list;
    }

    private void seedStarterServicesIfEmpty(Connection conn) throws Exception {
        String countSql = "SELECT COUNT(*) FROM services WHERE is_active = 1";
        try (PreparedStatement count = conn.prepareStatement(countSql);
                ResultSet rs = count.executeQuery()) {
            if (rs.next() && rs.getInt(1) > 0) {
                return;
            }
        }

        // Batch insert keeps first-run setup fast and leaves duplicate-safe
        // updates in place if the starter catalog already exists.
        String insertSql = """
                INSERT INTO services (service_name, description, category, stylist_name, service_code,
                    price, duration_minutes, is_active)
                VALUES (?,?,?,?,?,?,?,1)
                ON DUPLICATE KEY UPDATE
                    service_name = VALUES(service_name),
                    description = VALUES(description),
                    category = VALUES(category),
                    stylist_name = VALUES(stylist_name),
                    price = VALUES(price),
                    duration_minutes = VALUES(duration_minutes),
                    is_active = VALUES(is_active)
                """;
        try (PreparedStatement ps = conn.prepareStatement(insertSql)) {
            for (String[] row : STARTER_SERVICES) {
                ps.setString(1, row[0]);
                ps.setString(2, row[1]);
                ps.setString(3, row[2]);
                ps.setString(4, row[3]);
                ps.setString(5, row[4]);
                ps.setBigDecimal(6, new BigDecimal(row[5]));
                ps.setInt(7, Integer.parseInt(row[6]));
                ps.addBatch();
            }
            ps.executeBatch();
        }
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
            ExceptionUtil.log("Failed to find most booked services.", e);
        }
        return list;
    }
}
