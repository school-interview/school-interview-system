<template>
  <div class="my-2" />
  <v-app>
    <v-app-bar flat>
      <v-container class="mx-auto">
      <p class="text-h5" style="font-weight: bold" >学生面談（工学部）~面談選択画面~</p>
    </v-container>
  </v-app-bar>
  <v-main class="bg-grey-lighten-3">
  <v-card max-width="600" class="mx-auto">
    <p class="text-h5" style="font-weight: bold">{{ text }}さん ようこそ</p>
    
    <p class="text-h7" style="font-weight: bold">{{ items }}</p>

    <v-container >
    <v-col cols="12">
          <v-card color="#f0f8ff" theme="dark">
            <div class="d-flex flex-no-wrap justify-space-between">
              <div>


                <v-card-title class="text-h5"> 学業について </v-card-title>

                <v-card-subtitle>成績,出席率,好きな講義等...</v-card-subtitle>

              </div>
              <v-card-actions>
                <v-btn
                  class="ma-2"
                  variant="outlined"
                  width="75" height="75"
                  color="white"
                  style="font-weight: bold;background-color: #4169e1;"
                  @click="() => $router.push({ name: 'interview1',query: {name: text }})"
                
                  >面談に<br>進む
                  
                  
                  <v-icon
                    size="large"
                    icon="mdi-arrow-right-bold-box-outline"
                  ></v-icon>
                </v-btn>
                </v-card-actions>
            </div>
          </v-card>
        </v-col>


        <v-col cols="12">
          <v-card color="#f0f8ff" theme="dark">
            <div class="d-flex flex-no-wrap justify-space-between">
              <div>
                <v-card-title class="text-h5"> 学生生活について </v-card-title>

                <v-card-subtitle>サークル,アルバイト等...</v-card-subtitle>

              </div>
              <v-card-actions>
                <v-btn
                  class="ma-2"
                  variant="outlined"
                  width="75" height="75"
                  color="white"
                  style="font-weight: bold;background-color: #4169e1;"
                  @click="() => $router.push({ name: 'interview2',query: {name: text }})"
                >
                  面談に<br>進む
                  
                  
                  <v-icon
                    size="large"
                    icon="mdi-arrow-right-bold-box-outline"
                  ></v-icon>
                </v-btn>
                </v-card-actions>
            </div>
          </v-card>
        </v-col>

        <v-btn
          color="success"
          class="mt-4"
          block
          @click ="() => $router.push({ name: 'finish',query: {name: text}})"
          >面談終了
        </v-btn>
        
  </v-container>
  </v-card>
</v-main>
</v-app>
</template>

<script>
import db from "../firebase.js"
export default {
  name: 'OtherPage',
  data() {
    //ここで引数を受け取る
    return{
    id: '',
    text: '',
    q1:[],
    int1:[],
    t1:'',
    ans:'',

    items:""
    }
  },
  created(){
    if(this.$route.query.name){
    this.text = this.$route.query.name;
    }
    if(this.$route.query.ans){
      this.ans1 = JSON.parse(JSON.stringify(this.$route.query.ans))
    }
  },
  methods:{
    Submit(){
      
    },
    postData(){
      db.collection('students').doc("Udyu2MqnkkrNIgsMxFEh").update({
              ans1: String(this.ans),
          }).then((response) => {
              console.log(response);            
            }).catch((error) => {
              console.log(error);
          });
    },

    getData: function () {

      // データ取得
      db.collection('students').where('name', '==', String(this.text)).get(
      ).then((querySnapshot) => {
          querySnapshot.forEach((doc) => {
            //this.data = doc.data()
              // テーブル表示
              this.items = doc.data().num2;
              console.log(this.items)
          });
      }).catch((error) => {
          console.log(error);
          // テーブルリセット
          this.items = [];
      });
      },
  }
}
</script>

<style>
/*CSSを記載*/
</style>