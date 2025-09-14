# REST API テスター - Spring Boot版

## 概要

Spring Boot 3とGradleを使用したエンタープライズグレードのREST APIテストツールです。WebClientによる非同期通信とThymeleafテンプレートエンジンを採用し、高性能で拡張性の高いアプリケーションを実現しています。

## 特徴

- 🚀 **高性能** - Spring WebFluxのWebClientによる非同期処理
- 🏢 **エンタープライズ対応** - Spring Bootの豊富なエコシステム
- 🔧 **拡張性** - DIコンテナによる柔軟な設計
- 📊 **モニタリング** - Spring Boot Actuator対応可能
- 🔐 **セキュリティ** - Spring Security統合可能
- 🐳 **コンテナ対応** - Dockerイメージ作成可能

## 必要環境

- Java 17以上
- Gradle 7.0以上（Wrapperを使用する場合は不要）
- メモリ: 最小256MB、推奨512MB以上
- ポート: 8081（デフォルト）

## ファイル構成

```
Springboot/
├── build.gradle                      # Gradle ビルド設定
├── settings.gradle                   # プロジェクト設定
├── gradlew                          # Gradle Wrapper (Unix/Mac)
├── gradlew.bat                      # Gradle Wrapper (Windows)
├── src/
│   └── main/
│       ├── java/
│       │   └── com/example/restapitester/
│       │       ├── RestApiTesterApplication.java    # メインクラス
│       │       ├── controller/
│       │       │   ├── HomeController.java         # 画面表示
│       │       │   └── ApiTestController.java      # API処理
│       │       └── service/
│       │           └── ApiTestService.java         # ビジネスロジック
│       └── resources/
│           ├── application.properties              # アプリケーション設定
│           ├── templates/
│           │   └── index.html                      # Thymeleafテンプレート
│           └── static/
│               ├── css/
│               │   └── style.css                   # スタイルシート
│               └── js/
│                   └── app.js                      # JavaScriptロジック
└── README.md                                       # このファイル
```

## セットアップ

### 1. Java環境の確認

```bash
# Javaバージョン確認
java -version

# 出力例
openjdk version "17.0.2" 2022-01-18
OpenJDK Runtime Environment (build 17.0.2+8-86)
OpenJDK 64-Bit Server VM (build 17.0.2+8-86, mixed mode, sharing)
```

### 2. Javaのインストール（必要な場合）

#### Windows
```powershell
# Chocolateyを使用
choco install openjdk17

# または公式サイトからダウンロード
# https://adoptium.net/
```

#### macOS
```bash
# Homebrewを使用
brew install openjdk@17

# パスを設定
echo 'export PATH="/usr/local/opt/openjdk@17/bin:$PATH"' >> ~/.zshrc
```

#### Linux
```bash
# apt (Ubuntu/Debian)
sudo apt update
sudo apt install openjdk-17-jdk

# yum (CentOS/RHEL)
sudo yum install java-17-openjdk-devel
```

## 実行方法

### 開発モード

#### Windows
```cmd
cd Springboot

# Gradle Wrapperを使用
gradlew.bat bootRun

# または、Gradleがインストール済みの場合
gradle bootRun
```

#### Mac/Linux
```bash
cd Springboot

# Gradle Wrapperを使用
./gradlew bootRun

# または、Gradleがインストール済みの場合
gradle bootRun
```

アプリケーションは http://localhost:8081 で起動します。

### プロダクションビルド

```bash
# JARファイルの作成
./gradlew build

# JARファイルの実行
java -jar build/libs/restapitester-0.0.1-SNAPSHOT.jar
```

### Dockerコンテナとして実行

```dockerfile
# Dockerfile を作成
FROM openjdk:17-jdk-slim
COPY build/libs/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
```

```bash
# Dockerイメージのビルド
docker build -t rest-api-tester .

# コンテナの実行
docker run -p 8081:8081 rest-api-tester
```

## 使用方法

### 基本操作

1. **アプリケーション起動**
   ```bash
   ./gradlew bootRun
   ```

2. **ブラウザでアクセス**
   ```
   http://localhost:8081
   ```

3. **APIテスト実行**
   - エンドポイントURL入力
   - HTTPメソッド選択
   - パラメータ設定（Key-Value形式）
   - 「テスト実行」ボタンクリック

### テスト例

#### Public API（GET）
```
エンドポイント: https://api.publicapis.org/entries
メソッド: GET
パラメータ:
  category: Development
```

#### JSONPlaceholder（POST）
```
エンドポイント: https://jsonplaceholder.typicode.com/posts
メソッド: POST
パラメータ:
  title: "Spring Boot Test"
  body: "Testing from Spring Boot"
  userId: "1"
```

## 設定カスタマイズ

### application.properties

```properties
# サーバー設定
server.port=8081
server.servlet.context-path=/api-tester

# Thymeleaf設定
spring.thymeleaf.cache=false
spring.thymeleaf.mode=HTML
spring.thymeleaf.encoding=UTF-8

# ログレベル設定
logging.level.root=INFO
logging.level.com.example.restapitester=DEBUG

# WebClient設定
spring.codec.max-in-memory-size=10MB

# アクチュエーター設定（オプション）
management.endpoints.web.exposure.include=health,info,metrics
```

### ポート変更

