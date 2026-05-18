package com.shringar.dao;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;

import com.shringar.model.AdminBookingSummary;
import com.shringar.model.AdminDashboardData;
import com.shringar.model.AdminReportMetric;
import com.shringar.model.AdminReportSection;
import com.shringar.model.AdminServiceSummary;
import com.shringar.model.AdminUserSummary;
import com.shringar.model.ContactMessage;
import com.shringar.utils.DBConnection;
import com.shringar.utils.ExceptionUtil;

public class AdminDashboardDAO {

    private static final DateTimeFormatter TIMESTAMP_FORMAT =
            DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");
    private static final DateTimeFormatter DATE_FORMAT =
            DateTimeFormatter.ofPattern("dd MMM yyyy");
    private static final DecimalFormat PERCENT_FORMAT = new DecimalFormat("0.0");
    private static final DecimalFormat MONEY_FORMAT = new DecimalFormat("#,##0.00");
    private static final String CREATE_CONTACT_TABLE_SQL = """
            CREATE TABLE IF NOT EXISTS contact_messages (
                message_id INT AUTO_INCREMENT PRIMARY KEY,
                full_name VARCHAR(120) NOT NULL,
                email VARCHAR(150) NOT NULL,
                phone VARCHAR(32) NULL,
                message TEXT NOT NULL,
                created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
            )
            """;

    public AdminDashboardData loadDashboardData() {
        AdminDashboardData data = new AdminDashboardData();

        try (Connection conn = DBConnection.getConnection()) {
            ensureContactTableExists(conn);

            data.setGeneratedAtDisplay(TIMESTAMP_FORMAT.format(LocalDateTime.now()));
            data.setTotalUsers(count(conn, "SELECT COUNT(*) FROM users"));
            data.setApprovedUsers(count(conn, "SELECT COUNT(*) FROM users WHERE status = 'APPROVED'"));
            data.setPendingUsers(count(conn, "SELECT COUNT(*) FROM users WHERE status = 'PENDING'"));
            data.setTotalBookings(count(conn, "SELECT COUNT(*) FROM bookings"));
            data.setTotalServices(count(conn, "SELECT COUNT(*) FROM services WHERE is_active = 1"));
            data.setDistinctCategories(count(conn, "SELECT COUNT(DISTINCT category) FROM services WHERE is_active = 1"));
            data.setPendingRequests(count(conn, "SELECT COUNT(*) FROM apply_requests WHERE status = 'PENDING'"));
            data.setTotalMessages(count(conn, "SELECT COUNT(*) FROM contact_messages"));
            data.setTotalRevenueDisplay(formatCurrency(queryMoney(conn,
                    """
                    SELECT COALESCE(SUM(s.price), 0)
                    FROM bookings b
                    JOIN services s ON s.service_id = b.service_id
                    """)));

            PeriodSnapshot monthlyCurrent = loadMonthlySnapshot(conn, YearMonth.now());
            PeriodSnapshot monthlyPrevious = loadMonthlySnapshot(conn, YearMonth.now().minusMonths(1));
            PeriodSnapshot yearlyCurrent = loadYearlySnapshot(conn, LocalDateTime.now().getYear());
            PeriodSnapshot yearlyPrevious = loadYearlySnapshot(conn, LocalDateTime.now().minusYears(1).getYear());

            data.setBookingTrendLabel(buildTrendLabel(monthlyCurrent.bookingCount, monthlyPrevious.bookingCount, "vs last month"));
            data.setBookingTrendDirection(direction(monthlyCurrent.bookingCount, monthlyPrevious.bookingCount));
            data.setUserTrendLabel(buildTrendLabel(monthlyCurrent.userCount, monthlyPrevious.userCount, "new users this month"));
            data.setUserTrendDirection(direction(monthlyCurrent.userCount, monthlyPrevious.userCount));
            data.setRevenueTrendLabel(buildTrendLabel(monthlyCurrent.revenue, monthlyPrevious.revenue, "vs last month"));
            data.setRevenueTrendDirection(direction(monthlyCurrent.revenue, monthlyPrevious.revenue));
            data.setRequestTrendLabel(buildTrendLabel(monthlyCurrent.pendingRequests, monthlyPrevious.pendingRequests, "pending requests"));
            data.setRequestTrendDirection(direction(monthlyCurrent.pendingRequests, monthlyPrevious.pendingRequests));
            data.setMessageTrendLabel(buildTrendLabel(monthlyCurrent.contactCount, monthlyPrevious.contactCount, "enquiries this month"));
            data.setMessageTrendDirection(direction(monthlyCurrent.contactCount, monthlyPrevious.contactCount));

            data.setMonthlyReport(buildReportSection("Monthly Report", "Compared with last month",
                    monthlyCurrent, monthlyPrevious));
            data.setYearlyReport(buildReportSection("Yearly Report", "Compared with last year",
                    yearlyCurrent, yearlyPrevious));

            loadTopServices(conn, data);
            loadRecentBookings(conn, data);
            loadRecentUsers(conn, data);
            loadRecentMessages(conn, data);
        } catch (Exception e) {
            ExceptionUtil.log("Failed to load admin dashboard data.", e);
        }

        return data;
    }

