package com.example.blog.repository;

import com.example.blog.entity.Blog;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;

public interface BlogRepository extends JpaRepository<Blog, Long> {
    Page<Blog> findByTitleContaining(String title, Pageable pageable);

}
