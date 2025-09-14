<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products - E-Commerce</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <main class="main-content">
        <div class="container">
            <div class="products-header">
                <h1>
                    <c:choose>
                        <c:when test="${not empty searchKeyword}">
                            Search Results for "${searchKeyword}"
                        </c:when>
                        <c:when test="${not empty selectedCategory}">
                            Category Products
                        </c:when>
                        <c:otherwise>
                            All Products
                        </c:otherwise>
                    </c:choose>
                </h1>
                
                <div class="products-filters">
                    <form action="${pageContext.request.contextPath}/products" method="get" class="search-form">
                        <input type="text" name="search" placeholder="Search products..." value="${searchKeyword}">
                        <button type="submit" class="btn btn-primary">Search</button>
                    </form>
                    
                    <div class="category-filters">
                        <a href="${pageContext.request.contextPath}/products" 
                           class="filter-link ${empty selectedCategory ? 'active' : ''}">All</a>
                        <a href="${pageContext.request.contextPath}/products?category=1" 
                           class="filter-link ${selectedCategory == 1 ? 'active' : ''}">Electronics</a>
                        <a href="${pageContext.request.contextPath}/products?category=2" 
                           class="filter-link ${selectedCategory == 2 ? 'active' : ''}">Clothing</a>
                        <a href="${pageContext.request.contextPath}/products?category=3" 
                           class="filter-link ${selectedCategory == 3 ? 'active' : ''}">Books</a>
                        <a href="${pageContext.request.contextPath}/products?category=4" 
                           class="filter-link ${selectedCategory == 4 ? 'active' : ''}">Home & Garden</a>
                        <a href="${pageContext.request.contextPath}/products?category=5" 
                           class="filter-link ${selectedCategory == 5 ? 'active' : ''}">Sports</a>
                    </div>
                </div>
            </div>
            
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
            
            <div class="products-grid">
                <c:forEach var="product" items="${products}">
                    <div class="product-card">
                        <div class="product-image">
                            <img src="${product.imageUrl}" alt="${product.productName}" onerror="this.src='${pageContext.request.contextPath}/images/no-image.jpg'">
                            <c:if test="${product.stockQuantity <= 0}">
                                <div class="out-of-stock-overlay">Out of Stock</div>
                            </c:if>
                        </div>
                        
                        <div class="product-info">
                            <h3 class="product-name">${product.productName}</h3>
                            <p class="product-description">${product.description}</p>
                            <div class="product-price">
                                <fmt:formatNumber value="${product.price}" type="currency"/>
                            </div>
                            <div class="product-category">${product.categoryName}</div>
                            <div class="product-stock">
                                <c:choose>
                                    <c:when test="${product.stockQuantity > 0}">
                                        Stock: ${product.stockQuantity} available
                                    </c:when>
                                    <c:otherwise>
                                        <span class="out-of-stock">Out of Stock</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <div class="product-actions">
                            <c:if test="${product.stockQuantity > 0}">
                                <form action="${pageContext.request.contextPath}/cart" method="post" class="add-to-cart-form">
                                    <input type="hidden" name="action" value="add">
                                    <input type="hidden" name="productId" value="${product.productId}">
                                    <div class="quantity-selector">
                                        <label for="quantity-${product.productId}">Qty:</label>
                                        <input type="number" id="quantity-${product.productId}" name="quantity" 
                                               value="1" min="1" max="${product.stockQuantity}" class="quantity-input">
                                    </div>
                                    <button type="submit" class="btn btn-primary">Add to Cart</button>
                                </form>
                            </c:else>
                                <button class="btn btn-disabled" disabled>Out of Stock</button>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
            <c:if test="${empty products}">
                <div class="no-products">
                    <h3>No products found</h3>
                    <p>
                        <c:choose>
                            <c:when test="${not empty searchKeyword}">
                                Try searching with different keywords or <a href="${pageContext.request.contextPath}/products">browse all products</a>.
                            </c:when>
                            <c:otherwise>
                                Check back later for new arrivals!
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
            </c:if>
        </div>
    </main>
    
    <jsp:include page="footer.jsp" />
</body>
</html>