    private void ensureContactTableExists(Connection conn) throws Exception {
        try (Statement statement = conn.createStatement()) {
            statement.executeUpdate(CREATE_CONTACT_TABLE_SQL);
        }
    }

    private int count(Connection conn, String sql) throws Exception {
        try (PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    private BigDecimal queryMoney(Connection conn, String sql) throws Exception {
        try (PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                BigDecimal value = rs.getBigDecimal(1);
                return value != null ? value : BigDecimal.ZERO;
            }
        }
        return BigDecimal.ZERO;
    }

    private PeriodSnapshot loadMonthlySnapshot(Connection conn, YearMonth month) throws Exception {
        LocalDateTime start = month.atDay(1).atStartOfDay();
        LocalDateTime end = month.plusMonths(1).atDay(1).atStartOfDay();
        return loadSnapshot(conn, start, end);
    }

    private PeriodSnapshot loadYearlySnapshot(Connection conn, int year) throws Exception {
        LocalDateTime start = LocalDateTime.of(year, 1, 1, 0, 0);
        LocalDateTime end = LocalDateTime.of(year + 1, 1, 1, 0, 0);
        return loadSnapshot(conn, start, end);
    }

    private PeriodSnapshot loadSnapshot(Connection conn, LocalDateTime start, LocalDateTime end) throws Exception {
        PeriodSnapshot snapshot = new PeriodSnapshot();
        snapshot.userCount = queryCountInRange(conn,
                "SELECT COUNT(*) FROM users WHERE created_at >= ? AND created_at < ?",
                start, end);
        snapshot.bookingCount = queryCountInRange(conn,
                "SELECT COUNT(*) FROM bookings WHERE appointment_datetime >= ? AND appointment_datetime < ?",
                start, end);
        snapshot.contactCount = queryCountInRange(conn,
                "SELECT COUNT(*) FROM contact_messages WHERE created_at >= ? AND created_at < ?",
                start, end);
        snapshot.pendingRequests = queryCountInRange(conn,
                "SELECT COUNT(*) FROM apply_requests WHERE created_at >= ? AND created_at < ? AND status = 'PENDING'",
                start, end);
        snapshot.revenue = queryMoneyInRange(conn,
                """
                SELECT COALESCE(SUM(s.price), 0)
                FROM bookings b
                JOIN services s ON s.service_id = b.service_id
                WHERE b.appointment_datetime >= ? AND b.appointment_datetime < ?
                """,
                start, end);
        return snapshot;
    }

    private int queryCountInRange(Connection conn, String sql, LocalDateTime start, LocalDateTime end) throws Exception {
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setTimestamp(1, Timestamp.valueOf(start));
            ps.setTimestamp(2, Timestamp.valueOf(end));
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : 0;
            }
        }
    }

    private BigDecimal queryMoneyInRange(Connection conn, String sql, LocalDateTime start, LocalDateTime end)
            throws Exception {
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setTimestamp(1, Timestamp.valueOf(start));
            ps.setTimestamp(2, Timestamp.valueOf(end));
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    BigDecimal value = rs.getBigDecimal(1);
                    return value != null ? value : BigDecimal.ZERO;
                }
            }
        }
        return BigDecimal.ZERO;
    }

    private AdminReportSection buildReportSection(String title, String comparisonLabel,
            PeriodSnapshot current, PeriodSnapshot previous) {
        AdminReportSection section = new AdminReportSection();
        section.setTitle(title);
        section.setComparisonLabel(comparisonLabel);
        section.setDirection(direction(current.revenue, previous.revenue));
        section.setSummary(buildRevenueSummary(current.revenue, previous.revenue, comparisonLabel.toLowerCase()));

        section.getMetrics().add(metric("New users", current.userCount, previous.userCount));
        section.getMetrics().add(metric("Bookings", current.bookingCount, previous.bookingCount));
        section.getMetrics().add(metric("Estimated revenue", current.revenue, previous.revenue));
        section.getMetrics().add(metric("Enquiries", current.contactCount, previous.contactCount));
        section.getMetrics().add(metric("Pending requests", current.pendingRequests, previous.pendingRequests));
        return section;
    }

    private AdminReportMetric metric(String label, int current, int previous) {
        AdminReportMetric metric = new AdminReportMetric();
        metric.setLabel(label);
        metric.setCurrentValue(String.valueOf(current));
        metric.setPreviousValue(String.valueOf(previous));
        metric.setChangeLabel(changeLabel(current, previous));
        metric.setDirection(direction(current, previous));
        return metric;
    }

    private AdminReportMetric metric(String label, BigDecimal current, BigDecimal previous) {
        AdminReportMetric metric = new AdminReportMetric();
        metric.setLabel(label);
        metric.setCurrentValue(formatCurrency(current));
        metric.setPreviousValue(formatCurrency(previous));
        metric.setChangeLabel(changeLabel(current, previous));
        metric.setDirection(direction(current, previous));
        return metric;
    }

    private void loadTopServices(Connection conn, AdminDashboardData data) throws Exception {
        String sql = """
                SELECT s.service_name, s.category, s.stylist_name,
                       COUNT(b.booking_id) AS bookings_count,
                       COALESCE(SUM(s.price), 0) AS revenue_total
                FROM services s
                LEFT JOIN bookings b ON b.service_id = s.service_id
                WHERE s.is_active = 1
                GROUP BY s.service_id, s.service_name, s.category, s.stylist_name
                ORDER BY bookings_count DESC, revenue_total DESC, s.service_name
                LIMIT 6
                """;
        try (PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                AdminServiceSummary service = new AdminServiceSummary();
                service.setServiceName(rs.getString("service_name"));
                service.setCategory(rs.getString("category"));
                service.setStylistName(rs.getString("stylist_name"));
                service.setBookingsCount(rs.getInt("bookings_count"));
                service.setRevenueDisplay(formatCurrency(rs.getBigDecimal("revenue_total")));
                data.getTopServices().add(service);
            }
        }
    }

    private void loadRecentBookings(Connection conn, AdminDashboardData data) throws Exception {
        String sql = """
                SELECT u.full_name, s.service_name, b.appointment_datetime, b.status, s.price
                FROM bookings b
                JOIN users u ON u.user_id = b.user_id
                JOIN services s ON s.service_id = b.service_id
                ORDER BY b.appointment_datetime DESC
                LIMIT 8
                """;
        try (PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                AdminBookingSummary booking = new AdminBookingSummary();
                booking.setCustomerName(rs.getString("full_name"));
                booking.setServiceName(rs.getString("service_name"));
                Timestamp timestamp = rs.getTimestamp("appointment_datetime");
                booking.setAppointmentDisplay(timestamp != null
                        ? TIMESTAMP_FORMAT.format(timestamp.toLocalDateTime())
                        : "Not scheduled");
                booking.setStatus(rs.getString("status"));
                booking.setAmountDisplay(formatCurrency(rs.getBigDecimal("price")));
                data.getRecentBookings().add(booking);
            }
        }
    }

    private void loadRecentUsers(Connection conn, AdminDashboardData data) throws Exception {
        String sql = """
                SELECT full_name, email, phone, status, membership_level, created_at
                FROM users
                ORDER BY created_at DESC
                LIMIT 8
                """;
        try (PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                AdminUserSummary user = new AdminUserSummary();
                user.setName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setStatus(rs.getString("status"));
                user.setMembershipLevel(rs.getString("membership_level"));
                Timestamp created = rs.getTimestamp("created_at");
                user.setJoinedDisplay(created != null ? DATE_FORMAT.format(created.toLocalDateTime()) : "Unknown");
                data.getRecentUsers().add(user);
            }
        }
    }

    private void loadRecentMessages(Connection conn, AdminDashboardData data) throws Exception {
        String sql = """
                SELECT message_id, full_name, email, phone, message, created_at
                FROM contact_messages
                ORDER BY created_at DESC
                LIMIT 6
                """;
        try (PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ContactMessage message = new ContactMessage();
                message.setMessageId(rs.getInt("message_id"));
                message.setFullName(rs.getString("full_name"));
                message.setEmail(rs.getString("email"));
                message.setPhone(rs.getString("phone"));
                message.setMessage(rs.getString("message"));
                Timestamp created = rs.getTimestamp("created_at");
                if (created != null) {
                    message.setCreatedAt(created.toLocalDateTime());
                    message.setCreatedAtDisplay(TIMESTAMP_FORMAT.format(created.toLocalDateTime()));
                }
                data.getRecentMessages().add(message);
            }
        }
    }

    private String buildTrendLabel(int current, int previous, String suffix) {
        return changeLabel(current, previous) + " " + suffix;
    }

    private String buildTrendLabel(BigDecimal current, BigDecimal previous, String suffix) {
        return changeLabel(current, previous) + " " + suffix;
    }

    private String buildRevenueSummary(BigDecimal current, BigDecimal previous, String comparison) {
        String dir = direction(current, previous);
        if ("up".equals(dir)) {
            return "Revenue increased " + changeLabel(current, previous).toLowerCase() + " " + comparison + ".";
        }
        if ("down".equals(dir)) {
            return "Revenue declined " + changeLabel(current, previous).toLowerCase() + " " + comparison + ".";
        }
        return "Revenue held steady " + comparison + ".";
    }

    private String changeLabel(int current, int previous) {
        return percentLabel(BigDecimal.valueOf(current), BigDecimal.valueOf(previous));
    }

    private String changeLabel(BigDecimal current, BigDecimal previous) {
        return percentLabel(current, previous);
    }

    private String percentLabel(BigDecimal current, BigDecimal previous) {
        if (previous.compareTo(BigDecimal.ZERO) == 0) {
            if (current.compareTo(BigDecimal.ZERO) == 0) {
                return "0.0%";
            }
            return "100.0%";
        }
        BigDecimal change = current.subtract(previous)
                .multiply(BigDecimal.valueOf(100))
                .divide(previous.abs(), 1, RoundingMode.HALF_UP);
        return PERCENT_FORMAT.format(change.abs()) + "%";
    }

    private String direction(int current, int previous) {
        return Integer.compare(current, previous) > 0 ? "up"
                : Integer.compare(current, previous) < 0 ? "down" : "neutral";
    }

    private String direction(BigDecimal current, BigDecimal previous) {
        int comparison = current.compareTo(previous);
        return comparison > 0 ? "up" : comparison < 0 ? "down" : "neutral";
    }

    private String formatCurrency(BigDecimal amount) {
        BigDecimal safe = amount != null ? amount : BigDecimal.ZERO;
        return "NPR " + MONEY_FORMAT.format(safe.setScale(2, RoundingMode.HALF_UP));
    }

    private static final class PeriodSnapshot {
        private int userCount;
        private int bookingCount;
        private int contactCount;
        private int pendingRequests;
        private BigDecimal revenue = BigDecimal.ZERO;
    }
}
