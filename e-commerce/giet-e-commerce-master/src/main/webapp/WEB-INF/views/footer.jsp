<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="footer">
    <div class="footer-container">
        <div class="footer-section">
            <h3>E-Commerce Store</h3>
            <p>Your one-stop shop for quality products at great prices.</p>
        </div>
        
        <div class="footer-section">
            <h4>Quick Links</h4>
            <ul class="footer-links">
                <li><a href="${pageContext.request.contextPath}/products">Products</a></li>
                <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
            </ul>
        </div>
        
        <div class="footer-section">
            <h4>Customer Service</h4>
            <ul class="footer-links">
                <li><a href="${pageContext.request.contextPath}/help">Help Center</a></li>
                <li><a href="${pageContext.request.contextPath}/shipping">Shipping Info</a></li>
                <li><a href="${pageContext.request.contextPath}/returns">Returns</a></li>
            </ul>
        </div>
        
        <div class="footer-section">
            <h4>Account</h4>
            <ul class="footer-links">
                <li><a href="${pageContext.request.contextPath}/login">Login</a></li>
                <li><a href="${pageContext.request.contextPath}/register">Register</a></li>
                <li><a href="${pageContext.request.contextPath}/orders">My Orders</a></li>
            </ul>
        </div>
    </div>
    
    <div class="footer-bottom">
        <div class="footer-container">
            <p>&copy; 2024 E-Commerce Store. All rights reserved.</p>
        </div>
    </div>
</footer>