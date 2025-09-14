package com.ecommerce.servlet;

import com.ecommerce.dao.CartDAO;
import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.CartItem;
import com.ecommerce.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private CartDAO cartDAO = new CartDAO();
    private ProductDAO productDAO = new ProductDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login");
            return;
        }
        
        int userId = (Integer) session.getAttribute("userId");
        List<CartItem> cartItems = cartDAO.getCartItems(userId);
        
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : cartItems) {
            total = total.add(item.getSubtotal());
        }
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", total);
        request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login");
            return;
        }
        
        int userId = (Integer) session.getAttribute("userId");
        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            handleAddToCart(request, response, userId);
        } else if ("update".equals(action)) {
            handleUpdateCart(request, response, userId);
        } else if ("remove".equals(action)) {
            handleRemoveFromCart(request, response, userId);
        } else {
            response.sendRedirect("cart");
        }
    }
    
    private void handleAddToCart(HttpServletRequest request, HttpServletResponse response, int userId) 
            throws IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            if (quantity <= 0) {
                quantity = 1;
            }
            
            // Check if product exists and has enough stock
            Product product = productDAO.getProductById(productId);
            if (product == null) {
                response.sendRedirect("products?error=Product not found");
                return;
            }
            
            if (product.getStockQuantity() < quantity) {
                response.sendRedirect("products?error=Not enough stock available");
                return;
            }
            
            if (cartDAO.addToCart(userId, productId, quantity)) {
                response.sendRedirect("cart?success=Item added to cart");
            } else {
                response.sendRedirect("products?error=Failed to add item to cart");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("products?error=Invalid product or quantity");
        }
    }
    
    private void handleUpdateCart(HttpServletRequest request, HttpServletResponse response, int userId) 
            throws IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            if (cartDAO.updateCartItem(userId, productId, quantity)) {
                response.sendRedirect("cart?success=Cart updated");
            } else {
                response.sendRedirect("cart?error=Failed to update cart");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("cart?error=Invalid product or quantity");
        }
    }
    
    private void handleRemoveFromCart(HttpServletRequest request, HttpServletResponse response, int userId) 
            throws IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            
            if (cartDAO.removeFromCart(userId, productId)) {
                response.sendRedirect("cart?success=Item removed from cart");
            } else {
                response.sendRedirect("cart?error=Failed to remove item");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("cart?error=Invalid product");
        }
    }
}