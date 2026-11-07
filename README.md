# 📈 SQL Aggregations & Data Grouping: `thelook_ecommerce`

Dokumen ini berisi latihan SQL yang berfokus pada fungsi agregasi (*Aggregation Functions*), pengelompokan data (`GROUP BY`), serta analisis ringkas pada dataset `thelook_ecommerce` di Google BigQuery.

## 📌 Konsep Utama

1. **Fungsi Agregasi**:
   * `COUNT()`: Menhitung jumlah baris atau nilai non-null.
   * `SUM()`: Menjumlahkan nilai numerik.
   * `AVG()`: Menghitung rata-rata nilai numerik.
   * `MIN()` / `MAX()`: Mencari nilai terkecil dan terbesar (berlaku untuk angka, teks, maupun tanggal).
   * `ROUND()`: Membulatkan desimal.

2. **Pengelompokan Data (`GROUP BY`)**:
   * Mengelompokkan baris data berdasarkan satu atau lebih kolom non-agregat untuk dihitung nilai statistik agregatnya.

---

## 📜 Kueri SQL dan Kasus Pembelajaran

### 1. Pengenalan Fungsi Agregasi Dasar

* **Menghitung Total Pengguna (`COUNT`)**:
  ```sql
  -- Menhitung total pengguna terdaftar (Hasil: 100.000)
  SELECT
    COUNT(id) AS jumlah_user 
  FROM bigquery-public-data.thelook_ecommerce.users;
  ```

* **Penjumlahan dan Rata-rata (`SUM` & `AVG`)**:
  ```sql
  -- Total item terpesan
  SELECT
    SUM(num_of_item) AS total_item_terpesan 
  FROM bigquery-public-data.thelook_ecommerce.orders;

  -- Rata-rata item per pemesanan
  SELECT
    AVG(num_of_item) AS rata2_item_terpesan 
  FROM bigquery-public-data.thelook_ecommerce.orders;
  ```

* **Nilai Minimum, Maksimum, dan Statistik Gabungan Produk**:
  ```sql
  SELECT
    MIN(retail_price) AS min_retail_price,
    MAX(retail_price) AS max_retail_price,
    AVG(retail_price) AS rata2_retail_price,
    SUM(retail_price) AS total_retail_price,
    COUNT(id) AS total_produk     
  FROM bigquery-public-data.thelook_ecommerce.products;
  ```

---

### 2. Agregasi Berkondisi (Filtered Aggregations)

* **Pengguna berdasarkan Negara & Gender**:
  ```sql
  -- Jumlah user dari Brazil (Hasil: 14.576)
  SELECT
    COUNT(id) AS jumlah_user_brasil
  FROM bigquery-public-data.thelook_ecommerce.users
  WHERE country = 'Brasil';

  -- Jumlah user laki-laki (Hasil: 50.195) & Rata-rata usia (Hasil: 41.01)
  SELECT
    COUNT(id) AS jumlah_user_male,
    ROUND(AVG(age), 2) AS rata_usia
  FROM bigquery-public-data.thelook_ecommerce.users
  WHERE gender = 'M';
  ```

* **Mencari Rentang Tanggal Pengguna Terdaftar**:
  ```sql
  -- Pengguna pertama terdaftar (2019-01-02) dan pengguna terbaru
  SELECT
    MIN(created_at) AS early_user,
    MAX(created_at) AS new_user
  FROM bigquery-public-data.thelook_ecommerce.users;
  ```

---

### 3. Pengelompokan Data (`GROUP BY`)

* **Distribusi Pengguna berdasarkan Channel Acquisition**:
  ```sql
  SELECT
    traffic_source,
    COUNT(id) AS jumlah_user
  FROM bigquery-public-data.thelook_ecommerce.users
  GROUP BY traffic_source
  ORDER BY jumlah_user DESC;
  ```

* **Demografi Umur berdasarkan Gender**:
  ```sql
  SELECT
    gender,
    ROUND(AVG(age), 2) AS rata2_usia,
    MIN(age) AS min_usia,
    MAX(age) AS max_usia
  FROM bigquery-public-data.thelook_ecommerce.users
  GROUP BY gender;
  ```

---

### 4. Latihan Eksplorasi Produk & Pesanan

* **5 Kategori Produk Terbanyak**:
  ```sql
  SELECT
    category,
    COUNT(id) AS jumlah_produk
  FROM bigquery-public-data.thelook_ecommerce.products
  GROUP BY category
  ORDER BY jumlah_produk DESC
  LIMIT 5;
  ```

* **Kategori Produk dengan Rata-rata Harga Jual Tertinggi**:
  ```sql
  SELECT
    category,
    AVG(retail_price) AS rata2_harga_jual
  FROM bigquery-public-data.thelook_ecommerce.products
  GROUP BY category
  ORDER BY rata2_harga_jual DESC;
  ```

* **Top 5 Brand Produk Terbanyak**:
  ```sql
  SELECT
    brand,
    COUNT(id) AS jumlah_produk
  FROM bigquery-public-data.thelook_ecommerce.products
  GROUP BY brand
  ORDER BY jumlah_produk DESC
  LIMIT 5;
  ```

* **Analisis Pesanan Multitem (>1 Item) per Status**:
  ```sql
  SELECT
    status,
    COUNT(order_id) AS total_order
  FROM bigquery-public-data.thelook_ecommerce.orders
  WHERE num_of_item > 1
  GROUP BY status
  ORDER BY total_order DESC;
  ```
  > 💡 **Insight:** Untuk transaksi yang memiliki lebih dari 1 barang, pesanan paling dominan berada pada status **Shipped** dan diikuti oleh **Complete**, sedangkan posisi terendah adalah **Returned**.

---

### 5. Ringkasan Tugas & Metrik Pesanan

```sql
-- Total Keseluruhan Order (124.452)
SELECT COUNT(*) AS total_order
FROM bigquery-public-data.thelook_ecommerce.orders;

-- Total & Rata-rata Item Per Transaksi
SELECT
  SUM(num_of_item) AS total_num_of_item,
  ROUND(AVG(num_of_item), 2) AS avg_num_of_item
FROM bigquery-public-data.thelook_ecommerce.orders;

-- Min & Max Item Per Transaksi
SELECT
  MIN(num_of_item) AS min_num_of_item,
  MAX(num_of_item) AS max_num_of_item
FROM bigquery-public-data.thelook_ecommerce.orders;
```

---

## 📌 Catatan Penting (Key Takeaways)

1. **Aturan `GROUP BY`**: Semua kolom yang ada pada klausa `SELECT` yang **tidak** menggunakan fungsi agregasi *wajib* dimasukkan ke dalam klausa `GROUP BY`.
2. **`COUNT(*)` vs `COUNT(column)`**: `COUNT(*)` menghitung seluruh baris termasuk nilai NULL, sedangkan `COUNT(column)` hanya menghitung baris yang memiliki nilai (non-NULL).
3. **Pembulatan (`ROUND`)**: Menggunakan `ROUND(nilai, 2)` memudahkan pembacaan statistik desimal seperti hasil `AVG()`.
