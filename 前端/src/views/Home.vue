<template>
  <el-container class="home">
    <el-aside width="200px">
      <el-menu router default-active="$route.path">
        <el-menu-item index="/home/blog-list">
          <i class="el-icon-document"></i>
          <span>博客管理</span>
        </el-menu-item>
        <el-menu-item index="/home/profile">
          <i class="el-icon-user"></i>
          <span>个人信息</span>
        </el-menu-item>
      </el-menu>
    </el-aside>
    <el-container>
      <el-header>
        <div class="header-right">
          <span>欢迎，{{ username }}</span>
          <el-button type="text" @click="logout">退出</el-button>
        </div>
      </el-header>
      <el-main>
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
export default {
  name: 'Home',
  data() {
    return {
      username: localStorage.getItem('username')
    }
  },
  methods: {
    logout() {
      localStorage.clear()
      this.$router.push('/login')
    }
  }
}
</script>

<style scoped>
.home {
  height: 100%;
}
.el-header {
  background-color: #fff;
  border-bottom: 1px solid #ddd;
  display: flex;
  align-items: center;
  justify-content: flex-end;
}
.header-right {
  margin-right: 20px;
}
</style>
