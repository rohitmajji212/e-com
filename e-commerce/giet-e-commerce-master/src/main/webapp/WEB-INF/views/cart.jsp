<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - E-Commerce</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <main class="main-content">
        <div class="container">
            <h1>Shopping Cart</h1>
            
            <c:if test="${not empty param.error}">
                <div class="alert alert-error">
                    ${param.error}
                </div>
            </c:if>
            
            <c:if test="${not empty param.success}">
                <div class="alert alert-success">
                    ${param.success}
                </div>
            </c:if>
            
            <c:choose>
                <c:when test="${not empty cartItems}">
                    <div class="cart-content">
                        <div class="cart-items">
                            <c:forEach var="item" items="${cartItems}">
                                <div class="cart-item">
                                    <div class="item-image">
                                        <img src="${item.imageUrl}" alt="${item.productName}" onerror="this.src='${pageContext.request.contextPath}/images/no-image.jpg'">
                                    </div>
                                    
                                    <div class="item-details">
                                        <h3 class="item-name">${item.productName}</h3>
                                        <div class="item-price">
                                            <fmt:formatNumber value="${item.price}" type="currency"/>
                                        </div>
                                    </div>
                                    
                                    <div class="item-quantity">
                                        <form action="${pageContext.request.contextPath}/cart" method="post" class="quantity-form">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="productId" value="${item.productId}">
                                            <label for="quantity-${item.productId}">Quantity:</label>
                                            <div class="quantity-controls">
                                                <input type="number" id="quantity-${item.productId}" name="quantity" 
                                                       value="${item.quantity}" min="1" max="99" class="quantity-input">
                                                <button type="submit" class="btn btn-sm btn-secondary">Update</button>
                                            </div>
                                        </form>
                                    </div>
                                    
                                    <div class="item-subtotal">
                                        <fmt:formatNumber value="${item.subtotal}" type="currency"/>
                                    </div>
                                    
                                    <div class="item-actions">
                                        <form action="${pageContext.request.contextPath}/cart" method="post">
                                            <input type="hidden" name="action" value="remove">
                                            <input type="hidden" name="productId" value="${item.productId}">
                                            <button type="submit" class="btn btn-sm btn-danger" 
                                                    onclick="return confirm('Are you sure you want to remove this item?')">
                                                Remove
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <div class="cart-summary">
                            <div class="summary-card">
                                <h3>Order Summary</h3>
                                <div class="summary-row">
                                    <span>Subtotal:</span>
                                    <span><fmt:formatNumber value="${cartTotal}" type="currency"/></span>
                                </div>
                                <div class="summary-row">
                                    <span>Shipping:</span>
                                    <span>FREE</span>
                                </div>
                                <div class="summary-row summary-total">
                                    <span>Total:</span>
                                    <span><fmt:formatNumber value="${cartTotal}" type="currency"/></span>
                                </div>
                                
                                <div class="checkout-actions">
                                    <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary btn-full">
                                        Proceed to Checkout
                                    </a>
                                    <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary btn-full">
                                        Continue Shopping
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-cart">
                        <h2>Your cart is empty</h2>
                        <p>Add some products to your cart to get started.</p>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">
                            Shop Now
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
    
    <jsp:include page="footer.jsp" />
</body>
</html>