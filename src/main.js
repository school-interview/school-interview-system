import { createApp } from 'vue'
import vuetify from './plugins/vuetify'
import { router } from './router.js' //上記で作ったrouterをインポート

import App from './App.vue'

const app = createApp(App)
app.use(router) //routerをアプリケーション全体で使えるようにする
app.use(vuetify)
app.mount('#app')
