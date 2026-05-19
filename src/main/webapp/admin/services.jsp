<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Services | Shringar Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-dashboard.css?v=20260425-1">
</head>
<body class="admin-body">
    <div class="admin-shell">
        <%@ include file="/WEB-INF/fragments/admin-sidebar.jspf" %>

        <main class="admin-main">
            <header class="hero-panel">
                <div>
                    <p class="section-label">Service Catalogue</p>
                    <h2>Manage Salon Services</h2>
                    <p class="hero-copy">Create, update, and deactivate hair, makeup, and nail services that appear across booking and search pages.</p>
                </div>
                <div class="hero-actions">
                    <a class="secondary-link-button" href="${pageContext.request.contextPath}/admin/services">New service</a>
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
                        <p class="section-label">${editingService ? 'Edit Service' : 'Add Service'}</p>
                        <h3>${editingService ? 'Update service details' : 'Create a new service'}</h3>
                    </div>
                    <span class="panel-note">Service code must be unique, for example HAIR-CUT-01.</span>
                </div>

                <form class="admin-form" method="post" action="${pageContext.request.contextPath}/admin/services" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="${editingService ? 'update' : 'create'}">
                    <c:if test="${editingService}">
                        <input type="hidden" name="serviceId" value="${formService.serviceId}">
                    </c:if>

                    <div class="admin-form-grid">
                        <label class="field">
                            <span>Service name</span>
                            <input type="text" name="serviceName" value="${formService.serviceName}" required>
                        </label>
                        <label class="field">
                            <span>Category</span>
                            <input type="text" name="category" value="${formService.category}" placeholder="Hair, Makeup, Nail" required>
                        </label>
                        <label class="field">
                            <span>Stylist name</span>
                            <input type="text" name="stylistName" value="${formService.stylistName}" required>
                        </label>
                        <label class="field">
                            <span>Service code</span>
                            <input type="text" name="serviceCode" value="${formService.serviceCode}" required>
                        </label>
                        <label class="field">
                            <span>Price</span>
                            <input type="number" name="price" value="${formService.price}" min="0" step="0.01" required>
                        </label>
                        <label class="field">
                            <span>Duration in minutes</span>
                            <input type="number" name="durationMinutes" value="${formService.durationMinutes}" min="1" required>
                        </label>
                        <label class="field field-full">
                            <span>Service Image</span>
                            <c:if test="${not empty formService.imagePath}">
                                <div style="margin-bottom: 10px;">
                                    <img src="${pageContext.request.contextPath}${formService.imagePath}" alt="Service Image" style="max-height: 100px; border-radius: 8px;">
                                </div>
                            </c:if>
                            <input type="file" name="serviceImage" accept="image/*">
                        </label>
                        <label class="field field-full">
                            <span>Description</span>
                            <textarea name="description" rows="4"><c:out value="${formService.description}"/></textarea>
                        </label>
                        <label class="checkbox-field field-full">
                            <input type="checkbox" name="isActive" value="1" ${empty formService || formService.active ? 'checked' : ''}>
                            <span>Keep this service active for customers</span>
                        </label>
                    </div>

                    <div class="form-actions">
                        <button class="admin-button" type="submit">${editingService ? 'Update service' : 'Create service'}</button>
                        <a class="secondary-link-button" href="${pageContext.request.contextPath}/admin/services">Clear form</a>
                    </div>
                </form>
            </section>

            <section class="panel">
                <div class="panel-head">
                    <div>
                        <p class="section-label">All Services</p>
                        <h3>Catalogue Records</h3>
                    </div>
                    <span class="panel-note">Deactivate instead of deleting, so old bookings stay connected.</span>
                </div>

                <div class="admin-table-wrap">
                    <table class="data-table admin-data-table">
                        <thead>
                            <tr>
                                <th>Service</th>
                                <th>Category</th>
                                <th>Stylist</th>
                                <th>Code</th>
                                <th>Price</th>
                                <th>Duration</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty services}">
                                    <c:forEach var="service" items="${services}">
                                        <tr>
                                            <td>
                                                <div style="display: flex; align-items: center; gap: 12px;">
                                                    <c:if test="${not empty service.imagePath}">
                                                        <img src="${pageContext.request.contextPath}${service.imagePath}" alt="Img" style="width: 40px; height: 40px; border-radius: 4px; object-fit: cover;">
                                                    </c:if>
                                                    <div>
                                                        <strong><c:out value="${service.serviceName}"/></strong>
                                                        <span class="muted-line"><c:out value="${service.description}"/></span>
                                                    </div>
                                                </div>
                                            </td>
                                            <td><c:out value="${service.category}"/></td>
                                            <td><c:out value="${service.stylistName}"/></td>
                                            <td><c:out value="${service.serviceCode}"/></td>
                                            <td>Rs <c:out value="${service.price}"/></td>
                                            <td><c:out value="${service.durationMinutes}"/> min</td>
                                            <td>
                                                <span class="status-tag ${service.active ? 'APPROVED' : 'REJECTED'}">
                                                    ${service.active ? 'ACTIVE' : 'INACTIVE'}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="table-actions">
                                                    <a class="admin-button compact secondary" href="${pageContext.request.contextPath}/admin/services?editId=${service.serviceId}">Edit</a>
                                                    <form class="inline-form" method="post" action="${pageContext.request.contextPath}/admin/services">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="serviceId" value="${service.serviceId}">
                                                        <button class="admin-button compact danger" type="submit">Delete</button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="8">No services are available yet.</td>
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