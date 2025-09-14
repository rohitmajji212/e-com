<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header class="header">
    <nav class="navbar">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/products" class="nav-brand">
                E-Commerce Store
            </a>
            
            <div class="nav-menu">
                <a href="${pageContext.request.contextPath}/products" class="nav-link">Products</a>
                
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/cart" class="nav-link">
                            Cart
                            <span class="cart-count" id="cartCount"></span>
                        </a>
                        
                        <div class="nav-dropdown">
                            <a href="#" class="nav-link dropdown-toggle">
                                ${sessionScope.user.firstName} ${sessionScope.user.lastName}
                            </a>
                            <div class="dropdown-menu">
                                <a href="${pageContext.request.contextPath}/profile" class="dropdown-item">Profile</a>
                                <a href="${pageContext.request.contextPath}/orders" class="dropdown-item">Orders</a>
                                <c:if test="${sessionScope.userType == 'admin'}">
                                    <div class="dropdown-divider"></div>
                                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="dropdown-item">Admin Panel</a>
                                </c:if>
                                <div class="dropdown-divider"></div>
                                <a href="${pageContext.request.contextPath}/logout" class="dropdown-item">Logout</a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="nav-link">Login</a>
                        <a href="${pageContext.request.contextPath}/register" class="nav-link">Register</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </nav>
</header>