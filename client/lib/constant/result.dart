/// APIの処理結果
enum Result {
  // 成功
  success,
  // 失敗
  fail,

  // ユーザー情報登録APIエラー
  putUserInformationError,

  // 面談開始リクエスト送信APIエラー
  postInterviewSessionRequestError,
}
