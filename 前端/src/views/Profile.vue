<template>
  <div class="profile">
    <el-card class="profile-card">
      <div slot="header">
        <span>个人信息</span>
      </div>
      <el-form :model="userForm" :rules="rules" ref="userForm" label-width="100px">
        <el-form-item label="用户名">
          <el-input v-model="userForm.username" disabled></el-input>
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
          <el-input v-model="userForm.email"></el-input>
        </el-form-item>
        <el-form-item label="新密码" prop="newPassword">
          <el-input type="password" v-model="userForm.newPassword"></el-input>
        </el-form-item>
        <el-form-item label="确认密码" prop="confirmPassword">
          <el-input type="password" v-model="userForm.confirmPassword"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="updateProfile">保存修改</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
export default {
  name: 'Profile',
  data() {
    const validatePass = (rule, value, callback) => {
      if (value && value !== this.userForm.newPassword) {
        callback(new Error('两次输入密码不一致'))
      } else {
        callback()
      }
    }
    return {
      userForm: {
        username: '',
        email: '',
        newPassword: '',
        confirmPassword: ''
      },
      rules: {
        email: [
          { required: true, message: '请输入邮箱地址', trigger: 'blur' },
          { type: 'email', message: '请输入正确的邮箱地址', trigger: 'blur' }
        ],
        newPassword: [
          { min: 6, message: '密码长度不能少于6个字符', trigger: 'blur' }
        ],
        confirmPassword: [
          { validator: validatePass, trigger: 'blur' }
        ]
      }
    }
  },
  created() {
    this.fetchUserInfo()
  },
  methods: {
    async fetchUserInfo() {
      try {
        const { data } = await this.$http.get('/api/users/profile')
        this.userForm.username = data.username
        this.userForm.email = data.email || ''
      } catch (error) {
        console.error('获取用户信息失败:', error)
        this.$message.error('获取用户信息失败')
      }
    },
    async updateProfile() {
      try {
        await this.$refs.userForm.validate()
        const updateData = {
          email: this.userForm.email
        }
        if (this.userForm.newPassword) {
          updateData.password = this.userForm.newPassword
        }
        await this.$http.put('/api/users/profile', updateData)
        this.$message.success('更新成功')
        if (this.userForm.newPassword) {
          this.$store.commit('logout')
          this.$router.push('/login')
        }
      } catch (error) {
        console.error('更新失败:', error)
        this.$message.error('更新失败')
      }
    }
  }
}
</script>

<style scoped>
.profile {
  padding: 20px;
}
.profile-card {
  max-width: 600px;
  margin: 0 auto;
}
</style>
