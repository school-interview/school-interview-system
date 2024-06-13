//Vue Routerを使うためにインポート。
import { createRouter, createWebHistory } from 'vue-router'
import MainPage from './components/MainPage.vue'
import OtherPage from './components/OtherPage.vue'
import Interview1 from './components/Interview1.vue'
import Interview2 from './components/Interview2.vue'
import Finish from './components/Finish.vue'


export const router = createRouter({
    history: createWebHistory('/'),
    routes: [
      {
        path: '/',
        name: 'main',
        component: MainPage,
      },
      {
        path: '/other', //pathの書き方を変更
        name: 'other',
        component: OtherPage,
      },
      {
        path: '/interview1', //pathの書き方を変更
        name: 'interview1',
        component: Interview1,
      },
      {
        path: '/interview2', //pathの書き方を変更
        name: 'interview2',
        component: Interview2,
      },
      {
        path: '/finish', //pathの書き方を変更
        name: 'finish',
        component: Finish,
      }
    ]
  })
  