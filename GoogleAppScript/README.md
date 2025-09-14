# REST API テスター - Google Apps Script版

## 概要

Google Apps Scriptを使用したREST APIテストツールです。Googleアカウントがあれば無料で利用でき、サーバーレスで動作します。

## 特徴

- ☁️ **クラウドベース** - インストール不要、ブラウザのみで動作
- 🔐 **セキュア** - Google認証による自動的なアクセス制御
- 💰 **無料** - Google Apps Scriptの無料枠で運用可能
- 🚀 **簡単デプロイ** - 数クリックでデプロイ完了
- 📱 **レスポンシブ** - PC・スマートフォン両対応

## ファイル構成

```
GoogleAppScript/
├── Code.gs       # サーバーサイド処理（Apps Script）
├── index.html    # メインHTMLテンプレート
├── styles.html   # CSSスタイルシート
└── README.md     # このファイル
```

## セットアップ手順

### 1. Google Apps Scriptプロジェクトの作成

1. [Google Drive](https://drive.google.com)にアクセス
2. 「新規」→「その他」→「Google Apps Script」を選択
3. プロジェクト名を「REST API Tester」に変更

### 2. ファイルの作成

#### Code.gs（既存ファイルを上書き）
```javascript
// Code.gsの内容をコピー＆ペースト
```

#### index.html の作成
1. ファイル → 新規作成 → HTMLファイル
2. ファイル名を「index」に設定
3. index.htmlの内容をコピー＆ペースト

#### styles.html の作成
1. ファイル → 新規作成 → HTMLファイル
2. ファイル名を「styles」に設定
3. styles.htmlの内容をコピー＆ペースト

### 3. デプロイ

1. デプロイ → 新しいデプロイ
2. 設定：
   - **種類**: ウェブアプリ
   - **説明**: REST API テスター v1.0
   - **次のユーザーとして実行**: 自分
   - **アクセスできるユーザー**: 選択可能
     - 「自分のみ」: 個人利用
     - 「全員」: 公開利用
3. 「デプロイ」をクリック
4. 表示されたURLにアクセス

## 使用方法

### 基本的な使い方

1. **エンドポイント入力**
   ```
   https://jsonplaceholder.typicode.com/posts/1
   ```

2. **HTTPメソッド選択**
   - GET: データ取得
   - POST: データ作成
   - PUT: データ更新
   - DELETE: データ削除
   - PATCH: 部分更新

3. **パラメータ設定**（必要に応じて）
   - Key: パラメータ名
   - Value: パラメータ値

4. **テスト実行**
   - 「テスト実行」ボタンをクリック

### 使用例

#### GETリクエスト
```
エンドポイント: https://api.github.com/users/github
メソッド: GET
パラメータ: なし
```

#### POSTリクエスト
```
エンドポイント: https://jsonplaceholder.typicode.com/posts
メソッド: POST
パラメータ:
  title: "テスト投稿"
  body: "これはテストです"
  userId: "1"
```

## 技術仕様

### サーバーサイド（Code.gs）

- **doGet()**: Webアプリケーションのエントリーポイント
- **include()**: HTMLファイルのインクルード処理
- **makeAPIRequest()**: 外部API呼び出し処理
  - UrlFetchAppを使用
  - タイムアウト: 30秒
  - 自動リダイレクト対応

### クライアントサイド

- **HTML5**: セマンティックマークアップ
- **CSS3**: モダンなスタイリング
- **JavaScript**:
  - google.script.run でサーバー関数呼び出し
  - 非同期処理でUXを向上

## 制限事項

### Google Apps Scriptの制限

| 項目 | 制限値 |
|------|--------|
| スクリプト実行時間 | 6分 |
| URLフェッチサイズ | 50MB |
| URLフェッチ時間 | 60秒 |
| 日次実行時間 | 6時間 |
| 日次URLフェッチ回数 | 20,000回 |

### アプリケーションの制限

- CORS制限により一部APIへの直接アクセス不可
- ファイルアップロード未対応
- WebSocket通信未対応
- 同時実行は1リクエストのみ

## トラブルシューティング

### デプロイURLにアクセスできない

1. デプロイ設定の「アクセスできるユーザー」を確認
2. Googleアカウントでログインしているか確認
3. 組織のセキュリティポリシーを確認

### APIリクエストが失敗する

1. エンドポイントURLが正しいか確認
2. HTTPSを使用しているか確認
3. APIサーバーがCORSを許可しているか確認
4. タイムアウト（60秒）内に応答があるか確認

### レスポンスが文字化けする

- APIのレスポンスがUTF-8でエンコードされているか確認
- Content-Typeヘッダーが正しく設定されているか確認

## カスタマイズ

### スタイルの変更

`styles.html`を編集：

```css
/* カラーテーマの変更 */
body {
  background: linear-gradient(135deg, #あなたの色1 0%, #あなたの色2 100%);
}

/* フォントの変更 */
body {
  font-family: 'あなたのフォント', sans-serif;
}
```

### 機能の追加

`Code.gs`に新しい関数を追加：

```javascript
function myCustomFunction(param) {
  // カスタム処理
  return result;
}
```

`index.html`から呼び出し：

```javascript
google.script.run
  .withSuccessHandler(onSuccess)
  .withFailureHandler(onError)
  .myCustomFunction(param);
```

## セキュリティ

### 推奨事項

1. **アクセス制限**: 必要最小限のユーザーのみにアクセスを許可
2. **APIキー管理**: APIキーは環境変数やプロパティサービスで管理
3. **入力検証**: ユーザー入力は必ず検証
4. **HTTPS使用**: HTTPSエンドポイントのみを使用

### APIキーの安全な管理

```javascript
// PropertiesServiceを使用
function getApiKey() {
  const scriptProperties = PropertiesService.getScriptProperties();
  return scriptProperties.getProperty('API_KEY');
}
```

## よくある質問

### Q: 無料で使えますか？
A: はい、Google Apps Scriptの無料枠内で利用可能です。

### Q: 複数人で使えますか？
A: はい、デプロイ時の設定で共有範囲を指定できます。

### Q: APIキーを使うAPIもテストできますか？
A: はい、パラメータやヘッダーとして設定可能です。

### Q: レスポンスの最大サイズは？
A: Google Apps Scriptの制限により50MBまでです。

## サポート

問題が発生した場合は、以下を確認してください：

1. [Google Apps Script公式ドキュメント](https://developers.google.com/apps-script)
2. [Stack Overflow](https://stackoverflow.com/questions/tagged/google-apps-script)
3. プロジェクトのIssueトラッカー

## ライセンス

MIT License

## 更新履歴

- **v1.0.0** (2025-09-14)
  - 初版リリース
  - 基本的なREST APIテスト機能
  - レスポンシブデザイン対応