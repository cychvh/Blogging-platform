import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from '../views/Login.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    redirect: '/login'
  },
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  {
    path: '/home',
    name: 'Home',
    component: () => import('../views/Home.vue'),
    children: [
      {
        path: 'blog-list',
        name: 'BlogList',
        component: () => import('../views/BlogList.vue')
      },
      {
        path: 'blog-edit',
        name: 'BlogEdit',
        component: () => import('../views/BlogEdit.vue')
      },
      {
        path: 'profile',
        name: 'Profile',
        component: () => import('../views/Profile.vue')
      }
    ]
  }
]

export default new VueRouter({
  routes
})
