<template>
  <v-app>
    <div class="my-0" />
    <v-app-bar flat>
      <v-container class="mx-auto d-flex align-center justify-center">
        <v-app-bar-title>
          <p class="text-h5" style="font-weight: bold">学生面談（工学部）~学生情報入力画面~</p>
        </v-app-bar-title>
      </v-container>
    </v-app-bar>

    <v-main class="bg-grey-lighten-3">
      <v-container>
        <v-sheet min-height="40vh" rounded="lg">

          <p class="text-h4"></p>
          <v-col cols="12" md="6">
            <v-select v-model="selected" label="学科を選択してください"
              :items="['情報工学科', '電気電子情報工学科', '機械工学科', '航空システム工学科', '環境土木工学科', 'ロボティックス学科']" hide-details
              required></v-select>
          </v-col>

          <v-col cols="12" md="4">
            <v-text-field v-model="num1" :rules="[required, limit_length]" counter="10" label="学籍番号"
              placeholder="1234567" hide-details required></v-text-field>
          </v-col>

          <v-col cols="12" md="4">
            <v-text-field v-model="num2" :counter="15" label="クラス-名列番号" placeholder="1EP1-01" hide-details
              required></v-text-field>
          </v-col>

          <v-col cols="12" md="4">
            <v-text-field v-model="name" :counter="15" label="氏名" required hide-details></v-text-field>
          </v-col>

          <p class="text-h6">学科：{{ selected }}</p>
          <p class="text-h6">クラス-名列番号：{{ num2 }}</p>
          <p class="text-h6">氏名：{{ name }}</p>

          <v-btn @click="postData">データ追加</v-btn>


          <v-btn color="success" class="mt-4" block
            @click="() => $router.push({ name: 'other', query: { name: name } })">
            入力完了
          </v-btn>
        </v-sheet>
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
import db from "../firebase.js"

export default {
  name: 'MainPage',
  data() {
    return {
      num1: "",
      num2: "",

      required: value => !!value || "必ず入力してください", // 入力必須の制約
      limit_length: value => value.length <= 10 || "10文字以内で入力してください",
      nameRule: [
        v => !!v || 'Name is required',
        v => /.+[-].+/.test(v),
      ],
      name: "",
      items: [],
      selected: [],
      t1: "",
      ans: "",
      ans3: "",
    }
  },
  methods: {
    test: function () {
      this.ans3 = this.data.ans2

    },
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
    //Firebaseのデータ保存
    postData: function () {
      // データ登録
      db.collection('students').add({
        class: String(this.selected),
        num1: Number(this.num1),
        num2: String(this.num2),
        name: String(this.name)
      }).then((response) => {
        console.log(response);
      }).catch((error) => {
        console.log(error);
      });
    },

    postData2() {
      db.collection('students').doc("Udyu2MqnkkrNIgsMxFEh").update({
        ans1: String(this.ans),
      }).then((response) => {
        console.log(response);
      }).catch((error) => {
        console.log(error);
      });
    }
  }
}
</script>

<style>
/*CSSを記載*/
</style>
