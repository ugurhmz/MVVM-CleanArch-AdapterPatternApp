# 📘 Project: MVVM-CleanArch-AdapterPatternApp

<img width="3616" height="1184" alt="Gemini_Generated_Image_ptwxehptwxehptwx" src="https://github.com/user-attachments/assets/4a194352-b9ef-4d57-b61c-21253ed5ed3f" />


Bu proje; ölçeklenebilir, test edilebilir ve modern Swift standartlarına (Concurrency) uygun bir iOS uygulama mimarisi örneğidir. Projede ağ katmanı somut kütüphanelerden soyutlanmış, bağımlılıklar protokoller üzerinden yönetilmiştir.

<br>

## 🚀 Kullanılan Teknolojiler & Mimari Desenler

* **Mimari:** MVVM (Model-View-ViewModel) + Clean Architecture prensipleri.
* **Adapter Pattern:** Alamofire veya herhangi bir ağ kütüphanesini sistemden izole ederek bir protokol arkasına gizler.
* **Dependency Injection (DI):** Tüm bileşenler birbirine somut sınıflar yerine protokoller üzerinden enjekte edilir.
* **Builder (Factory):** Nesne yaratım ve montaj süreçlerini merkezi bir noktadan yönetir.
* **Delegate Pattern:** ViewModel'den View katmanına asenkron durum (State) güncellemelerini iletmek için kullanılır.
* **Modern Swift Concurrency:** `async/await` ile sadeleştirilmiş asenkron akış, `Sendable` ve `@MainActor` ile iplik (thread) güvenliği sağlanmıştır.

<br>

## 🏗 Mimari Akış ve Çalışma Mantığı



<br>

### 1. SceneDelegate (Uygulama Giriş Noktası)
* Uygulama ilk açıldığında `HomeBuilder.build()` metodunu tetikler.
* Builder'dan gelen hazır `ViewController` nesnesini alır.
* Bu nesneyi bir `UINavigationController` içine koyarak uygulamanın ana ekranı (`rootViewController`) olarak belirler.

<br>

### 2. HomeBuilder (Montaj Hattı)
* **Adapter Başlatma:** Önce ağ isteklerini yapacak olan `AlamofireNetworkAdapter` nesnesini oluşturur.
* **ViewModel Başlatma:** `HomeViewModel` nesnesini oluşturur ve az önce oluşturulan ağ adaptörünü (NetworkService) bu sınıfın içine enjekte eder.
* **ViewController Başlatma:** `HomeViewController` nesnesini oluşturur ve hazırlanan `ViewModel` nesnesini içine enjekte eder.
* **Teslimat:** Tüm bağımlılıkları birbirine bağlanmış olan `ViewController` nesnesini geri döndürür.

<br>

### 3. NetworkServiceProtocol (Sözleşme Katmanı)
* Ağ isteği atacak her yapının uyması gereken kuralları tanımlar.
* `request` fonksiyonu **Generic** bir yapıdadır; parametre olarak bir `Endpoint` sözleşmesi ve çözümlenecek veri modelini (`T.Type`) alır.
* Böylece sistem, ağ isteğini hangi kütüphanenin (Alamofire, URLSession vb.) yaptığını bilmez, sadece protokole güvenir.

<br>

### 4. AlamofireNetworkAdapter (Somut Uygulama)
* Ağ katmanı protokolünü (`NetworkServiceProtocol`) uygular.
* İçinde bir Alamofire `Session` barındırır.
* ViewModel'den gelen istek bilgilerini Alamofire'ın anlayacağı formatta işler ve sonucu asenkron olarak döndürür.

<br>

### 5. HomeViewModel (İş ve Veri Mantığı)
* Ağ katmanına doğrudan değil, `NetworkServiceProtocol` üzerinden erişir (Bağımlılıkların Tersine Çevrilmesi).
* API'den veri çekme isteğini (`fetchCharacters`) başlatır.
* Veri çekme sürecindeki durumları (`loading`, `success`, `failure`) bir `Enum` üzerinden yönetir.
* Bu durum değişikliklerini, kendisine bağlı olan `delegate` (ViewController) üzerinden arayüze bildirir.

<br>

### 6. HomeViewController (Arayüz Katman)
* ViewModel'i protokol üzerinden inject alarak sadece gerekli fonksiyonlara erişir.
* ViewModel'in `delegate` rolünü üstlenerek veri akışını dinler.
* `viewDidLoad` anında veri çekme sürecini başlatır ve gelen durumlara göre (yükleniyor animasyonu, liste güncelleme veya hata mesajı) ekranı günceller.

<br>

## 🎯 Mimari Avantajlar Özeti

* **Bağımsızlık:** Ağ kütüphanesini (Alamofire) değiştirmek isterseniz sadece Adapter sınıfını güncellemeniz yeterlidir; ViewModel veya View koduna dokunulmaz.
* **Test Edilebilirlik:** Gerçek bir ağ isteği yerine "Mock" (sahte) veriler dönen bir protokol uygulaması yazılarak tüm sistem kolayca test edilebilir.
* **Sürdürülebilirlik:** Her sınıfın görevi net olarak ayrılmıştır (Single Responsibility), bu da projenin büyümesini kolaylaştırır.

<br>

---
