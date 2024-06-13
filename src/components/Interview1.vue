//動画の切り替わりで読み込みのため一瞬白くなるのが気になる
<template>
  <v-app id="inspire">
    <v-app-bar flat>
      <v-container class="mx-auto d-flex align-center justify-center">
        <v-avatar class="me-4 " :color="avatarColor" size="32"></v-avatar>

        <v-btn v-if="res" color="red" class="text-h5 font-weight-bold"
          @click="() => $router.push({ name: 'other' })">面談終了</v-btn>
        <v-btn v-if="!res" :color="buttonAColor" @click="firstQuestion" class="text-h5 font-weight-bold">{{ buttonALabel
          }}</v-btn>

        <p class="text-h10">学業についての面談：{{ name }}さん</p>
        <v-spacer></v-spacer>
      </v-container>
    </v-app-bar>

    <v-main class="bg-grey-lighten-3">
      <v-container>
        <v-row>
          <v-col>
            <v-sheet min-height="h-auto" rounded="lg">
              <v-row justify="center">
                <div style="position: relative;">
                  <transition name="fade" mode="out-in">
                    <div :key="currentVideoIndex">
                      <video ref="videoPlayer" width="800" height="450" @ended="restartVideo">
                        <source :src="currentVideo === 'Wait' ? videoWait : videoQues" type="video/mp4">
                      </video>

                    </div>
                  </transition>

                  <div style="position: absolute; top: 0; right: 0; color: white;">
                    <video id="video" width="160" height="120" autoplay></video>
                  </div>

                  <div style="position: absolute; top: 0; left: 0; color: white;">
                    <v-card color="rgb(255, 255, 255, 0.3)" width="500" height="75">
                      <p class="text-h6 font-weight-bold">質問：{{ currentText }}</p>
                    </v-card>
                  </div>

                </div>
              </v-row>

              <v-spacer></v-spacer>

              <v-btn :disabled="!this.isButtonOn" :color="speechBtnColor" @click="startSpeechBtn">{{ speechtxt
                }}</v-btn>

              <p class="text-h6 font-weight-bold">進捗</p>
              <v-progress-linear v-model=progress color="light-blue" height="15" striped>
                <strong>{{ Math.ceil(progress) }}%</strong></v-progress-linear>

              <v-text-field label="発言内容の編集" v-model="transcript"></v-text-field>
              <div>回答：{{ transcript }}</div>
              <div>要約：{{ res }}</div>

              <v-btn :disabled="!isButtonAPushed" color="primary" @click="nextQuestion">{{ buttonBLabel }}</v-btn>


            </v-sheet>
          </v-col>

        </v-row>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
