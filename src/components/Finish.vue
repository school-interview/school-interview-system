<template>
  <div class="my-2" />
  <v-app>
    <v-app-bar flat>
      <v-container class="mx-auto">
      <p class="text-h5" style="font-weight: bold" >学生面談（工学部）~面談結果~</p>
    </v-container>
    
  </v-app-bar>
  
  <v-main class="bg-grey-lighten-3">
    <v-container class="mx-auto d-flex align-center justify-center">
    <v-btn v-if="!bigbtn" @click="firstbtn" color="green" size="x-large">{{ text }}さんの面談結果を表示する</v-btn>

    <div class="mx-auto mt-3 text-center" style="width:600px;">

<v-dialog 
  v-model="dialog" 
  persistent
  width="300"
>
  <v-card height="190" class="text-center">
    <v-container class="mx-auto d-flex align-center justify-center">
    <v-progress-circular
      :indeterminate="isLoading"
      :size="100"
      color="primary"
      class="mt-4 "
    >Loading...
    </v-progress-circular>
  </v-container>
  </v-card>
</v-dialog>

</div>

  </v-container>
  
  <v-card v-if="bigbtn" max-width="1000" class="mx-auto">

    
    <p class="text-h7" style="font-weight: bold">{{ items }}</p>

    <v-container >
    <v-col cols="12">
          <v-card color="#f8f8ff" theme="dark">
            <div class="d-flex flex-no-wrap justify-space-between">
              <div>


                <v-card-title class="text-h5"> 学業ついての回答 </v-card-title>
                <v-card-text class="text-wrap">{{this.data.ans1}}</v-card-text>

              </div>
              <v-card-actions>
                <v-btn
                  class="ma-2"
                  variant="outlined"
                  width="100" height="75"
                  color="white"
                  style="font-weight: bold;background-color: #2552da;"
                  @click="startvideo"
                
                  >動画を<br>表示する
                
                </v-btn>
                </v-card-actions>
            </div>
          </v-card>
        </v-col>

        <v-container class="mx-auto d-flex align-center justify-center">
        <video v-if="isbtnpushed1" ref="videoPlayer" width="800" height="450" controls>
            <source :src="video1" type="video/mp4" ></video>
        </v-container>

        <v-col cols="12">
          <v-card color="#f8f8ff" theme="dark">
            <div class="d-flex flex-no-wrap justify-space-between">
              <div>


                <v-card-title class="text-h5"> 学生生活ついての回答  </v-card-title>

                <v-card-text class="text-wrap">{{this.data.ans2}}</v-card-text>

              </div>
              
        
              <v-card-actions>

                <v-btn
                  class="ma-2"
                  variant="outlined"
                  width="100" height="75"
                  color="white"
                  style="font-weight: bold;background-color: #d3872f;"
                  @click="startvideo2"
                
                  >動画を<br>表示する
                  
                
                </v-btn>
                </v-card-actions>
            </div>
          </v-card>
        </v-col>
        <v-container class="mx-auto d-flex align-center justify-center">
            <video v-if="isbtnpushed2" ref="videoPlayer" width="800" height="450" controls>
            <source :src="video2" type="video/mp4" ></video>
          </v-container>
          
          <v-col cols="12">
          <v-card color="#fff8dc" theme="dark">
            <div class="d-flex flex-no-wrap justify-space-between">
              <div>


                <v-card-title :class="{'color-black': sum >= 0 && sum <= 4, 'color-orange': sum >= 5 && sum <= 6, 'color-red': sum >= 7 && sum <= 10}"> 要支援レベル：{{ sum }}</v-card-title>
                <v-card-text class="text-h8">週当たりの平均欠席科目数：{{ data.absent }} GPA：{{ data.gpa }}<br>学生生活の分析：{{reason}}</v-card-text>




              </div>
              
            </div>
          </v-card>
        </v-col>
        
  </v-container>
  </v-card>
</v-main>
</v-app>
</template>

