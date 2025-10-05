<template>
  <div class="blog-list">
    <el-card>
      <div slot="header" class="header">
        <el-input
          v-model="searchQuery"
          placeholder="搜索博客标题"
          style="width: 200px"
          @change="handleSearch"
        ></el-input>
        <el-button type="primary" @click="$router.push('/home/blog-edit')">写博客</el-button>
      </div>
      
      <el-table v-loading="loading" :data="blogs" style="width: 100%">
        <el-table-column prop="title" label="标题"></el-table-column>
        <el-table-column label="创建时间">
          <template slot-scope="scope">
            {{ formatDate(scope.row.createTime) }}
          </template>
        </el-table-column>
        <el-table-column label="操作" width="180">
          <template slot-scope="scope">
            <el-button type="text" @click="handleEdit(scope.row)">编辑</el-button>
            <el-button type="text" @click="handleDelete(scope.row.id)" style="color: #F56C6C">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      
      <div class="pagination">
        <el-pagination
          @current-change="handleCurrentChange"
          :current-page="currentPage"
          :page-size="pageSize"
          :total="total"
          layout="total, prev, pager, next"
        >
        </el-pagination>
      </div>
    </el-card>
  </div>
</template>

<script>
export default {
  name: 'BlogList',
  data() {
    return {
      blogs: [],
      loading: false,
      searchQuery: '',
      currentPage: 1,
      pageSize: 10,
      total: 0
    }
  },
  created() {
    this.fetchBlogs()
  },
  methods: {
    async fetchBlogs() {
      this.loading = true
      try {
        const { data } = await this.$http.get('/api/blogs', {
          params: {
            page: this.currentPage - 1,
            size: this.pageSize,
            search: this.searchQuery
          }
        })
        this.blogs = data.content
        this.total = data.totalElements
      } catch (error) {
        this.$message.error('获取博客列表失败')
      }
      this.loading = false
    },
    formatDate(date) {
      return new Date(date).toLocaleDateString()
    },
    handleEdit(blog) {
      this.$router.push(`/home/blog-edit?id=${blog.id}`)
    },
    async handleDelete(id) {
      try {
        await this.$confirm('确认删除这篇博客吗？')
        await this.$http.delete(`/api/blogs/${id}`)
        this.$message.success('删除成功')
        this.fetchBlogs()
      } catch (error) {
        if (error !== 'cancel') {
          this.$message.error('删除失败')
        }
      }
    },
    handleSearch() {
      this.currentPage = 1
      this.fetchBlogs()
    },
    handleCurrentChange(page) {
      this.currentPage = page
      this.fetchBlogs()
    }
  }
}
</script>

<style scoped>
.blog-list {
  padding: 20px;
}
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.pagination {
  margin-top: 20px;
  text-align: right;
}
</style>
