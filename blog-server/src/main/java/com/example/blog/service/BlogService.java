package com.example.blog.service;

import com.example.blog.entity.Blog;
import com.example.blog.entity.User;
import com.example.blog.repository.BlogRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class BlogService {
    
    @Autowired
    private BlogRepository blogRepository;
    
    @Autowired
    private UserService userService;
    
    public Page<Blog> getBlogs(String search, Pageable pageable) {
        try {
            if (search != null && !search.isEmpty()) {
                return blogRepository.findByTitleContaining(search, pageable);
            }
            return blogRepository.findAll(pageable);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("获取博客列表失败");
        }
    }
    
    public Blog getBlog(Long id) {
        return blogRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("博客不存在"));
    }
    
    public Blog createBlog(Blog blog, String token) {
        // 获取当前用户并设置为博客作者
        User user = userService.getProfile(token.substring(7));
        blog.setUser(user);
        return blogRepository.save(blog);
    }
    
    public Blog updateBlog(Long id, Blog blog) {
        Blog existingBlog = getBlog(id);
        existingBlog.setTitle(blog.getTitle());
        existingBlog.setContent(blog.getContent());
        return blogRepository.save(existingBlog);
    }
    
    public void deleteBlog(Long id) {
        blogRepository.deleteById(id);
    }
}
