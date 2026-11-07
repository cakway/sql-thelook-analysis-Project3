-- berapa jumlah user yang terdaftar? 100.000
SELECT
 *
FROM bigquery-public-data.thelook_ecommerce.users;

-- Fungsi Count untuk menghitung seluruh baris
SELECT
 COUNT (id) AS jumlah_user 
FROM bigquery-public-data.thelook_ecommerce.users;

-- Fungsi SUM menjumlahkan nilai
SELECT
 SUM (num_of_item) AS total_item_terpesan 
FROM bigquery-public-data.thelook_ecommerce.orders;
--AVG mencari nilai rata-rata

SELECT
 AVG (num_of_item) AS rata2_item_terpesan 
FROM bigquery-public-data.thelook_ecommerce.orders;

--Berapa harga rata-rata produk yang dijual
SELECT
 AVG (retail_price) AS rata2_harga_jual 
FROM bigquery-public-data.thelook_ecommerce.products;

--Berapa yang paling murah? berapa yang paling mahal
SELECT
 MIN (retail_price) AS min_retail_price 
FROM bigquery-public-data.thelook_ecommerce.products;

SELECT
 MAX (retail_price) AS max_retail_price 
FROM bigquery-public-data.thelook_ecommerce.products;

SELECT
 MIN (retail_price) AS min_retail_price,
 MAX (retail_price) AS max_retail_price,
 AVG (retail_price) AS rata2_retail_price,
 SUM (retail_price) AS total_retail_price,
 COUNT (id) AS total_produk     
FROM bigquery-public-data.thelook_ecommerce.products;

--Latihan
--Ada berapa jumlah user dari Brazil? 14.576
SELECT
 COUNT(id) AS jumlah_user_brasil
FROM bigquery-public-data.thelook_ecommerce.users
WHERE
 COUNTRY = 'Brasil';

--Ada berapa jumlah user laki-laki? 50.195
SELECT
 COUNT(id) AS jumlah_user_male
FROM bigquery-public-data.thelook_ecommerce.users
WHERE
 gender = 'M';

--Berapa rata-rata usia user laki-laki? 41.0076
SELECT
 ROUND (AVG (age), 2) AS rata_usia
 FROM bigquery-public-data.thelook_ecommerce.users
WHERE
 gender = 'M';

--Group By, mengelompokkan agregasinya (berdasarkan kolom non agregat)
-- Berapa user dari setiap traffic _source?
SELECT
 traffic_source, --non agregat
 COUNT (id) AS jumlah_user -- agregat
FROM bigquery-public-data.thelook_ecommerce.users
GROUP BY
 traffic_source
ORDER BY
 jumlah_user DESC;

-- mau lihat rata-rata usia, usia minimum dan usia maksimum berdasarkan gender
SELECT
 gender, --non agregat
 AVG(age) AS rata2_usia, --agg
 MIN (age) AS min_usia, --agg
 MAX (age) AS max_usia --agg
FROM bigquery-public-data.thelook_ecommerce.users
GROUP BY
 gender;

 -- tanggal berapa user pertama dibuat? 2019-01-02
SELECT
  MIN (created_at) AS early_user
FROM bigquery-public-data.thelook_ecommerce.users; 

--new users
SELECT
  MAX (created_at) AS new_user
FROM bigquery-public-data.thelook_ecommerce.users; 

--Latihan 2
--01. coba tarikkan 5 kategori produk yang paling banyak
SELECT
 category, --non agregat
 COUNT (id) AS jumlah_produk -- agregat
FROM bigquery-public-data.thelook_ecommerce.products
GROUP BY
 category
ORDER BY
 jumlah_produk DESC
LIMIT 5;

--02. kategori produk mana yang memiliki rata2 harga jual tertinggi
SELECT
 category, --non agregat
 AVG(retail_price) AS rata2_harga_jual, --agg
FROM bigquery-public-data.thelook_ecommerce.products
GROUP BY
 category
ORDER BY
 rata2_harga_jual DESC;


--03. Brand mana yang memiliki produk paling banyak
SELECT
 brand, --non agregat
 COUNT (id) AS jumlah_produk -- agregat
FROM bigquery-public-data.thelook_ecommerce.products
GROUP BY
 brand
ORDER BY
 jumlah_produk DESC
LIMIT 5;

-- penggunaan Count
SELECT
 COUNT(id) AS jumlah_user,
 COUNT(email) AS jumlah_email_terdaftar
FROM bigquery-public-data.thelook_ecommerce.users 

SELECT
 COUNT(created_at) AS jumlah_created_at,
 COUNT(returned_at) AS jumlah_returned_at
FROM bigquery-public-data.thelook_ecommerce.orders; 

SELECT
 status,
 COUNT(order_id)
FROM bigquery-public-data.thelook_ecommerce.orders
GROUP BY status;

--Coba hitung jumlah orders berdasarkan status untuk orderan yang memiliki items lebih dari 1
--Urutkan dari yang paling besar

SELECT
 status,
 COUNT(order_id) AS total_order
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE
 num_of_item > 1
GROUP BY status
ORDER BY
 total_order DESC;

--Insight
-- Jika berdasarkan status orderan pesanan yang memiliki pesanan lebih dari 1 item, itu didominasi oleh status "Shipped" dan diikuti oleh "Complete". Posisi terakhir 'returned'

--Tugas A (124.452)
SELECT
 COUNT (*) AS total_order
FROM bigquery-public-data.thelook_ecommerce.orders;

-- Tugas B:
--Total Items & Rata2 Items
SELECT
 SUM (num_of_item) AS total_num_of_item,
 ROUND(AVG (num_of_item), 2) AS Avg_num_of_item
FROM bigquery-public-data.thelook_ecommerce.orders;

--Tugas C:
--Min Num_Of_Item
--Max Num_Of_Item
SELECT
 MIN (num_of_item) AS min_num_of_item,
 MAX (num_of_item) AS max_num_of_item
FROM bigquery-public-data.thelook_ecommerce.orders;




