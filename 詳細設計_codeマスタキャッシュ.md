以下では、**jOOQ** を用いてDBから `M_CODE` テーブルを取得し、**ConcurrentMap** でキャッシュを保持する仕組みを示します。さらに、**範囲指定でリロード**（部分的な再読み込み）を行う例も解説します。  

---

# **1. 前提**

1. **テーブル構造 (M_CODE)**  
   ```sql
   CREATE TABLE M_CODE (
       code_category   VARCHAR(50)  NOT NULL,
       code_division   VARCHAR(50)  NOT NULL,
       code            VARCHAR(50)  NOT NULL,
       code_name       VARCHAR(100) NOT NULL,
       code_short_name VARCHAR(50),

       extension1      VARCHAR(100),
       extension2      VARCHAR(100),
       ...
       extension10     VARCHAR(100),

       created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
       updated_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

       CONSTRAINT PK_M_CODE PRIMARY KEY (code_category, code_division, code)
   );
   ```
2. **開発環境**: Kotlin + Spring Boot + jOOQ。  
3. **Spring Boot** 上で**アプリ起動時にキャッシュを全件読み込み**し、**ConcurrentMap** に保存。  
4. **範囲指定でリロード**：たとえば **`updated_at` が最新のものだけ取得**して差分更新、あるいは**特定のcode_categoryだけ**再取得するなどの方針を例示。  

---

# **2. jOOQを使ったRepositoryの設計例**

## 2-1. **jOOQ DSLContext** の注入

Spring Bootで jOOQ を使用する場合、**`org.jooq.DSLContext`** がBeanとして注入可能。  
```kotlin
import org.jooq.DSLContext
import org.springframework.stereotype.Repository

@Repository
class MCodeRepository(
    private val dsl: DSLContext
) {
    // CRUDメソッドなどを定義
}
```

## 2-2. **全件取得**メソッド例

```kotlin
fun findAll(): List<MCodeRecord> {
    // M_CODE テーブルは jOOQが自動生成したテーブルクラスを想定 (例: M_CODE_ など)
    return dsl.selectFrom(M_CODE_)
        .fetchInto(MCodeRecord::class.java)
}
```
> - ここで `M_CODE_` は jOOQ code-generator が生成するテーブル定数と仮定。  
> - `MCodeRecord` は自動生成のRecordクラス、またはDTOクラスをマッピング。  

## 2-3. **部分取得**（例: `updated_at` 範囲指定）

```kotlin
fun findByUpdatedAtAfter(lastUpdatedAt: LocalDateTime): List<MCodeRecord> {
    return dsl.selectFrom(M_CODE_)
        .where(M_CODE_.UPDATED_AT.gt(lastUpdatedAt))
        .fetchInto(MCodeRecord::class.java)
}
```
> - これにより、**範囲指定**( `updated_at > lastUpdatedAt` ) で**差分**を取得できる。

## 2-4. **カテゴリ限定**の再取得

```kotlin
fun findByCodeCategory(category: String): List<MCodeRecord> {
    return dsl.selectFrom(M_CODE_)
        .where(M_CODE_.CODE_CATEGORY.eq(category))
        .fetchInto(MCodeRecord::class.java)
}
```
> - コードカテゴリ単位の部分的リロードに対応。

---

# **3. キャッシュキーとキャッシュエントリ**

## 3-1. **キャッシュキー (MCodeKey)**  
```kotlin
data class MCodeKey(
    val codeCategory: String,
    val codeDivision: String,
    val code: String
)
```

## 3-2. **キャッシュエントリ (MCodeEntry)**  
```kotlin
data class MCodeEntry(
    val codeCategory: String,
    val codeDivision: String,
    val code: String,
    val codeName: String,
    val codeShortName: String?,
    val extension1: String?,
    val extension2: String?,
    // ...
    val extension10: String?,
    val updatedAt: LocalDateTime // 差分更新用に保持
)
```

---

# **4. ConcurrentMapを使ったキャッシュサービス**

## 4-1. **サービスのインターフェース例**

