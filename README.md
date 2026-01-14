# 🎮 Game Forum (JSP 版)

> 2023 级 计算机科学与技术专业《JavaWeb 企业级开发》课程设计

![Java](https://img.shields.io/badge/Java-8-orange) ![Servlet](https://img.shields.io/badge/Servlet-4.0-blue) ![JSP](https://img.shields.io/badge/JSP-2.2-green) ![MySQL](https://img.shields.io/badge/MySQL-8.0-blue) ![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3-purple)

## 📖 项目简介

**Game Forum** 是一个基于原生 Java Servlet 和 JSP 技术开发的轻量级游戏玩家交流社区。

本项目采用了标准的 MVC 分层架构（Model-View-Controller），旨在实现一个功能完备的 Web 应用。前端采用了现代化的深色模式（Dark Mode）设计，集成了 Markdown 编辑器，提供了舒适的阅读和写作体验。

## 🛠️ 技术栈

### 后端 (Backend)

- **核心框架**: Java Servlet, JSP, JSTL
- **数据库**: MySQL 8.0
- **数据库连接**: JDBC (原生封装 DBUtil)
- **构建工具**: Apache Maven
- **服务器**: Apache Tomcat 9.0+

### 前端 (Frontend)

- **UI 框架**: Bootstrap 5.3 (定制化深色主题)
- **样式库**: FontAwesome 6.0 (图标)
- **编辑器**: SimpleMDE (支持 Markdown 实时预览)
- **渲染引擎**: Marked.js (Markdown 转 HTML)
- **交互**: 原生 JavaScript (Fetch API 实现异步点赞、评论)

## ✨ 功能特性

### 👤 普通用户

- **账户系统**：注册、登录、注销、个人中心（查看历史发帖）。
- **内容浏览**：按板块（动作、RPG、策略、休闲）分类浏览帖子，支持分页显示。
- **全站搜索**：支持按标题模糊搜索相关帖子。
- **帖子发布**：集成 Markdown 编辑器，支持富文本排版。
- **互动功能**：
  - 帖子详情页阅读。
  - 发表评论（异步提交，无需刷新）。
  - 点赞帖子（实时更新热度）。
- **热搜榜单**：各板块侧边栏显示点赞数最高的热门帖子。

### 🛡️ 管理员 (Admin)

- **数据看板**：查看用户总数、帖子总数、评论总数统计。
- **用户管理**：查看用户列表，修改用户角色（设为管理员/普通用户），删除用户。
- **板块管理**：添加新游戏板块、删除现有板块。
- **帖子管理**：查看全站帖子列表，违规帖子删除。

## 💾 数据库设计 (Database)

> 完整的 SQL 初始化脚本已包含在项目目录 LocalDatabase 中（`game_forum.sql`），可直接导入。

## 🚀 快速开始 (Quick Start)

### 环境准备

- JDK 1.8+
- MySQL 8.0+
- Tomcat 9.0+
- IntelliJ IDEA (推荐)

### 数据库配置

导入项目目录下的 SQL 文件：
_ **文件路径**: `LocalDatabase/game_forum.sql`
_ 使用 Navicat 或命令行导入该脚本以初始化表结构和默认数据。

### 项目配置

1.  克隆仓库到本地：
    ```bash
    git clone [https://github.com/idy-Q/GameForum_JSP]
    ```
2.  使用 IDEA 打开项目，等待 Maven 自动下载依赖。
3.  修改数据库配置文件 `src/main/resources/db.properties`：
    ```properties
    db.url=jdbc:mysql://localhost:3306/game_forum?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Shanghai
    db.username=你的数据库账号
    db.password=你的数据库密码
    ```

### 运行项目

1.  配置 Tomcat 服务器，将 Artifact `game-forum:war exploded` 添加到部署列表。
2.  启动服务器。
3.  访问地址：`http://localhost:8080/` (根据你的 Tomcat 配置路径)。