```bash
# コマンドライン引数で指定
java -jar app.jar --server.port=9090

# 環境変数で指定
export SERVER_PORT=9090
./gradlew bootRun
```

## 開発ガイド

### プロジェクト構造

#### アーキテクチャ
```
Controller層 (REST API & MVC)
    ↓
Service層 (ビジネスロジック)
    ↓
WebClient (外部API通信)
```

#### 主要コンポーネント

**RestApiTesterApplication.java**
```java
@SpringBootApplication
public class RestApiTesterApplication {
    public static void main(String[] args) {
        SpringApplication.run(RestApiTesterApplication.class, args);
    }
}
```

**ApiTestService.java**
- WebClientによる非同期HTTP通信
- JSONの整形処理
- エラーハンドリング

**ApiTestController.java**
- RESTエンドポイント定義
- リクエスト/レスポンス処理

### 新機能の追加

#### 1. 新しいエンドポイント追加

```java
@RestController
@RequestMapping("/api/v2")
public class NewApiController {

    @PostMapping("/advanced-test")
    public ResponseEntity<?> advancedTest(@RequestBody Map<String, Object> request) {
        // 実装
        return ResponseEntity.ok(result);
    }
}
```

#### 2. サービスクラスの追加

```java
@Service
public class CustomService {

    public Map<String, Object> processRequest(String data) {
        // ビジネスロジック
        return result;
    }
}
```

### テスト

#### ユニットテスト実行

```bash
./gradlew test
```

#### 統合テスト

```java
@SpringBootTest
@AutoConfigureMockMvc
class ApiTestControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void testApiEndpoint() throws Exception {
        mockMvc.perform(post("/api/test")
                .contentType(MediaType.APPLICATION_JSON)
                .content("{...}"))
                .andExpect(status().isOk());
    }
}
```

## パフォーマンスチューニング

### JVMオプション

```bash
# メモリ設定
java -Xms256m -Xmx512m -jar app.jar

# GC最適化
java -XX:+UseG1GC -XX:MaxGCPauseMillis=100 -jar app.jar
```

### WebClient設定

```java
@Configuration
public class WebClientConfig {

    @Bean
    public WebClient webClient() {
        return WebClient.builder()
            .codecs(configurer -> configurer
                .defaultCodecs()
                .maxInMemorySize(10 * 1024 * 1024))
            .clientConnector(new ReactorClientHttpConnector(
                HttpClient.create()
                    .responseTimeout(Duration.ofSeconds(30))
            ))
            .build();
    }
}
```

## モニタリング

### Spring Boot Actuator

```gradle
// build.gradle に追加
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-actuator'
}
```

アクセスURL:
- ヘルスチェック: http://localhost:8081/actuator/health
- メトリクス: http://localhost:8081/actuator/metrics
- 情報: http://localhost:8081/actuator/info

## トラブルシューティング

### ポートが既に使用されている

```bash
# ポート確認 (Windows)
netstat -ano | findstr :8081

# ポート確認 (Mac/Linux)
lsof -i :8081

# 別のポートで起動
./gradlew bootRun --args='--server.port=8082'
```

### OutOfMemoryError

```bash
# ヒープサイズを増やす
export JAVA_OPTS="-Xmx1024m"
./gradlew bootRun
```

### ビルドエラー

```bash
# クリーンビルド
./gradlew clean build

# 依存関係の更新
./gradlew --refresh-dependencies
```

### CORS エラー

```java
// CORSの設定追加
@Configuration
public class CorsConfig {

    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/**")
                    .allowedOrigins("*")
                    .allowedMethods("*");
            }
        };
    }
}
```

## プロダクション展開

### システム要件

- **CPU**: 2コア以上推奨
- **メモリ**: 512MB以上推奨
- **ディスク**: 100MB以上
- **OS**: Linux/Windows/macOS

### セキュリティ設定

```properties
# HTTPS有効化
server.ssl.key-store=classpath:keystore.p12
server.ssl.key-store-password=password
server.ssl.key-store-type=PKCS12
server.ssl.key-alias=tomcat

# セキュリティヘッダー
server.servlet.session.cookie.http-only=true
server.servlet.session.cookie.secure=true
```

### ロギング設定

```xml
<!-- logback-spring.xml -->
<configuration>
    <appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>logs/application.log</file>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <fileNamePattern>logs/application.%d{yyyy-MM-dd}.log</fileNamePattern>
            <maxHistory>30</maxHistory>
        </rollingPolicy>
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>

    <root level="INFO">
        <appender-ref ref="FILE" />
    </root>
</configuration>
```

## 依存関係

主要な依存関係（build.gradle）:

```gradle
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springframework.boot:spring-boot-starter-thymeleaf'
    implementation 'org.springframework.boot:spring-boot-starter-webflux'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}
```

## リソース

- [Spring Boot公式ドキュメント](https://spring.io/projects/spring-boot)
- [Spring WebFlux](https://docs.spring.io/spring-framework/docs/current/reference/html/web-reactive.html)
- [Thymeleaf](https://www.thymeleaf.org/)
- [Gradle](https://gradle.org/)

## ライセンス

MIT License

## 更新履歴

- **v1.0.0** (2025-09-14)
  - 初版リリース
  - WebClientによる非同期通信実装
  - Thymeleafテンプレートエンジン採用
  - レスポンシブデザイン対応