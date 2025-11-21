# 🏥 Hastane Randevu Yönetim Sistemi

Modern bir hastane randevu yönetim sistemi. Bu proje, doktorlar ve hastalar arasında randevu oluşturma ve yönetme işlemlerini kolaylaştıran bir RESTful API sağlar.

## 📋 İçindekiler

- [Özellikler](#-özellikler)
- [Teknolojiler](#-teknolojiler)
- [Gereksinimler](#-gereksinimler)
- [Kurulum](#-kurulum)
- [Kullanım](#-kullanım)
- [API Endpoints](#-api-endpoints)
- [Test](#-test)
- [Docker ile Deployment](#-docker-ile-deployment)
- [Proje Yapısı](#-proje-yapısı)

## ✨ Özellikler

- ✅ **Doktor Listeleme**: Mevcut doktorların listesini görüntüleme
- ✅ **Randevu Oluşturma**: Hasta ve doktor arasında randevu oluşturma
- ✅ **RESTful API**: Modern API standartlarına uygun endpoint'ler
- ✅ **Otomatik Test**: Cypress ile E2E API testleri ve video kaydı
- ✅ **Docker Desteği**: Konteyner tabanlı deployment
- ✅ **Güvenlik**: Brakeman ve Bundler Audit ile güvenlik taraması
- ✅ **Kod Kalitesi**: RuboCop ile kod standartları

## 🚀 Teknolojiler

### Backend
- **Ruby** 3.4.7
- **Rails** 7.1+ (API-only mode)
- **SQLite3** - Veritabanı
- **Puma** - Web sunucusu
- **Solid Cache, Solid Queue, Solid Cable** - Modern Rails 8 özellikleri

### DevOps & Deployment
- **Docker** - Konteynerizasyon
- **Kamal** - Deployment aracı
- **Thruster** - HTTP caching ve compression

### Test & Quality Assurance
- **Cypress** 15.7 - E2E API testleri
- **RuboCop** - Kod kalitesi ve stil kontrolü
- **Brakeman** - Güvenlik açığı taraması
- **Bundler Audit** - Gem güvenlik kontrolü

## 📦 Gereksinimler

- Ruby 3.4.7
- Rails 7.1+
- SQLite3
- Node.js (Cypress için)
- Docker (opsiyonel, deployment için)

## 🔧 Kurulum

### 1. Projeyi Klonlayın

```bash
git clone https://github.com/sametbassoy/hastane_randevu_antigravity.git
cd hastane_randevu_antigravity
```

### 2. Bağımlılıkları Yükleyin

```bash
# Ruby gem'lerini yükleyin
bundle install

# Node.js paketlerini yükleyin (Cypress için)
npm install
```

### 3. Veritabanını Oluşturun

```bash
rails db:create
rails db:migrate
rails db:seed  # Örnek veriler için (opsiyonel)
```

### 4. Sunucuyu Başlatın

```bash
rails server
```

Sunucu `http://localhost:3000` adresinde çalışacaktır.

## 💻 Kullanım

### API Test Sayfası

Tarayıcınızda `http://localhost:3000/api_test.html` adresine giderek görsel API test arayüzünü kullanabilirsiniz.

### Manuel API Testleri

#### Doktorları Listele

```bash
curl http://localhost:3000/doctors
```

#### Randevu Oluştur

```bash
curl -X POST http://localhost:3000/appointments \
  -H "Content-Type: application/json" \
  -d '{
    "appointment": {
      "doctor_id": 1,
      "patient_id": 1,
      "appointment_time": "2024-12-25T10:00:00"
    }
  }'
```

## 📡 API Endpoints

### Doktorlar

#### `GET /doctors`
Tüm doktorların listesini döndürür.

**Yanıt Örneği:**
```json
[
  {
    "id": 1,
    "name": "Dr. Ahmet Yılmaz",
    "specialization": "Kardiyoloji",
    "created_at": "2024-01-01T00:00:00.000Z",
    "updated_at": "2024-01-01T00:00:00.000Z"
  }
]
```

### Randevular

#### `POST /appointments`
Yeni bir randevu oluşturur.

**İstek Gövdesi:**
```json
{
  "appointment": {
    "doctor_id": 1,
    "patient_id": 1,
    "appointment_time": "2024-12-25T10:00:00"
  }
}
```

**Başarılı Yanıt (201 Created):**
```json
{
  "id": 1,
  "doctor_id": 1,
  "patient_id": 1,
  "appointment_time": "2024-12-25T10:00:00.000Z",
  "status": "scheduled",
  "created_at": "2024-01-01T00:00:00.000Z",
  "updated_at": "2024-01-01T00:00:00.000Z"
}
```

## 🧪 Test

### Cypress E2E Testleri

Cypress testlerini çalıştırmak için:

```bash
# Önce Rails sunucusunu başlatın
rails server

# Başka bir terminalde Cypress'i çalıştırın
npx cypress run
```

### Cypress ile Video Kaydı

Cypress otomatik olarak test videolarını kaydeder. Videolar `cypress/videos/` klasöründe bulunur.

**Cypress Konfigürasyonu:**
```javascript
video: true,              // Video kaydını etkinleştir
videoCompression: 32,     // İyi kalite
videosFolder: 'cypress/videos'
```

### Rails Testleri

```bash
# Tüm testleri çalıştır
rails test

# Belirli bir test dosyasını çalıştır
rails test test/controllers/doctors_controller_test.rb
```

### Kod Kalitesi ve Güvenlik Kontrolleri

```bash
# RuboCop - Kod stil kontrolü
rubocop

# Brakeman - Güvenlik açığı taraması
brakeman

# Bundler Audit - Gem güvenlik kontrolü
bundle audit
```

## 🐳 Docker ile Deployment

### Docker Image Oluşturma

```bash
docker build -t hastane_randevu .
```

### Docker Container Çalıştırma

```bash
docker run -d -p 80:80 \
  -e RAILS_MASTER_KEY=<config/master.key içeriği> \
  --name hastane_randevu \
  hastane_randevu
```

### Kamal ile Deployment

```bash
# Kamal kurulumu
gem install kamal

# Deployment
kamal deploy
```

## 📁 Proje Yapısı

```
hastane_randevu/
├── app/
│   ├── controllers/
│   │   ├── appointments_controller.rb  # Randevu işlemleri
│   │   └── doctors_controller.rb       # Doktor listeleme
│   └── models/
│       ├── appointment.rb              # Randevu modeli
│       ├── doctor.rb                   # Doktor modeli
│       └── patient.rb                  # Hasta modeli
├── cypress/
│   ├── e2e/
│   │   └── visual_test.cy.js          # E2E API testleri
│   └── videos/                         # Test videoları
├── db/
│   ├── migrate/                        # Veritabanı migration'ları
│   └── schema.rb                       # Veritabanı şeması
├── public/
│   └── api_test.html                   # Görsel API test arayüzü
├── config/
│   └── routes.rb                       # API route tanımları
├── Dockerfile                          # Docker konfigürasyonu
├── cypress.config.js                   # Cypress konfigürasyonu
├── Gemfile                             # Ruby bağımlılıkları
└── package.json                        # Node.js bağımlılıkları
```

## 🔐 Güvenlik

Bu proje aşağıdaki güvenlik araçlarını kullanır:

- **Brakeman**: Rails uygulamasında güvenlik açıklarını tarar
- **Bundler Audit**: Gem bağımlılıklarında bilinen güvenlik açıklarını kontrol eder
- **RuboCop**: Kod kalitesi ve güvenlik standartlarını uygular

## 📝 Lisans

Bu proje açık kaynak kodludur.

## 👨‍💻 Geliştirici

**Samet Bassoy**
- GitHub: [@sametbassoy](https://github.com/sametbassoy)

## 🤝 Katkıda Bulunma

1. Bu repository'yi fork edin
2. Feature branch'i oluşturun (`git checkout -b feature/amazing-feature`)
3. Değişikliklerinizi commit edin (`git commit -m 'feat: Add amazing feature'`)
4. Branch'inizi push edin (`git push origin feature/amazing-feature`)
5. Pull Request oluşturun

## 📞 İletişim

Sorularınız veya önerileriniz için issue açabilirsiniz.

---

⭐ Bu projeyi beğendiyseniz yıldız vermeyi unutmayın!
