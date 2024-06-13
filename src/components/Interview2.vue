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

        <p class="text-h10">学生生活についての面談：{{ name }}さん</p>
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
      questions: ['大学生活において最も楽しんでいることは何ですか？',
        '大学生活において大変だと感じていることはありますか？',
        '休日の過ごし方や趣味について教えてください',
        'サークルやアルバイト等の課外活動において、悩みはありませんか？'],
      currentQuestionIndex: 0,
      num: 0,
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
      //videoFile:require('../assets/waiting1.mp4'),
      videoWait: require('../assets/v2/w1v.mp4'),
      videoQues: require('../assets/v2/2q1v.mp4'),
      videoQ1: require('../assets/v2/2q1v.mp4'),
      videoQ2: require('../assets/v2/2q2v.mp4'),
      videoQ3: require('../assets/v2/2q3v.mp4'),
      videoQ4: require('../assets/v2/2q4v.mp4'),

      videoPlayer: null,
      currentVideoIndex: 0,
    };
  },
  created() {
    if (this.$route.query.name) {
      this.name = this.$route.query.name;
    }
  },
  mounted() {
    //アバター部分
    this.videoPlayer = this.$refs.videoPlayer;
    this.playVideo();

    //動画部分
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
    text: function () {
      return `次の文を要約し、学生の面談結果として返してください。${this.questions.map((question, index) => {
        return `質問：${question}→回答：${this.ans[index]}`;
      }).join(", ")}`;
    },
  },
  methods: {
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
    firstQuestion: function () {
      this.isButtonAPushed = !this.isButtonAPushed;

      if (this.isButtonAPushed) {
        this.avatarColor = "red-darken-1",
          this.buttonALabel = '面談中',
          this.buttonAColor = 'grey',
          this.currentQuestionIndex = 0,
          this.currentText = this.questions[this.currentQuestionIndex]

        this.currentVideo = 'Ques'
        this.playVideo();

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
    startSpeechBtn: function () {
      this.startSpeech()
      this.speechtxt = "入力をやり直す"
      this.speechBtnColor = 'red'
    },
    nextQuestion: function () {
      this.stopSpeech()
      this.speechBtnColor = 'green',
        this.speechtxt = "音声入力を開始"
      this.isButtonOn = !this.isButtonOn
      console.log("質問一覧" + this.questions)
      this.nextIndex = this.questions.indexOf(this.currentText) + 1;
      console.log(this.questions.indexOf(this.currentText) + 1)
      this.progress = Math.trunc(((this.questions.indexOf(this.currentText) + 1) / this.questions.length) * 100)
      console.log(this.videoQues)


      //質問１
      if (this.questions[this.nextIndex - 1] == '大学生活において最も楽しんでいることは何ですか？') {
        this.videoQues = this.videoQ2
        this.currentVideo = 'Ques'
        this.playVideo();
      }
      //質問2
      if (this.questions[this.nextIndex - 1] == '大学生活において大変だと感じていることはありますか？') {
        this.videoQues = this.videoQ3
        this.currentVideo = 'Ques'
        this.playVideo();
      }
      if (this.questions[this.nextIndex - 1] == '休日の過ごし方や趣味について教えてください') {
        console.log("質問３")

        this.videoQues = this.videoQ4
        this.currentVideo = 'Ques'
        this.playVideo();

      }
      if (this.questions[this.nextIndex - 1] == 'サークルやアルバイト等の課外活動において、悩みはありませんか？') {
        console.log("質問４")
        this.videoQues = this.videoQ5
        this.currentVideo = 'Ques'
        this.playVideo();
      }

      this.ans.push(this.transcript)
      if (this.nextIndex < this.questions.length) {
        this.currentText = this.questions[this.nextIndex];
        this.transcript = "";
      } else {
        this.gpt_summary()
        //this.$router.push({ name: 'other',query: {ans: this.res}})
      }

    },
    buttonClicked() {
    },
    //録画
    startRecording() {
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

        // Vue.jsのデータに音声認識の結果を設定する
        this.transcript = transcript;
      };
      recognition.start();
      console.log("RECなう")
    },

    /* 無音の時に音声認識終了しないようにする（変な挙動するからコメントにしてる）
    recognition.onend = function() {
      // 音声認識が終了したときに再開する
      setTimeout(function() {
        recognition.start();
      }, 5000); // 5秒後に再開
    };
    */
    stopRecording() {
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
      //音声認識
      if (this.recognition) {
        this.recognition.stop();
      }
    },


    downloadVideo() {
      //動画ダウンロード
      const downloadLink = document.createElement('a');
      downloadLink.href = this.videoURL;
      downloadLink.download = 'output.mp4';
      downloadLink.click();
    },
    playVideo() {

      this.$refs.videoPlayer.load();
      this.$refs.videoPlayer.play();
    },
    playNextVideo() {
      this.videoFile = this.videoB;
      this.playVideo();
    },
    restartVideo() {
      if (this.currentVideo == 'Ques') {
        this.isButtonOn = !this.isButtonOn
      }
      this.currentVideo = 'Wait';
      //this.videoPlayer.currentTime = 0; // 動画の再生位置を最初に戻す
      this.playVideo()
    },

    postData() {
      db.collection('students').doc("Tog7T2npGjHlC86Gw3Bp").update({
        ans2: String(this.res),
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
