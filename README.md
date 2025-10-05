# 博客管理系统设计文档

## 1. 系统概述

### 1.1 项目背景

该项目是一个基于 Spring Boot + Vue.js 的个人博客管理系统，旨在为用户提供一个简单高效的博客创作和管理平台。

### 1.2 系统架构

- 前端：Vue.js 2.x + Element UI
- 后端：Spring Boot 2.7.0
- 数据库：MySQL 8.0
- 认证方案：JWT

## 2. 功能模块设计

### 2.1 用户模块

1. 登录/注册

  \- 用户名密码登录

  \- 新用户注册

  \- JWT token认证

2. 个人信息管理

  \- 个人资料查看/修改

  \- 密码修改

  \- 邮箱设置

### 2.2 博客管理模块

1. 博客列表

  \- 分页展示

  \- 搜索功能

  \- 排序功能

2. 博客编辑

  \- 创建新博客

  \- 编辑已有博客

  \- 删除博客


## 3. 数据库设计

### 3.1 用户表(users)

CREATE TABLE users (

  id BIGINT PRIMARY KEY AUTO_INCREMENT,

  username VARCHAR(50) NOT NULL UNIQUE,

  password VARCHAR(100) NOT NULL,

  email VARCHAR(100),

  create_time DATETIME NOT NULL

);

### 3.2 博客表(blogs)

CREATE TABLE blogs (

  id BIGINT PRIMARY KEY AUTO_INCREMENT,

  title VARCHAR(200) NOT NULL,

  content TEXT NOT NULL,

  user_id BIGINT NOT NULL,

  create_time DATETIME NOT NULL,

  update_time DATETIME NOT NULL

);

## 4. 接口设计

### 4.1 用户相关接口

1. POST /api/users/login

  \- 请求：{username, password}

  \- 响应：{token, user}

2. POST /api/users/register

  \- 请求：{username, password, email}

  \- 响应：{success, message}

3. GET /api/users/profile

  \- 请求头：Authorization

  \- 响应：{user}

### 4.2 博客相关接口

1. GET /api/blogs

  \- 参数：page, size, search

  \- 响应：{content, totalElements}

2. POST /api/blogs

  \- 请求：{title, content}

  \- 响应：{blog}

3. PUT /api/blogs/{id}

  \- 请求：{title, content}

  \- 响应：{blog}

## 5. 安全设计

### 5.1 认证机制

@Component

public class JwtInterceptor implements HandlerInterceptor {

  @Override

  public boolean preHandle(request, response, handler) {

​    // Token验证逻辑

  }

}

### 5.2 数据安全

1. 密码加密存储
2. SQL注入防护

## 6. 性能优化

### 6.1 前端优化

1. 路由懒加载
2. 组件按需加载
3. 图片资源优化
4. 本地数据缓存

### 6.2 后端优化

1. 数据库索引优化
2. 接口响应缓存
3. 分页查询优化
4. 连接池配置

## 7. 部署方案

### 7.1 开发环境

\- Node.js >= 12.0.0

\- JDK >= 17

\- MySQL >= 8.0

\- Maven >= 3.6

### 7.2 部署步骤

1. 前端部署

  \- npm install

  \- npm run build

  \- 部署dist目录

2. 后端部署

  \- mvn clean package

  \- java -jar target/blog-server.jar

## 8. 项目目录结构

### 8.1 前端结构

src/

 ├── components/   # 通用组件

 ├── views/     # 页面组件

 ├── router/    # 路由配置

 ├── store/     # Vuex状态管理

 ├── utils/     # 工具函数

 └── App.vue    # 根组件

### 8.2 后端结构

src/main/java/

 └── com/example/blog/

   ├── config/  # 配置类

   ├── controller/# 控制器

   ├── entity/  # 实体类

   ├── repository/# 数据访问

   ├── service/  # 业务逻辑

   └── exception/ # 异常处理
### 9
贡献者：蔡奕成

本文档详细说明了项目的主要设计内容，包括功能模块、数据库设计、接口设计等关键部分，可作为开发和维护的重要参考。
