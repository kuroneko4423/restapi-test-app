# REST API テストアプリケーション

## 概要

REST APIテストアプリケーションは、様々なREST APIエンドポイントに対してHTTPリクエストを送信し、レスポンスを確認できるWebベースのテストツールです。Google Apps Script、Flutter、Spring Bootの3つの異なる技術スタックで実装されています。

## 機能

- 🔧 任意のREST APIエンドポイントへのリクエスト送信
- 📝 複数のHTTPメソッドサポート（GET/POST/PUT/DELETE/PATCH）
- 🔑 動的なKey-Valueパラメータ設定
- 📊 レスポンスの詳細表示（ステータスコード、ヘッダー、ボディ）
- 🎨 JSON自動整形機能
- 📱 レスポンシブデザイン

## プロジェクト構成

```
restapi-test-app/
├── docs/                           # 設計書・ドキュメント
│   ├── 01_システムアーキテクチャ設計書.md
│   ├── 02_機能仕様書.md
│   ├── 03_API仕様書.md
│   ├── 04_画面設計書.md
│   └── README.md
│
├── GoogleAppScript/                # Google Apps Script版
│   ├── Code.gs                    # サーバーサイド処理
│   ├── index.html                 # HTMLテンプレート
│   └── styles.html                # スタイルシート
│
├── Flutter/                        # Flutter Web版
│   ├── lib/
│   │   ├── main.dart              # エントリーポイント
│   │   ├── screens/
│   │   │   └── api_test_screen.dart
│   │   └── services/
│   │       └── api_service.dart
│   ├── web/                       # Web配信用リソース
│   └── pubspec.yaml               # 依存関係定義
│
└── Springboot/                     # Spring Boot版
    ├── build.gradle               # ビルド設定
    ├── settings.gradle
    └── src/main/
        ├── java/com/example/restapitester/
        │   ├── RestApiTesterApplication.java
        │   ├── controller/
        │   │   ├── HomeController.java
        │   │   └── ApiTestController.java
        │   └── service/
        │       └── ApiTestService.java
        └── resources/
            ├── application.properties
            ├── templates/
            │   └── index.html
            └── static/
                ├── css/style.css
                └── js/app.js
```

## セットアップ・実行方法

### Google Apps Script版

1. Google Driveで新規作成 > その他 > Google Apps Script
2. プロジェクトに以下のファイルを作成:
   - `Code.gs` - デフォルトファイルに内容をコピー
   - `index.html` - 新規HTMLファイルとして作成
   - `styles.html` - 新規HTMLファイルとして作成
3. デプロイ > 新しいデプロイ
4. 種類: ウェブアプリ
5. アクセスできるユーザーを設定してデプロイ

### Flutter版

#### 前提条件
- Flutter SDK 3.0以上
- Chrome ブラウザ

#### 実行手順
```bash
cd Flutter
flutter pub get
flutter run -d chrome --web-port=8080
```

アプリケーションは http://localhost:8080 で起動します。

### Spring Boot版

#### 前提条件
- Java 17以上
- Gradle 7.0以上

#### 実行手順

Windows:
```bash
cd Springboot
gradlew.bat bootRun
```

Mac/Linux:
```bash
cd Springboot
./gradlew bootRun
```

アプリケーションは http://localhost:8081 で起動します。

## 使用方法

1. **エンドポイント入力**
   - テスト対象のAPIエンドポイントURLを入力

2. **HTTPメソッド選択**
   - ドロップダウンから適切なメソッドを選択

3. **パラメータ設定**
   - Key-Value形式でパラメータを入力
   - 「パラメータを追加」ボタンで行を追加
   - 「削除」ボタンで不要な行を削除

4. **テスト実行**
   - 「テスト実行」ボタンをクリック

5. **結果確認**
   - ステータスコード、ヘッダー、レスポンスボディを確認

## 技術仕様

### Google Apps Script版
- **実行環境**: Google Cloud Platform
- **言語**: JavaScript (ES6)
- **API通信**: UrlFetchApp
- **UI**: HTML5 + CSS3 + Vanilla JavaScript

### Flutter版
- **フレームワーク**: Flutter 3.0+
- **言語**: Dart
- **HTTPクライアント**: http package
- **UIライブラリ**: Material Design 3

### Spring Boot版
- **フレームワーク**: Spring Boot 3.2.0
- **言語**: Java 17
- **ビルドツール**: Gradle
- **HTTPクライアント**: WebClient (Spring WebFlux)
- **テンプレートエンジン**: Thymeleaf
- **フロントエンド**: HTML5 + CSS3 + JavaScript

## 制限事項

- CORS制限により、一部のAPIへの直接アクセスが制限される場合があります
- ファイルアップロード機能は未対応
- WebSocket通信は未対応
- 認証機能（OAuth、API Key等）は現バージョンでは未実装

## トラブルシューティング

### CORS エラーが発生する場合
- ブラウザのセキュリティポリシーにより、異なるドメインへの直接アクセスが制限されています
- サーバーサイドプロキシの使用を検討してください
- Chrome拡張機能（CORS Unblock等）の使用も可能ですが、セキュリティリスクに注意してください

### Flutter版が起動しない場合
```bash
flutter doctor
```
を実行して、環境設定を確認してください。

### Spring Boot版が起動しない場合
- Java 17がインストールされているか確認
- ポート8081が使用されていないか確認
- ファイアウォール設定を確認

## ライセンス

MIT License

## 作成者

Kuroneko4423

## 更新履歴

- 2025-09-14: 初版リリース
  - Google Apps Script版実装
  - Flutter版実装
  - Spring Boot版実装
  - ドキュメント作成