<script>
import db from "../firebase.js"
import axios from 'axios';
export default {
  data() {
    return {
      isLoading:true,
      dialog:false,
      text:"",
      videosourse:"",
      video:"",
      bigbtn:false,
      isbtnpushed1:false,
      isbtnpushed2:false,
      ans1:"",
      ans2:"",
      data:{},
      
      http: axios.create({
       baseURL: 'https://api.openai.com/v1/chat',
       headers: {
         'Content-Type': 'application/json',
         Authorization: 'Bearer "ChatGPT API key"',
       },
     }),
     res:'',
     messages: [
         { role: "system", content: "あなたは大学生の修学を支援するアドバイザーです" },
       ],


      GPT_res: '',
      lines: [],
      level: "",
      reason: '',
      sum:"",
      result:"",
    };
  },
  created(){
    if(this.$route.query.name){
    this.text = this.$route.query.name;
    }
    this.getData()
  },
  mounted() {
  
  },
  computed: {
    summary: function() {
    return `以下の学生生活における回答の特徴を踏まえて総合的に、支援が必要か判別するための要支援レベルを0～5の尺度でつけて、支援レベルとそのレベルを付けた理由を返してほしいです。形式は「要支援レベル：〇」、そのあとに必ず"/n"を挿入してください。要支援レベルは高いほど優先的な支援が必要だと表しています。学生生活ついての回答：${this.data.ans2}`;
  },},
  methods: {
    gpt_summary(){
   const message = 
        {role: 'user', content: this.summary} ;
     this.messages.push(message);
     
     this.http
       .post('/completions', {
         model: 'gpt-3.5-turbo',
         messages: this.messages,
         temperature: 0.7,
       })
       .then((response) => {
         console.log(response);
         this.res = response.data.choices[0].message.content;
         this.messages.push(response.data.choices[0].message);
         this.postData()
       })
       .catch((error) => {
         console.log(error);
       })
       .finally(() => {
         
       });
 },
    firstbtn(){
      this.dialog = true
      if(!this.data.GptRes){
        this.gpt_summary()
      

      setTimeout(() => {
        console.log(this.res)
        this.postData()
        this.dialog = false
        this.bigbtn=!this.bigbtn
     }, 7000);
    }else{
      this.getData()
      this.cut()
      this.get()
      setTimeout(() => {
        this.dialog = false
        this.bigbtn=!this.bigbtn
     }, 2000);
    }

    },

    startvideo() {
      this.isbtnpushed1 = !this.isbtnpushed1
      if(this.isbtnpushed1 == true){
        if(this.isbtnpushed2 == true){
          this.isbtnpushed2 = !this.isbtnpushed2
        }
      this.videosourse='吉川'
       this.video1 = require(`../assets/${this.videosourse}_iv1.mp4`)
       //ローカルにアクセス権限がない
       setTimeout(() => {
        this.playVideo()
     }, 1000);
      }
    },

    startvideo2() {
      this.isbtnpushed2 = !this.isbtnpushed2
      if(this.isbtnpushed2 == true){
        if(this.isbtnpushed1 == true){
          this.isbtnpushed1 = !this.isbtnpushed1
        }
      this.videosourse='吉川'
       this.video2 = require(`../assets/${this.videosourse}_iv2.mp4`)
       //ローカルにアクセス権限がない
       setTimeout(() => {
        this.playVideo()
     }, 1000);
      }
    },
    playVideo() {
      this.$refs.videoPlayer.load();
      this.$refs.videoPlayer.play();
      },
      //Firebaseのデータ取得
      getData: function () {
        db.collection("students").where("num2", "==", "1EP1-02")
        .get()
        .then((querySnapshot) => {
            querySnapshot.forEach((doc) => {
                // doc.data() is never undefined for query doc snapshots
                console.log(doc.id, " => ", doc.data());
                this.data = doc.data()
            });
        })
        .catch((error) => {
            console.log("Error getting documents: ", error);
        });

   
  },
  replaceFullToHalf(str){
       return str.replace(/[！-～]/g, function(s){
         return String.fromCharCode(s.charCodeAt(0) - 0xFEE0);
       });
     },
    send() {
      // 資料作成のため文章を直接打ってる
      this.GPT_res = `
        要支援レベル：2
        /n
        理由：
        学生は大学生活で楽しみながら過ごしているようですが、課題に対する苦労を感じています。課題に関する具体的な内容やその対処方法については不明ですが、課題に対するサポートやアドバイスが必要と考えられます。サークル活動が楽しいとのことなので、学業とのバランスを取りながら、課題への取り組み方や時間管理のサポートが必要となります。また、趣味としてのプロ野球観戦や課外活動においては悩みがないようですが、学業との調和を保つためにもサポートが必要です。
      `;
    },
    cut() {
      this.GPT_res = this.data.GptRes
      this.lines = this.GPT_res.split('/n');
      this.level = this.lines[0].trim();
      this.reason = this.lines[1].trim();
    },
    get(){
      this.level = this.replaceFullToHalf(this.level)
      this.level = this.level.match(/\d+(\.\d+)?/g)

      this.sum = parseInt(this.level) + parseInt(this.data.AP) + parseInt(this.data.GP)
      this.sum = Math.min(this.sum, 10);
    },
    //Firebaseのデータ保存
    postData(){
      db.collection('students').doc("Tog7T2npGjHlC86Gw3Bp").update({
              GptRes: String(this.res),
          }).then((response) => {
              console.log(response);            
            }).catch((error) => {
              console.log(error);
          });
    },
  }
}

</script>

<style>
.color-black {
 color: black;
}

.color-orange {
 color: orange;
}

.color-red {
 color: red;
}
</style>
