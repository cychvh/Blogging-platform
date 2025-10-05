package com.example.blog.service;

import com.example.blog.config.JwtConfig;
import com.example.blog.entity.User;
import com.example.blog.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class UserService {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private JwtConfig jwtConfig;
    
    public ResponseEntity<?> login(User user) {
        User existingUser = userRepository.findByUsername(user.getUsername())
                .orElseThrow(() -> new RuntimeException("用户不存在"));
                
        if (!user.getPassword().equals(existingUser.getPassword())) {
            throw new RuntimeException("密码错误");
        }
        
        String token = jwtConfig.generateToken(user.getUsername());
        Map<String, Object> response = new HashMap<>();
        response.put("token", token);
        response.put("user", existingUser);
        
        return ResponseEntity.ok(response);
    }
    
    public ResponseEntity<?> register(User user) {
        if (userRepository.existsByUsername(user.getUsername())) {
            throw new RuntimeException("用户名已存在");
        }
        
        User savedUser = userRepository.save(user);
        return ResponseEntity.ok(savedUser);
    }
    
    public ResponseEntity<?> updateUser(Long id, User user) {
        User existingUser = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("用户不存在"));
                
        existingUser.setEmail(user.getEmail());
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            existingUser.setPassword(user.getPassword());
        }
        
        User updatedUser = userRepository.save(existingUser);
        return ResponseEntity.ok(updatedUser);
    }
    
    public User getProfile(String token) {
        String username = jwtConfig.getUsernameFromToken(token);
        return userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("用户不存在"));
    }
    
    public User updateProfile(String token, User updateUser) {
        String username = jwtConfig.getUsernameFromToken(token);
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("用户不存在"));
        
        if (updateUser.getEmail() != null) {
            user.setEmail(updateUser.getEmail());
        }
        if (updateUser.getPassword() != null && !updateUser.getPassword().isEmpty()) {
            user.setPassword(updateUser.getPassword());
        }
        
        return userRepository.save(user);
    }
}