```kotlin
interface MCodeCacheService {
    fun loadAll()
    fun partialReloadByUpdatedAt(since: LocalDateTime)
    fun reloadByCategory(category: String)

    fun get(codeCategory: String, codeDivision: String, code: String): MCodeEntry?
    fun getByCategoryAndDivision(category: String, division: String): List<MCodeEntry>
}
```

## 4-2. **実装: MCodeCacheServiceImpl**

```kotlin
import java.time.LocalDateTime
import java.util.concurrent.ConcurrentHashMap
import org.springframework.stereotype.Service
import javax.annotation.PostConstruct

@Service
class MCodeCacheServiceImpl(
    private val mCodeRepository: MCodeRepository
) : MCodeCacheService {

    private val cache: ConcurrentHashMap<MCodeKey, MCodeEntry> = ConcurrentHashMap()

    // アプリ起動時に全件ロード
    @PostConstruct
    override fun loadAll() {
        val records = mCodeRepository.findAll()  // jOOQで全件SELECT
        val tempMap = ConcurrentHashMap<MCodeKey, MCodeEntry>()
        records.forEach { record ->
            val key = MCodeKey(
                codeCategory = record.codeCategory,
                codeDivision = record.codeDivision,
                code = record.code
            )
            val entry = MCodeEntry(
                codeCategory = record.codeCategory,
                codeDivision = record.codeDivision,
                code = record.code,
                codeName = record.codeName,
                codeShortName = record.codeShortName,
                extension1 = record.extension1,
                extension2 = record.extension2,
                // ...
                extension10 = record.extension10,
                updatedAt = record.updatedAt ?: LocalDateTime.MIN
            )
            tempMap[key] = entry
        }
        // 全体置き換え
        cache.clear()
        cache.putAll(tempMap)
    }

    // 差分更新: updated_at > since で取得してキャッシュ更新
    override fun partialReloadByUpdatedAt(since: LocalDateTime) {
        val changedRecords = mCodeRepository.findByUpdatedAtAfter(since)
        changedRecords.forEach { record ->
            val key = MCodeKey(record.codeCategory, record.codeDivision, record.code)
            val entry = MCodeEntry(
                codeCategory = record.codeCategory,
                codeDivision = record.codeDivision,
                code = record.code,
                codeName = record.codeName,
                codeShortName = record.codeShortName,
                extension1 = record.extension1,
                extension2 = record.extension2,
                // ...
                extension10 = record.extension10,
                updatedAt = record.updatedAt ?: LocalDateTime.MIN
            )
            // キャッシュ更新または新規追加
            cache[key] = entry
        }
        // 差分で削除されたデータを反映するなら、
        // "DELETE_FLAG"や"updated_at"から検知する仕組みを追加検討
    }

    // 特定カテゴリのみ再取得
    override fun reloadByCategory(category: String) {
        val records = mCodeRepository.findByCodeCategory(category)
        // カテゴリにマッチする既存エントリを削除
        cache.entries.removeIf { it.key.codeCategory == category }

        // 新たに追加
        records.forEach { record ->
            val key = MCodeKey(record.codeCategory, record.codeDivision, record.code)
            val entry = MCodeEntry(
                codeCategory = record.codeCategory,
                codeDivision = record.codeDivision,
                code = record.code,
                codeName = record.codeName,
                codeShortName = record.codeShortName,
                extension1 = record.extension1,
                extension2 = record.extension2,
                // ...
                extension10 = record.extension10,
                updatedAt = record.updatedAt ?: LocalDateTime.MIN
            )
            cache[key] = entry
        }
    }

    override fun get(codeCategory: String, codeDivision: String, code: String): MCodeEntry? {
        val key = MCodeKey(codeCategory, codeDivision, code)
        return cache[key]
    }

    override fun getByCategoryAndDivision(category: String, division: String): List<MCodeEntry> {
        return cache.values.filter {
            it.codeCategory == category && it.codeDivision == division
        }
    }
}
```

### **実装詳細のポイント**

- **ConcurrentHashMap** のメソッド (`putAll`, `replace`, etc.) でスレッド安全な更新。  
- **partialReloadByUpdatedAt** は**差分更新**(insertion or update)を行う例。  
  - 削除が起こる場合、**DBにdeleteフラグ**や**レコードそのものの削除**をした際は、どう同期するか要設計。  
