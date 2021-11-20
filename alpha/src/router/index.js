import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: "/",
    redirect: "/alpha"
  },
  {
    path: '/alpha',
    name: 'Root',
    component: () => import(/* webpackChunkName: "about" */ '../views/Root.vue'),
    children: [
      {
        path: '',
        name: 'Home',
        component: () => import(/* webpackChunkName: "about" */ '../views/Home.vue')
      },
      {
        path: 'about',
        name: 'About',
        component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
      }
    ]
  },
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
