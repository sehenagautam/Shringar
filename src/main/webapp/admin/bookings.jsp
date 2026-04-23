<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Bookings | Shringar Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-dashboard.css?v=20260423-admin">
</head>
<body class="admin-body">
    <div class="admin-shell">
        <%@ include file="/WEB-INF/fragments/admin-sidebar.jspf" %>

        <main class="admin-main">
            <header class="hero-panel">
                <div>
                    <p class="section-label">Appointment Flow</p>
                    <h2>Manage Bookings</h2>
                    <p class="hero-copy">Create appointments for approved users, update timing and status, or remove incorrect booking entries.</p>
                </div>
                <div class="hero-actions">
                    <a class="secondary-link-button" href="${pageContext.request.contextPath}/admin/bookings">New booking</a>
                </div>
            </header>

            <c:if test="${not empty successMessage}">
                <div class="admin-feedback admin-feedback-success"><c:out value="${successMessage}"/></div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="admin-feedback admin-feedback-error"><c:out value="${errorMessage}"/></div>
            </c:if>
            <c:if test="${not empty errors}">
                <div class="admin-feedback admin-feedback-error">
                    <c:forEach var="error" items="${errors}">
                        <p><c:out value="${error}"/></p>
                    </c:forEach>
                </div>
            </c:if>

            <section class="panel form-panel">
                <div class="panel-head">
                    <div>
                        <p class="section-label">${editingBooking ? 'Edit Booking' : 'Create Booking'}</p>
                        <h3>${editingBooking ? 'Update appointment' : 'Add appointment'}</h3>
                    </div>
                    <span class="panel-note">Only approved users and active services are shown.</span>
                </div>

                <form class="admin-form" method="post" action="${pageContext.request.contextPath}/admin/bookings">
                    <input type="hidden" name="action" value="${editingBooking ? 'update' : 'create'}">
                    <c:if test="${editingBooking}">
                        <input type="hidden" name="bookingId" value="${bookingForm.bookingId}">
                    </c:if>

                    <div class="admin-form-grid">
                        <label class="field">
                            <span>Customer</span>
                            <select name="userId" required>
                                <option value="">Choose customer</option>
                                <c:forEach var="customer" items="${userOptions}">
                                    <option value="${customer.userId}" ${bookingForm.userId eq customer.userId ? 'selected' : ''}>
                                        <c:out value="${customer.name}"/> - <c:out value="${customer.email}"/>
                                    </option>
                                </c:forEach>
                            </select>
                        </label>
                        <label class="field">
                            <span>Service</span>
                            <select name="serviceId" required>
                                <option value="">Choose service</option>
                                <c:forEach var="service" items="${serviceOptions}">
                                    <option value="${service.serviceId}" ${bookingForm.serviceId eq service.serviceId ? 'selected' : ''}>
                                        <c:out value="${service.serviceName}"/> - Rs <c:out value="${service.price}"/>
                                    </option>
                                </c:forEach>
                            </select>
                        </label>
                        <label class="field">
                            <span>Appointment date and time</span>
                            <input type="datetime-local" name="appointmentDatetime" value="${bookingForm.appointmentValue}" required>
                        </label>
                        <label class="field">
                            <span>Status</span>
                            <select name="status" required>
                                <option value="PENDING" ${bookingForm.status eq 'PENDING' ? 'selected' : ''}>Pending</option>
                                <option value="CONFIRMED" ${bookingForm.status eq 'CONFIRMED' ? 'selected' : ''}>Confirmed</option>
                                <option value="COMPLETED" ${bookingForm.status eq 'COMPLETED' ? 'selected' : ''}>Completed</option>
                                <option value="CANCELLED" ${bookingForm.status eq 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                            </select>
                        </label>
                        <label class="field field-full">
                            <span>Notes</span>
                            <textarea name="notes" rows="3" maxlength="255"><c:out value="${bookingForm.notes}"/></textarea>
                        </label>
                    </div>

                    <div class="form-actions">
                        <button class="admin-button" type="submit">${editingBooking ? 'Update booking' : 'Create booking'}</button>
                        <a class="secondary-link-button" href="${pageContext.request.contextPath}/admin/bookings">Clear form</a>
                    </div>
                </form>
            </section>

            <section class="panel">
                <div class="panel-head">
                    <div>
                        <p class="section-label">Booking Records</p>
                        <h3>Appointments</h3>
                    </div>
                    <span class="panel-note">Bookings connect approved users with active salon services.</span>
                </div>

                <div class="admin-table-wrap">
                    <table class="data-table admin-data-table">
                        <thead>
                            <tr>
                                <th>Customer</th>
                                <th>Service</th>
                                <th>Appointment</th>
                                <th>Status</th>
                                <th>Amount</th>
                                <th>Notes</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty bookings}">
                                    <c:forEach var="booking" items="${bookings}">
                                        <tr>
                                            <td>
                                                <strong><c:out value="${booking.customerName}"/></strong>
                                                <span class="muted-line"><c:out value="${booking.customerEmail}"/></span>
                                            </td>
                                            <td><c:out value="${booking.serviceName}"/></td>
                                            <td><c:out value="${booking.appointmentDisplay}"/></td>
                                            <td><span class="status-tag ${booking.status}"><c:out value="${booking.status}"/></span></td>
                                            <td>Rs <c:out value="${booking.price}"/></td>
                                            <td><c:out value="${empty booking.notes ? 'No notes' : booking.notes}"/></td>
                                            <td>
                                                <div class="table-actions">
                                                    <a class="admin-button compact secondary" href="${pageContext.request.contextPath}/admin/bookings?editId=${booking.bookingId}">Edit</a>
                                                    <form class="inline-form" method="post" action="${pageContext.request.contextPath}/admin/bookings">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="bookingId" value="${booking.bookingId}">
                                                        <button class="admin-button compact danger" type="submit">Delete</button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7">No bookings have been recorded yet.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </div>
</body>
</html>
