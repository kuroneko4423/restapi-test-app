# REST API Test Application Suite

## 🌟 概要

REST APIテストアプリケーションスイートは、様々な技術スタックで実装された包括的なAPIテストツールコレクションです。Google Apps Script、Flutter、Spring Bootの3つの異なるアプローチで同一機能を実装し、各技術の特性を活かした最適なソリューションを提供します。

## 🎯 プロジェクトの目的

- **技術比較**: 異なる技術スタックでの実装を通じた学習と比較
- **最適解の選択**: 用途に応じた最適な実装の選択肢を提供
- **実践的ツール**: 実際の開発現場で使用可能なAPIテストツール
- **教育的価値**: 各技術の特徴と実装パターンの理解

## 📁 プロジェクト構成

```
restapi-test-app/
│
├── 📚 docs/                        # プロジェクト全体のドキュメント
│   ├── 01_システムアーキテクチャ設計書.md
│   ├── 02_機能仕様書.md
│   ├── 03_API仕様書.md
│   ├── 04_画面設計書.md
│   └── README.md
│
├── ☁️ GoogleAppScript/             # Google Apps Script実装
│   ├── Code.gs
│   ├── index.html
│   ├── styles.html
│   └── README.md
│
├── 🎨 Flutter/                     # Flutter Web実装
│   ├── lib/
│   ├── web/
│   ├── pubspec.yaml
│   └── README.md
│
├── 🏢 Springboot/                  # Spring Boot実装
│   ├── src/
│   ├── build.gradle
│   └── README.md
│
└── 📖 README.md                    # このファイル
```

## 🚀 実装バリエーション

### 比較表

| 特性 | Google Apps Script | Flutter | Spring Boot |
|-----|-------------------|---------|-------------|
| **プラットフォーム** | クラウド (Google) | Web/Mobile | サーバー/クラウド |
| **言語** | JavaScript | Dart | Java |
| **必要環境** | Googleアカウントのみ | Flutter SDK | JDK 17+ |
| **デプロイ** | ワンクリック | ビルド＆配信 | JAR/Docker |
| **スケーラビリティ** | Google制限内 | クライアント依存 | 高 |
| **コスト** | 無料 | ホスティング費用 | サーバー費用 |
| **適用場面** | 個人/小規模 | モダンUI重視 | エンタープライズ |

### 各実装の特徴

#### ☁️ Google Apps Script版
- **メリット**:
  - インフラ不要、即座に利用可能
  - Google認証による自動セキュリティ
  - 完全無料で運用可能
- **デメリット**:
  - 実行時間制限（6分）
  - Google環境に依存
- **推奨用途**: 個人利用、プロトタイプ、小規模チーム

#### 🎨 Flutter版
- **メリット**:
  - 美しいマテリアルデザイン
  - クロスプラットフォーム対応
  - 高速なレンダリング
- **デメリット**:
  - ビルド・デプロイが必要
  - Flutter SDKの学習コスト
- **推奨用途**: モダンUIが必要な場合、モバイル展開予定

#### 🏢 Spring Boot版
- **メリット**:
  - エンタープライズレベルの信頼性
  - 豊富な拡張機能
  - 高度なカスタマイズ性
- **デメリット**:
  - Java環境が必要
  - リソース消費が大きい
- **推奨用途**: 企業利用、大規模システム、CI/CD統合

## 🎮 クイックスタート

### 最速で試したい場合 → Google Apps Script版

```
1. Google Driveを開く
2. 新規 → その他 → Google Apps Script
3. ファイルをコピー＆ペースト
4. デプロイ → 完了！
```

### ローカルで開発したい場合 → Flutter版

```bash
cd Flutter
flutter pub get
flutter run -d chrome --web-port=8080
```

### 本格的に運用したい場合 → Spring Boot版

```bash
cd Springboot
./gradlew bootRun
# http://localhost:8081 でアクセス
```

## 📋 共通機能

すべての実装で以下の機能を提供：

- ✅ 任意のREST APIエンドポイントへのリクエスト送信
- ✅ 5つのHTTPメソッド対応（GET/POST/PUT/DELETE/PATCH）
- ✅ 動的なKey-Valueパラメータ設定
- ✅ レスポンスの詳細表示
- ✅ JSON自動整形
- ✅ エラーハンドリング
- ✅ レスポンシブデザイン

