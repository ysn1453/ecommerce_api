# E-Commerce API

Bu proje, Ruby on Rails ve GraphQL kullanılarak geliştirilmiş bir e-ticaret api uygulamasıdır.

## Özellikler

- Müşteri oluşturma
- Ürün yönetimi
- Sepet işlemleri
- Sipariş oluşturma
- Stok kontrolü

## Kurulum

1. Repo'yu klonlayın:
```shell
$ git clone https://github.com/ysn1453/ecommerce_api.git && cd ecommerce_api
```

2. Gerekli gem'leri yükleyin:
```shell
$ bundle install
```

3. Veritabanını oluşturun ve migrate edin:
```shell
$ rails db:create db:migrate
```

4. (Opsiyonel) Örnek verileri yükleyin:
```shell
$ rails db:seed
```

5. Sunucuyu başlatın:
```shell
$ rails server
```

## API Kullanımı

API, GraphQL endpoint'i üzerinden erişilebilir: <http://localhost:3000/graphql>

### Testler

Testleri çalıştırmak için:

```shell
$ rails test
```