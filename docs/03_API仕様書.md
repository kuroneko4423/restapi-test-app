# API仕様書

## 1. 概要

本ドキュメントは、REST APIテストアプリケーションの内部APIおよび外部API連携に関する仕様を定義します。

## 2. 内部API仕様

### 2.1 Spring Boot版 内部API

#### 2.1.1 APIテスト実行エンドポイント

**エンドポイント**: `/api/test`

**メソッド**: `POST`

**説明**: 指定されたエンドポイントに対してHTTPリクエストを送信し、結果を返す

**リクエストヘッダー**:
```
Content-Type: application/json
```

**リクエストボディ**:
```json
{
  "endpoint": "string",     // 必須: テスト対象のAPIエンドポイントURL
  "method": "string",       // 必須: HTTPメソッド (GET/POST/PUT/DELETE/PATCH)
  "parameters": {           // オプション: リクエストパラメータ
    "key1": "value1",
    "key2": "value2"
  }
}
```

**レスポンス形式**:
```json
{
  "success": boolean,       // リクエストの成功/失敗
  "statusCode": number,     // HTTPステータスコード
  "headers": {              // レスポンスヘッダー
    "header1": "value1",
    "header2": "value2"
  },
  "body": "string",        // レスポンスボディ（整形済み）
  "error": "string"        // エラー時のみ: エラーメッセージ
}
```

**ステータスコード**:
- `200 OK`: 正常処理完了
- `400 Bad Request`: 不正なリクエストパラメータ
- `500 Internal Server Error`: サーバー内部エラー

### 2.2 Google Apps Script版 関数仕様

#### 2.2.1 makeAPIRequest関数

**シグネチャ**:
```javascript
function makeAPIRequest(endpoint, method, parameters)
```

**パラメータ**:
- `endpoint` (string): テスト対象のAPIエンドポイントURL
- `method` (string): HTTPメソッド
- `parameters` (object): リクエストパラメータ

**戻り値**:
```javascript
{
  statusCode: number,      // HTTPステータスコード
  headers: object,         // レスポンスヘッダー
  body: string,           // レスポンスボディ（整形済み）
  error: string           // エラー時のみ
}
```

### 2.3 Flutter版 サービス仕様

#### 2.3.1 ApiService.makeApiRequest

**シグネチャ**:
```dart
static Future<Map<String, dynamic>> makeApiRequest({
  required String endpoint,
  required String method,
  required Map<String, String> parameters,
})
```

**パラメータ**:
- `endpoint`: テスト対象のAPIエンドポイントURL
- `method`: HTTPメソッド
- `parameters`: リクエストパラメータ

**戻り値**:
```dart
{
  'success': bool,
  'statusCode': int,
  'headers': Map<String, String>,
  'body': String,
  'error': String  // エラー時のみ
}
```

## 3. 外部API連携仕様

### 3.1 HTTPメソッド別処理

#### 3.1.1 GETメソッド
- パラメータをクエリストリングとして付加
- URLエンコーディング実施
- Content-Typeヘッダー不要

**例**:
```
GET https://api.example.com/users?name=John&age=30
```

#### 3.1.2 POST/PUT/PATCHメソッド
- パラメータをJSONボディとして送信
- Content-Type: application/json設定
- JSONシリアライズ実施

**例**:
```
POST https://api.example.com/users
Content-Type: application/json

{
  "name": "John",
  "age": 30
}
```

#### 3.1.3 DELETEメソッド
- オプションでJSONボディ送信可能
- パラメータがある場合はContent-Type設定

### 3.2 共通ヘッダー

すべてのリクエストに以下のヘッダーを付加:

```
Accept: application/json
User-Agent: REST-API-Tester/1.0
```

### 3.3 レスポンス処理

#### 3.3.1 JSON整形
- JSONレスポンスを自動検出
- インデント付きで整形（2スペース）
- 構文エラー時は元のテキストを表示

#### 3.3.2 エラーハンドリング

| エラー種別 | 処理内容 |
|-----------|---------|
| ネットワークエラー | エラーメッセージを表示、success: false |
| タイムアウト | タイムアウトメッセージ表示、success: false |
| HTTPエラー（4xx, 5xx） | ステータスコードとレスポンスボディを表示 |
| 不正なJSON | 元のレスポンステキストを表示 |

### 3.4 制限事項

#### 3.4.1 タイムアウト設定
- デフォルト: 30秒
- 最大: 60秒

#### 3.4.2 レスポンスサイズ
- 最大: 10MB
- 超過時はエラーメッセージ表示

#### 3.4.3 リダイレクト
- 自動追従: 最大5回
- HTTPSへの自動アップグレード対応

## 4. セキュリティ考慮事項

### 4.1 入力検証
- URLフォーマット検証
- SQLインジェクション対策
- XSS対策（HTMLエスケープ）

### 4.2 通信セキュリティ
- HTTPS推奨
- 証明書検証実施
- セキュアヘッダーの適用

### 4.3 認証・認可
現バージョンでは認証機能は未実装。将来的に以下をサポート予定:
- Bearer Token
- API Key
- OAuth 2.0
- Basic認証

## 5. エラーコード一覧

| コード | 説明 | 対処法 |
|--------|------|--------|
| ERR001 | エンドポイント未入力 | エンドポイントURLを入力してください |
| ERR002 | 不正なURL形式 | 正しいURL形式で入力してください |
| ERR003 | ネットワークエラー | ネットワーク接続を確認してください |
| ERR004 | タイムアウト | 時間をおいて再試行してください |
| ERR005 | CORS エラー | サーバー側のCORS設定を確認してください |
| ERR006 | レスポンスサイズ超過 | より小さいデータで試してください |
| ERR007 | 不正なHTTPメソッド | サポートされているメソッドを使用してください |

## 6. 使用例

### 6.1 GETリクエストの例

**リクエスト**:
```json
{
  "endpoint": "https://jsonplaceholder.typicode.com/users/1",
  "method": "GET",
  "parameters": {}
}
```

**レスポンス**:
```json
{
  "success": true,
  "statusCode": 200,
  "headers": {
    "content-type": "application/json; charset=utf-8"
  },
  "body": "{\n  \"id\": 1,\n  \"name\": \"Leanne Graham\",\n  ...\n}"
}
```

### 6.2 POSTリクエストの例

**リクエスト**:
```json
{
  "endpoint": "https://jsonplaceholder.typicode.com/posts",
  "method": "POST",
  "parameters": {
    "title": "Test Post",
    "body": "This is a test post",
    "userId": "1"
  }
}
```

**レスポンス**:
```json
{
  "success": true,
  "statusCode": 201,
  "headers": {
    "content-type": "application/json; charset=utf-8"
  },
  "body": "{\n  \"title\": \"Test Post\",\n  \"body\": \"This is a test post\",\n  \"userId\": \"1\",\n  \"id\": 101\n}"
}
```