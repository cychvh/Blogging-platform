<template>
  <div class="blog-edit">
    <el-form :model="blogForm" :rules="rules" ref="blogForm" label-width="80px">
      <el-form-item label="标题" prop="title">
        <el-input v-model="blogForm.title"></el-input>
      </el-form-item>
      <el-form-item label="内容" prop="content">
        <el-input type="textarea" v-model="blogForm.content" :rows="15"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitForm">{{ isEdit ? '更新' : '发布' }}</el-button>
        <el-button @click="$router.back()">取消</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
export default {
  name: 'BlogEdit',
  data() {
    return {
      isEdit: false,
      blogForm: {
        title: '',
        content: ''
      },
      rules: {
        title: [{ required: true, message: '请输入标题', trigger: 'blur' }],
        content: [{ required: true, message: '请输入内容', trigger: 'blur' }]
      }
    }
  },
  created() {
    const blogId = this.$route.query.id
    if (blogId) {
      this.isEdit = true
      this.fetchBlogDetail(blogId)
    }
  },
  methods: {
    async fetchBlogDetail(id) {
      try {
        const { data } = await this.$http.get(`/api/blogs/${id}`)
        this.blogForm = data
      } catch (error) {
        this.$message.error('获取博客详情失败')
      }
    },
    async submitForm() {
      try {
        await this.$refs.blogForm.validate()
        if (this.isEdit) {
          await this.$http.put(`/api/blogs/${this.$route.query.id}`, this.blogForm)
          this.$message.success('更新成功')
        } else {
          const token = localStorage.getItem('token')
          await this.$http.post('/api/blogs', this.blogForm, {
            headers: {
              'Authorization': `Bearer ${token}`
            }
          })
          this.$message.success('发布成功')
        }
        this.$router.push('/home/blog-list')
      } catch (error) {
        console.error('操作失败:', error)
        this.$message.error(this.isEdit ? '更新失败' : '发布失败')
      }
    }
  }
}
</script>

<style scoped>
.blog-edit {
  padding: 20px;
  max-width: 800px;
  margin: 0 auto;
}
</style>
