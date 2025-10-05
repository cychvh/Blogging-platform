<template>
  <div class="login-container">
    <el-card class="login-card">
      <div class="title">博客系统</div>
      <el-tabs v-model="activeTab">
        <el-tab-pane label="登录" name="login">
          <el-form :model="loginForm" :rules="rules" ref="loginForm">
            <el-form-item prop="username">
              <el-input v-model="loginForm.username" placeholder="用户名"></el-input>
            </el-form-item>
            <el-form-item prop="password">
              <el-input type="password" v-model="loginForm.password" placeholder="密码"></el-input>
            </el-form-item>
            <el-button type="primary" @click="handleLogin" block>登录</el-button>
          </el-form>
        </el-tab-pane>
        <el-tab-pane label="注册" name="register">
          <el-form :model="registerForm" :rules="rules" ref="registerForm">
            <el-form-item prop="username">
              <el-input v-model="registerForm.username" placeholder="用户名"></el-input>
            </el-form-item>
            <el-form-item prop="password">
              <el-input type="password" v-model="registerForm.password" placeholder="密码"></el-input>
            </el-form-item>
            <el-button type="primary" @click="handleRegister" block>注册</el-button>
          </el-form>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
import { mapMutations } from 'vuex'

export default {
  name: 'Login',
  data() {
    return {
      activeTab: 'login',
      loginForm: {
        username: '',
        password: ''
      },
      registerForm: {
        username: '',
        password: ''
      },
      rules: {
        username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
        password: [{ required: true, message: '请输入密码', trigger: 'blur' }]
      }
    }
  },
  methods: {
    ...mapMutations(['setToken']),
    async handleLogin() {
      try {
        await this.$refs.loginForm.validate()
        const { data } = await this.$http.post('/api/users/login', this.loginForm)
        this.setToken(data.token)
        this.$message.success('登录成功')
        this.$router.push('/home/blog-list')
      } catch (error) {
        this.$message.error('登录失败')
      }
    },
    async handleRegister() {
      try {
        await this.$refs.registerForm.validate()
        await this.$http.post('/api/users/register', this.registerForm)
        this.$message.success('注册成功')
        this.activeTab = 'login'
        this.loginForm = { ...this.registerForm }
      } catch (error) {
        this.$message.error('注册失败')
      }
    }
  }
}
</script>

<style scoped>
.login-container {
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #f3f3f3;
}
.login-card {
  width: 400px;
}
.title {
  text-align: center;
  font-size: 24px;
  margin-bottom: 20px;
}
</style>