- **reloadByCategory** では**カテゴリ**にマッチするキャッシュを一度削除してから、**DBから取得した分を再登録**している。

---

# **5. コントローラ or 管理UI からの操作例**

```kotlin
@RestController
@RequestMapping("/api/mcode")
class MCodeAdminController(
    private val mCodeCacheService: MCodeCacheService
) {

    // 全件再読み込み
    @PostMapping("/reloadAll")
    fun reloadAll(): String {
        mCodeCacheService.loadAll()
        return "Reloaded all M_CODE records into cache."
    }

    // 差分更新: updated_at > since
    @PostMapping("/partialReload")
    fun partialReload(@RequestParam("since") sinceStr: String): String {
        val since = LocalDateTime.parse(sinceStr) // "2023-10-01T00:00:00" など
        mCodeCacheService.partialReloadByUpdatedAt(since)
        return "Partial reload for M_CODE updated after $since"
    }

    // カテゴリ単位で再取得
    @PostMapping("/reloadCategory/{category}")
    fun reloadCategory(@PathVariable category: String): String {
        mCodeCacheService.reloadByCategory(category)
        return "Reloaded M_CODE cache for category $category"
    }
}
```

> - 上記のように**範囲指定**での差分更新、あるいは**カテゴリ単位**の再取得をAPI経由で可能。  
> - **運用**では、DBで `UPDATE M_CODE SET updated_at = NOW()` しておけば、**`partialReloadByUpdatedAt`** で追従可能。

---

# **6. データ削除への対応**

もしDBからレコードが削除された際、**partialReloadByUpdatedAt** だけでは「削除されたレコード情報」を取得できません。  
対策としては以下のいずれか:

1. **deleteフラグを持ち論理削除**し、`extensionX` や `deletedFlag` で示す。→ partialReload時に**deletedFlag=1** になっているものをキャッシュからremove。  
2. **削除されたupdated_at** を**特殊値**(たとえば `extension9='DELETE'`) にして追跡。  
3. **カテゴリ単位**の完全再読み込みを定期的に行うか、**全件reload**で削除を反映。  

---

# **7. 全体の流れ**

1. **アプリ起動**: `MCodeCacheServiceImpl.loadAll()` が呼ばれ、jOOQで `SELECT * FROM M_CODE` → ConcurrentMapに全件格納。  
2. **通常運用**: get系メソッド（`get()`, `getByCategoryAndDivision()` など）を使って**同期的にキャッシュ**から取得。**DB JOINなし**で高速。  
3. **DB変更**: 運用担当が `INSERT/UPDATE/DELETE` (または論理削除) → `updated_at` が更新されたり、 `deleted_flag=1` をセット。  
4. **差分リロード**: PartialReloadAPI( `/api/mcode/partialReload?since=...`) を叩く → `mCodeRepository.findByUpdatedAtAfter(...)` で差分を取得 → `cache` に適用。  
5. **カテゴリ別リロード**: もし**カテゴリ単位**での大きな変更があれば `reloadByCategory(category)` を呼び出す → 旧カテゴリのエントリを削除 → DB再取得 → 新データに置き換え。  
6. **完全リロード**: 重大なレイアウト変更や不整合が疑われる場合、`loadAll()` で**全件取り直し**→キャッシュ再構築。

---

# **8. まとめ**

- **jOOQ** による `MCodeRepository` を定義し、**全件取得**・**部分取得**(範囲指定やカテゴリ指定)などのクエリを用意。  
- **`MCodeCacheService`** で**ConcurrentHashMap**を保持し、**アプリ起動時に全件ロード**し、**API経由で部分リロード**を行う設計を採用。  
- **`updated_at > X`** や **カテゴリ**指定などで**範囲再読み込み**し、キャッシュ更新に反映。削除に対応する場合は**論理削除フラグ**や**全件reload**などの設計が必要。  
- これにより、**JOIN禁止**かつ**キャッシュ参照**を実装し、**大量なM_CODEレコードに対する高速なアクセス**が実現可能。