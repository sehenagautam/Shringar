package com.shringar.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.shringar.model.ApplyRequest;
import com.shringar.utils.DBConnection;
import com.shringar.utils.ExceptionUtil;

public class ApplyRequestDAO {

    public boolean insert(ApplyRequest r) {
        String sql = """
                INSERT INTO apply_requests (user_id, service_id, preferred_date, message, status)
                VALUES (?,?,?,?,?)
                """;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, r.getUserId());
            ps.setInt(2, r.getServiceId());
            if (r.getPreferredDate() != null) {
                ps.setDate(3, Date.valueOf(r.getPreferredDate()));
            } else {
                ps.setNull(3, java.sql.Types.DATE);
            }
            ps.setString(4, r.getMessage());
            ps.setString(5, r.getStatus() != null ? r.getStatus() : "PENDING");
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            ExceptionUtil.log("Failed to insert apply request.", e);
        }
        return false;
    }

    public List<ApplyRequest> findByUserId(int userId) {
        List<ApplyRequest> list = new ArrayList<>();
        String sql = """
                SELECT request_id, user_id, service_id, preferred_date, message, status, created_at
                FROM apply_requests
                WHERE user_id = ?
                ORDER BY created_at DESC
                """;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ApplyRequest request = new ApplyRequest();
                    request.setRequestId(rs.getInt("request_id"));
                    request.setUserId(rs.getInt("user_id"));
                    request.setServiceId(rs.getInt("service_id"));
                    Date preferredDate = rs.getDate("preferred_date");
                    if (preferredDate != null) {
                        request.setPreferredDate(preferredDate.toLocalDate());
                    }
                    request.setMessage(rs.getString("message"));
                    request.setStatus(rs.getString("status"));
                    if (rs.getTimestamp("created_at") != null) {
                        request.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    }
                    list.add(request);
                }
            }
        } catch (Exception e) {
            ExceptionUtil.log("Failed to load apply requests.", e);
        }
        return list;
    }

    public int countPendingByUserId(int userId) {
        String sql = "SELECT COUNT(*) FROM apply_requests WHERE user_id = ? AND status = 'PENDING'";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            ExceptionUtil.log("Failed to count pending apply requests.", e);
        }
        return 0;
    }
}