## 🛠️ 開発環境セットアップ

### 必要なツール

| ツール | バージョン | 用途 | 必須/推奨 |
|--------|-----------|------|----------|
| Git | 最新 | バージョン管理 | 必須 |
| VS Code | 最新 | エディタ | 推奨 |
| Node.js | 14+ | 開発ツール | 推奨 |
| Java | 17+ | Spring Boot用 | Spring Boot使用時 |
| Flutter | 3.0+ | Flutter用 | Flutter使用時 |

### 全プロジェクトのクローン

```bash
git clone https://github.com/yourusername/restapi-test-app.git
cd restapi-test-app
```

## 📊 パフォーマンス指標

| 指標 | Google Apps Script | Flutter | Spring Boot |
|------|-------------------|---------|-------------|
| 起動時間 | 即座 | 2-3秒 | 5-10秒 |
| レスポンス速度 | 中 | 高 | 高 |
| 同時接続数 | 制限あり | ブラウザ依存 | 高 |
| メモリ使用量 | N/A | 低-中 | 中-高 |
| CPU使用率 | N/A | 低 | 中 |

## 🔒 セキュリティ考慮事項

### 共通の注意点
- HTTPSエンドポイントの使用を推奨
- APIキーは環境変数で管理
- 入力値の検証を実施
- CORSポリシーの理解と対応

### 実装別の対策
- **Google Apps Script**: Googleアカウント認証で保護
- **Flutter**: クライアントサイドのため機密情報は扱わない
- **Spring Boot**: Spring Securityで認証・認可を実装可能

## 📚 ドキュメント

詳細なドキュメントは`docs/`ディレクトリを参照：

- [システムアーキテクチャ設計書](docs/01_システムアーキテクチャ設計書.md)
- [機能仕様書](docs/02_機能仕様書.md)
- [API仕様書](docs/03_API仕様書.md)
- [画面設計書](docs/04_画面設計書.md)

各実装の詳細：

- [Google Apps Script版 README](GoogleAppScript/README.md)
- [Flutter版 README](Flutter/README.md)
- [Spring Boot版 README](Springboot/README.md)

## 🤝 コントリビューション

### 貢献方法

1. このリポジトリをFork
2. Feature branchを作成 (`git checkout -b feature/AmazingFeature`)
3. 変更をCommit (`git commit -m 'Add some AmazingFeature'`)
4. Branchにプッシュ (`git push origin feature/AmazingFeature`)
5. Pull Requestを作成

### 開発ガイドライン

- コードスタイルは各技術のベストプラクティスに従う
- テストコードの追加を推奨
- ドキュメントの更新を忘れずに
- コミットメッセージは明確に

## 🐛 既知の問題

- CORS制限により一部のAPIにアクセスできない場合がある
- Google Apps Script版は実行時間制限（6分）がある
- Flutter版はWebプラットフォームのみ対応（現時点）

## 📈 今後の拡張予定

- [ ] 認証機能の追加（OAuth, JWT）
- [ ] リクエスト履歴の保存機能
- [ ] レスポンスの比較機能
- [ ] 自動テスト機能
- [ ] WebSocket対応
- [ ] GraphQL対応
- [ ] React版の追加
- [ ] Python (FastAPI)版の追加

## 📝 ライセンス

このプロジェクトはMIT Licenseの下で公開されています。詳細は[LICENSE](LICENSE)ファイルを参照してください。

## 👥 作成者

**Kuroneko4423**

- GitHub: [@kuroneko4423](https://github.com/kuroneko4423)

## 🙏 謝辞

- [Google Apps Script Team](https://developers.google.com/apps-script)
- [Flutter Team](https://flutter.dev/)
- [Spring Boot Team](https://spring.io/projects/spring-boot)
- すべてのオープンソースコントリビューター

## 📅 更新履歴

### v1.0.0 (2025-09-14)
- 🎉 初版リリース
- ✨ 3つの技術スタックでの実装完了
- 📚 包括的なドキュメント作成
- 🎨 統一されたUIデザイン実装

---

<div align="center">

**Choose Your Fighter! 🎮**

Google Apps Script ☁️ | Flutter 🎨 | Spring Boot 🏢

*あなたのニーズに最適な実装を選択してください*

</div>