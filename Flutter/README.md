# REST API テスター - Flutter版

## 概要

Flutter Webフレームワークを使用したREST APIテストツールです。モダンなUIと高速な動作が特徴で、将来的にはモバイルアプリとしても展開可能です。

## 特徴

- 🎨 **モダンUI** - Material Design 3準拠の美しいインターフェース
- ⚡ **高速動作** - Dartによる高速レンダリング
- 🔄 **リアクティブ** - 状態管理による即座のUI更新
- 📱 **クロスプラットフォーム** - Web/iOS/Android対応可能
- 🛠️ **開発効率** - Hot Reloadによる快適な開発体験

## 必要環境

- Flutter SDK 3.0以上
- Dart SDK 2.17以上
- Chrome ブラウザ（開発用）
- エディタ（VS Code推奨）

## ファイル構成

```
Flutter/
├── lib/
│   ├── main.dart                 # アプリケーションエントリーポイント
│   ├── screens/
│   │   └── api_test_screen.dart  # メイン画面のUI実装
│   └── services/
│       └── api_service.dart      # API通信ロジック
├── web/                          # Web配信用リソース
│   ├── index.html
│   ├── manifest.json
│   └── icons/
├── pubspec.yaml                  # パッケージ依存関係
├── pubspec.lock                  # 依存関係のロックファイル
└── README.md                     # このファイル
```

## セットアップ

### 1. Flutter SDKのインストール

#### Windows
```powershell
# Chocolateyを使用
choco install flutter

# または公式サイトからダウンロード
# https://flutter.dev/docs/get-started/install/windows
```

#### macOS
```bash
# Homebrewを使用
brew install flutter

# または公式サイトからダウンロード
# https://flutter.dev/docs/get-started/install/macos
```

#### Linux
```bash
# snapを使用
sudo snap install flutter --classic

# または公式サイトからダウンロード
# https://flutter.dev/docs/get-started/install/linux
```

### 2. 環境確認

```bash
# Flutter環境の確認
flutter doctor

# 出力例
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.x.x)
[✓] Chrome - develop for the web
[✓] VS Code (version x.x.x)
[✓] Connected device (1 available)
[✓] Network resources
```

### 3. プロジェクトセットアップ

```bash
# プロジェクトディレクトリへ移動
cd Flutter

# 依存関係のインストール
flutter pub get

# Webサポートの有効化（初回のみ）
flutter config --enable-web
```

## 実行方法

### 開発モード

```bash
# デフォルトポートで起動（ランダムポート）
flutter run -d chrome

# ポート指定で起動
flutter run -d chrome --web-port=8080

# ホットリロード有効（デフォルト）
# コード変更時に'r'キーで再読み込み
```

### リリースビルド

```bash
# リリース用ビルド作成
flutter build web --release

# ビルド成果物の場所
# build/web/
```

### デプロイ

```bash
# ビルド成果物をWebサーバーにコピー
cp -r build/web/* /path/to/webserver/

# または、GitHub Pagesを使用
# 1. build/webの内容をgh-pagesブランチにプッシュ
# 2. GitHubのSettings > Pagesで公開設定
```

## 使用方法

### 基本操作

1. **アプリケーション起動**
   ```bash
   flutter run -d chrome --web-port=8080
   ```

2. **ブラウザでアクセス**
   ```
   http://localhost:8080
   ```

3. **APIテスト実行**
   - エンドポイントURL入力
   - HTTPメソッド選択
   - パラメータ設定（必要に応じて）
   - 「テスト実行」ボタンクリック

### テスト例

#### JSONPlaceholder API（GET）
```
エンドポイント: https://jsonplaceholder.typicode.com/posts/1
メソッド: GET
パラメータ: なし
```

#### JSONPlaceholder API（POST）
```
エンドポイント: https://jsonplaceholder.typicode.com/posts
メソッド: POST
パラメータ:
  title: "Flutter Test"
  body: "Testing from Flutter app"
  userId: "1"
```

## 開発ガイド

### プロジェクト構造

#### main.dart
```dart
// アプリケーションのエントリーポイント
void main() {
  runApp(const MyApp());
}
```