import db from "../firebase.js"
import axios from 'axios';
export default {
  data() {
    return {
      showB: true,
      progress: 0,
      recognition: null,
      isButtonAPushed: false,
      avatarColor: "grey-darken-1",
      buttonALabel: '面談開始',
      buttonAColor: 'green',
      buttonBLabel: '回答完了',
      speechBtnColor: 'green',
      speechtxt: "音声入力を開始",
      nextIndex: 0,
      transcript: '',
      exans: '',
      ans: [],
      isButtonOn: false,
      currentText: '',
      //質問内容の配列
      questions: ['前学期、週に何科目（コマ）ほど欠席していましたか？（小数点〇）',
        '前学期のGPAはどのくらいでしたか？',
        '学習方法で悩んでいることはありますか？',
        '最近、資格を取得した。または取得に向けて勉強していますか？',
        '卒業後の進路はどのように考えていますか？'],
      currentQuestionIndex: 0,
      num: 0,
      //ChatGPTの設定
      http: axios.create({
        baseURL: 'https://api.openai.com/v1/chat',
        headers: {
          'Content-Type': 'application/json',
          Authorization: 'Bearer sk-proj-JJfder5L3oGVAFd52zsCT3BlbkFJMUzPmMF3w8vtcAWsVGEB',
        },
      }),
      res: '',
      messages: [
        { role: "system", content: "あなたは大学生の修学を支援するアドバイザーです" },
      ],

      currentVideo: 'Wait',
      //面談動画の準備
      videoWait: require('../assets/waiting1.mp4'),
      videoQues: require('../assets/q1.mp4'),
      videoQ1: require('../assets/q1.mp4'),
      videoQ2: require('../assets/q2.mp4'),
      videoQ3: require('../assets/q3.mp4'),
      videoQ4: require('../assets/q4.mp4'),
      videoQ5: require('../assets/q5.mp4'),
      videoQ1_2: require('../assets/q1_2.mp4'),
      videoQ2_2: require('../assets/q2_2.mp4'),
      videoQ2_3: require('../assets/q2_3.mp4'),

      videoPlayer: null,
      currentVideoIndex: 0,
      q2_1: false,

      //要支援レベルの初期値
      absent: 0,
      GPA: 0,
      attend_points: 0,
      GPA_points: 0,
    };
  },
  //ルータを用いた画面遷移でnameの値があれば取得する
  created() {
    if (this.$route.query.name) {
      this.name = this.$route.query.name;
    }
  },
  mounted() {
    //動画の再生
    this.videoPlayer = this.$refs.videoPlayer;
    this.playVideo();
    //Webカメラの表示
    this.video = document.getElementById('video');

    navigator.mediaDevices.getUserMedia({ video: true, audio: false })
      .then(stream => {
        this.video.srcObject = stream;
        this.video.play();
      })
      .catch(err => {
        console.log("An error occured! " + err);
      });
  },
  computed: {
    //面談結果の要約
    text: function () {
      return `次の文を要約し、学生の面談結果として返してください。${this.questions.map((question, index) => {
        return `質問：${question}→回答：${this.ans[index]}`;
      }).join(", ")}`;
    },
  },

  methods: {
    //ChatGPTの回答に応じた処理※使ってない
    gpt_ques() {
      const message =
        { role: 'user', content: this.transcript };
      this.messages.push(message);

      this.http
        .post('/completions', {
          model: 'gpt-3.5-turbo',
          messages: this.messages,
          temperature: 0.7,
        })
        .then((response) => {
          console.log(response);
          this.questions.splice(this.ques, 0, response.data.choices[0].message.content);
          this.res = response.data.choices[0].message.content;
          this.messages.push(response.data.choices[0].message);
        })
        .catch((error) => {
          console.log(error);
        })
        .finally(() => {

        });
    },
    //ChatGPTの要約の処理
    gpt_summary() {
      const message =
        { role: 'user', content: this.text };
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
    //面談開始ボタン
    firstQuestion: function () {
      this.isButtonAPushed = !this.isButtonAPushed;

      if (this.isButtonAPushed) {
        this.avatarColor = "red-darken-1",
          this.buttonALabel = '面談中',
          this.buttonAColor = 'grey',
          this.currentQuestionIndex = 0,
          this.currentText = this.questions[this.currentQuestionIndex]

        this.currentVideo = 'Ques'
        //面談動画の再生
        this.playVideo();
        //音声入力の開始
        this.startRecording()
      } else {
        this.avatarColor = "grey-darken-1",
          this.buttonALabel = '面談開始',
          this.buttonAColor = 'green',
          this.currentQuestionIndex = 0,
          this.ques = 0
        this.currentText = this.questions[this.currentQuestionIndex];
      }
    },
    //音声の再入力
    startSpeechBtn: function () {
      this.startSpeech()
      this.speechtxt = "入力をやり直す"
      this.speechBtnColor = 'red'
    },
    //１問目の回答完了後以降の処理
    nextQuestion: function () {
      this.speechBtnColor = 'green',
        this.speechtxt = "音声入力を開始"
      this.isButtonOn = !this.isButtonOn
      console.log("質問一覧" + this.questions)
      this.nextIndex = this.questions.indexOf(this.currentText) + 1;
      console.log(this.questions.indexOf(this.currentText) + 1)
      this.progress = Math.trunc(((this.questions.indexOf(this.currentText) + 1) / this.questions.length) * 100)
      console.log(this.videoQues)

      //質問：欠席数
      //半角数字抽出
      function replaceFullToHalf(str) {
        return str.replace(/[！-～]/g, function (s) {
          return String.fromCharCode(s.charCodeAt(0) - 0xFEE0);
        });
      }

      //質問１、２共通
      if (this.questions[this.nextIndex - 1] == '前学期、週に何科目（コマ）ほど欠席していましたか？（小数点〇）') {
        this.exans = replaceFullToHalf(this.transcript);
        console.log("変換前" + this.exans)
        this.exans = this.exans.match(/\d+(\.\d+)?/g)
        this.absent = this.exans
        console.log("変換後" + this.exans)
        console.log(this.nextIndex + "番目の質問!")

        this.videoQues = this.videoQ2
        this.currentVideo = 'Ques'
        this.playVideo();



        //質問１a
        if (parseInt(this.exans) >= 1.63) {
          this.exans = "多い";
          this.attend_points = 4
          this.questions.splice(this.nextIndex, 0, "欠席が多い原因は何ですか？");
          this.q1a = true

          this.videoQues = this.videoQ1_2
          this.currentVideo = 'Ques'
        }
      }
      if (this.questions[this.nextIndex - 1] == '欠席が多い原因は何ですか？') {
        console.log("質問1_2")
        this.videoQues = this.videoQ2
        this.currentVideo = 'Ques'
        this.playVideo();

      }

      //質問2a
      if (this.questions[this.nextIndex - 1] == '前学期のGPAはどのくらいでしたか？') {

        this.exans = replaceFullToHalf(this.transcript);
        console.log("変換前" + this.exans)
        //this.exans = this.exans.match(/\d/g)
        this.exans = this.exans.match(/\d+(\.\d+)?/g)
        this.GPA = this.exans
        console.log("変換後" + this.exans)

        this.videoQues = this.videoQ3
        this.currentVideo = 'Ques'
        this.playVideo();

        if (2.0 < parseFloat(this.exans) && parseFloat(this.exans) <= 2.5) {
          this.questions.splice(this.nextIndex, 0, "現状の成績の満足度はどれくらいですか？0~100で表してください");
          this.q2_2 = true
          this.videoQues = this.videoQ2_2
          this.currentVideo = 'Ques'
        }
        if (parseFloat(this.exans) <= 2.0) {
          this.GPA_points = 4
          this.questions.splice(this.nextIndex, 0, "もう少し成績を伸ばすにはどこを改善するとよいと思いますか？");
          this.videoQues = this.videoQ2_3
          this.currentVideo = 'Ques'
        }

      }
      if (this.questions[this.nextIndex - 1] == "現状の成績の満足度はどれくらいですか？0~100で表してください") {
        console.log("質問2_1")
        this.exans = replaceFullToHalf(this.transcript);
        console.log("変換前" + this.exans)
        //this.exans = this.exans.match(/\d/g)
        this.exans = this.exans.match(/\d+(\.\d+)?/g)
        console.log("変換後" + this.exans)
        if (parseFloat(this.exans) <= 50) {
          this.GPA_points = 2
          this.q2_3 = true
          this.videoQues = this.videoQ2_3
          this.currentVideo = 'Ques'
          this.playVideo();

          this.startSpeech()
        } else {
          this.videoQues = this.videoQ3
          this.currentVideo = 'Ques'
          this.playVideo();

          this.startSpeech()
        }


        if (this.q2_3 === true) {
          this.exans = "低い";

          this.questions.splice(this.nextIndex, 0, "もう少し成績を伸ばすにはどこを改善するとよいと思いますか？");
          this.videoQues = this.videoQ2_3
          this.currentVideo = 'Ques'
        }
      }

      if (this.questions[this.nextIndex - 1] == 'もう少し成績を伸ばすにはどこを改善するとよいと思いますか？') {
        console.log("質問2_2")
        this.videoQues = this.videoQ3
        this.currentVideo = 'Ques'
        this.playVideo();

        this.startSpeech()
      }
      if (this.questions[this.nextIndex - 1] == '学習方法で悩んでいることはありますか？') {
        console.log("質問３")

        this.videoQues = this.videoQ4
        this.currentVideo = 'Ques'
        this.playVideo();

      }
      if (this.questions[this.nextIndex - 1] == '最近、資格を取得した。または取得に向けて勉強していますか？') {
        console.log("質問４")
        this.videoQues = this.videoQ5
        this.currentVideo = 'Ques'
        this.playVideo();

      }
      if (this.questions[this.nextIndex] == '卒業後の進路はどのように考えていますか？') {
        console.log("質問５")

      }

      this.ans.push(this.transcript)
      //質問終了後の処理
      if (this.nextIndex < this.questions.length) {
        this.currentText = this.questions[this.nextIndex];
        this.transcript = "";
      } else {
        //全質問終了後の処理
        this.stopRecording()
        this.gpt_summary()
        setTimeout(() => {
          this.downloadVideo();
        }, 2000);
      }
    },
    buttonClicked() {
    },
    //録画
    startRecording() {
      console.log("録画開始")
      this.mediaRecorder = new MediaRecorder(this.video.srcObject);
      this.chunks = [];

      this.mediaRecorder.ondataavailable = e => {
        this.chunks.push(e.data);
      };
      this.mediaRecorder.start();
    },
    startSpeech() {
      //音声認識
      window.SpeechRecognition =
        window.SpeechRecognition ||
        window.webkitSpeechRecognition;
      const recognition = new window.SpeechRecognition();
      recognition.lang = 'ja-JP';
      recognition.onresult = (event) => {
        var transcript = '';
        for (var i = event.resultIndex; i < event.results.length; ++i) {
          transcript += event.results[i][0].transcript;
        }
        console.log(transcript);

        this.transcript = transcript;
      };
      recognition.start();
    },

    stopRecording() {
      console.log("録画停止")
      //録画停止
      this.mediaRecorder.onstop = () => {
        const blob = new Blob(this.chunks, { 'type': 'video/mp4' });
        this.chunks = [];
        this.videoURL = URL.createObjectURL(blob);
      }
      this.mediaRecorder.stop();
    },
    stopSpeech() {
      console.log("止まってる")
      //音声認識停止
      if (this.recognition) {
        this.recognition.stop();
      }
    },

    downloadVideo() {
      //動画ダウンロード
      const downloadLink = document.createElement('a');
      downloadLink.href = this.videoURL;
      downloadLink.download = `${this.name}_iv1.mp4`
      downloadLink.click();
    },
    //面談動画の再生
    playVideo() {
      this.$refs.videoPlayer.load();
      this.$refs.videoPlayer.play();
    },
    //待機中動画の再生
    playNextVideo() {
      this.videoFile = this.videoB;
      this.playVideo();
    },
    //待機中動画のループ再生
    restartVideo() {
      if (this.currentVideo == 'Ques') {
        this.isButtonOn = !this.isButtonOn
      }
      this.currentVideo = 'Wait';
      this.playVideo()
    },
    //Firebaseのデータ保存
    postData() {
      db.collection('students').doc("Tog7T2npGjHlC86Gw3Bp").update({
        ans1: String(this.res),
        absent: String(this.absent),
        gpa: String(this.GPA),
        AP: String(this.attend_points),
        GP: String(this.GPA_points),
      }).then((response) => {
        console.log(response);
      }).catch((error) => {
        console.log(error);
      });
    },
  },
};
</script>

<style scope>
button {
  margin-top: 10px;
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s;
}

.fade-enter,
.fade-leave-to {
  opacity: 0;
}
</style>