#### api_test_screen.dart
- 画面のUI実装
- 状態管理（StatefulWidget）
- ユーザー入力処理

#### api_service.dart
- HTTP通信ロジック
- リクエスト/レスポンス処理
- エラーハンドリング

### 状態管理

現在はStatefulWidgetを使用したシンプルな状態管理：

```dart
setState(() {
  _isLoading = true;
  _response = '';
});
```

将来的な拡張オプション：
- Provider
- Riverpod
- BLoC
- GetX

### HTTPクライアント

`http`パッケージを使用：

```dart
import 'package:http/http.dart' as http;

// GETリクエスト
final response = await http.get(uri, headers: headers);

// POSTリクエスト
final response = await http.post(uri, headers: headers, body: body);
```

## カスタマイズ

### テーマ変更

`main.dart`でテーマをカスタマイズ：

```dart
theme: ThemeData(
  primarySwatch: Colors.blue,  // メインカラー変更
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,    // シードカラー変更
  ),
),
```

### 新機能追加

1. **新しい画面を追加**
```dart
// lib/screens/new_screen.dart
class NewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 画面実装
    );
  }
}
```

2. **ナビゲーション追加**
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => NewScreen()),
);
```

## パフォーマンス最適化

### ビルド最適化

```bash
# Tree shakingとコード最適化
flutter build web --release --tree-shake-icons

# 圧縮とサイズ削減
flutter build web --release --web-renderer html
```

### 画像最適化

```yaml
# pubspec.yaml
flutter:
  assets:
    - assets/images/
```

### レイジーローディング

```dart
// 遅延読み込みの実装
import 'package:flutter/material.dart' deferred as lazy;

Future<void> loadLibrary() async {
  await lazy.loadLibrary();
}
```

## デバッグ

### Flutter DevTools

```bash
# DevToolsの起動
flutter pub global activate devtools
flutter pub global run devtools

# ブラウザで開く
http://localhost:9100
```

### デバッグ機能

- Widget Inspector
- Performance View
- Memory View
- Network View
- Logging View

### コンソールログ

```dart
// デバッグ出力
print('Debug message');
debugPrint('Detailed debug info');

// 条件付きデバッグ
assert(() {
  print('Debug mode only');
  return true;
}());
```

## テスト

### ユニットテスト

```bash
# テスト実行
flutter test

# カバレッジ付きテスト
flutter test --coverage
```

### ウィジェットテスト

```dart
// test/widget_test.dart
testWidgets('Button test', (WidgetTester tester) async {
  await tester.pumpWidget(MyApp());
  expect(find.text('テスト実行'), findsOneWidget);
});
```

## トラブルシューティング

### ビルドエラー

```bash
# キャッシュクリア
flutter clean
flutter pub get
```

### CORS エラー

開発時の回避方法：
```bash
# Chrome起動時にセキュリティ無効化（開発用のみ）
flutter run -d chrome --web-browser-flag "--disable-web-security"
```

### パッケージ競合

```bash
# 依存関係の解決
flutter pub deps
flutter pub upgrade --major-versions
```

## パッケージ依存関係

`pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0           # HTTP通信
  cupertino_icons: ^1.0.6 # アイコン

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0   # Lintルール
```

## ベストプラクティス

1. **コード品質**
   - Lintルールの遵守
   - 適切な型付け
   - nullセーフティの活用

2. **パフォーマンス**
   - const constructorの使用
   - 不要な再ビルドの回避
   - 適切なウィジェット選択

3. **セキュリティ**
   - APIキーの適切な管理
   - 入力値の検証
   - HTTPSの使用

## リソース

- [Flutter公式ドキュメント](https://flutter.dev/docs)
- [Dart言語ツアー](https://dart.dev/guides/language/language-tour)
- [Flutter Gallery](https://gallery.flutter.dev/)
- [pub.dev](https://pub.dev/) - パッケージリポジトリ

## ライセンス

MIT License

## 更新履歴

- **v1.0.0** (2025-09-14)
  - 初版リリース
  - 基本的なREST APIテスト機能
  - Material Design 3対応
  - レスポンシブデザイン実装
