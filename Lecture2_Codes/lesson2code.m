clc
clear
close all

Img = imread('peppers.png');
class(Img)


Img = rgb2gray(Img);
figure(1);
imshow(Img);
axis on;
size(Img)

% Görüntüyü 'nearest' (en yakın komşu) yöntemiyle %50 küçültme
Img_s = imresize(Img, 0.5, 'nearest');
size(Img_s)

% (24, 308) konumundaki tek bir pikselin gri seviyesini okuma
P = Img(24, 308); 

% 41-120 satırları ve 201-300 sütunları arasını kırpma
B = Img(41:120, 201:300);
figure(2);
imshow(B);

% Matristeki en yüksek ve en düşük piksel değerlerini bulma
Max_value = max(Img(:)); 
Min_value = min(Img(:));

% ==========================================
% 3. DAİRESEL MASKE OLUŞTURMA (Merkez: 300, 500)
% ==========================================
s = size(Img);
M = s(1); % Satır sayısı
N = s(2); % Sütun sayısı
C = zeros(M, N); % İçi siyah (0) dolu hedef matris
R_sqr = 200^2;   % Yarıçapın karesi (r^2)

for i = 1:M
    for j = 1:N
        % Merkez noktaya (300. satır, 500. sütun) uzaklık hesabı
        dist = (300 - i)^2 + (500 - j)^2;
        if dist < R_sqr
            C(i, j) = 1; % Dairenin içini beyaz (1) yap
        end
    end
end

class(C) % double -- Döngüden çıkan standart matris formatı
figure(3);
imshow(C);
axis on;

% Noktalı çarpım (.*) için iki matrisin de aynı veri tipinde (double) olması gerekir
Img_C = double(Img) .* C; 
Img_C = uint8(Img_C); % Gösterim için tekrar 8-bit formata çevirme

figure(4);
imshow(Img_C);

% ==========================================
% 5. HİSTOGRAM VE NEGATİF DÖNÜŞÜM
% ==========================================
figure(5);
imhist(Img); % Orijinal histogram

% Görüntü Negatifi (s = L - 1 - r)
Img_N = 256 - 1 - Img; 

figure(6);
imshow(Img_N);
figure(7);
imhist(Img_N);

% ==========================================
% 6. GAMMA (KUVVET) DÖNÜŞÜMÜ
% ==========================================
Img_D = double(Img);
% Yoğunluk değerlerini [0,1] aralığına zorunlu ölçekleme
Img_scaled = Img_D / 255; 

gamma = 0.5; % Slayttaki karanlıkları aydınlatan değer
c = 1;

% Gamma formülünün uygulanması: s = c * r^gamma
Img_g = c * Img_scaled .^ gamma;

% Yoğunluk değerlerini tekrar [0,255] aralığına genişletme
Img_g = 255 * Img_g;
Img_g = uint8(Img_g); % Görüntü formatına geri dönüş

figure(8);
imshow(Img_g);
figure(9);
imhist(Img_g);


% KODUN AÇIKLAMASI

% road yoktu o yüzden pepeers kullanıldı.

% =========================================================================
% KODUN ADIM ADIM MATEMATİKSEL ANALİZİ
% =========================================================================
% 
% 1. Veri Tipleri ve Boyutlandırma
% Görüntü ilk yüklendiğinde uint8 (0-255 arası tam sayılar) formatındadır. 
% imresize komutundaki 'nearest' parametresi, boyut küçültülürken hesaplama 
% yapmadan sadece en yakın piksellerin tutulmasını (veri atılmasını) sağlar.
% 
% 2. Görüntüden Veri Çekme (ROI - Region of Interest)
% Matris işlemleri (Satır, Sütun) (Y-ekseni, X-ekseni) mantığıyla çalışır. 
% Img(41:120, 201:300) kodu, görüntü matrisinden 80 satırlık ve 100 sütunluk 
% bir alt matrisi (kesiti) fiziksel olarak koparıp alır. max(Img(:)) 
% kullanımındaki (:) operatörü, iki boyutlu matrisi tek boyutlu uzun bir 
% vektör haline getirerek resimdeki en parlak pikseli tek seferde bulmanızı sağlar.
% 
% 3. Geometrik Maske Tasarımı (Sıfırdan Matris İnşası)
% En kritik mühendislik adımlarından biri burasıdır. zeros(M,N) ile orijinal 
% resimle birebir aynı boyutta kapkaranlık bir kanvas oluşturulur. İç içe 
% for döngüleri, matrisin her bir hücresini tek tek gezer.
% İçerideki dist = (300-i)^2 + (500-j)^2; formülü klasik Pisagor teoremidir 
% (a^2 + b^2 = c^2). Merkez noktası 300. satır (Y) ve 500. sütun (X) olarak 
% belirlenmiştir. Eğer o anki pikselin merkeze uzaklığı, yarıçapın karesinden 
% (200^2) küçükse, o piksel dairenin içindedir ve değeri 1 (beyaz) yapılır.
% 
% 4. Aritmetik Maskeleme
% Maske matrisi (C) sadece 0 ve 1'lerden oluşmaktadır. double(Img) .* C 
% işlemi ile orijinal görüntünün her bir pikseli bu maskeyle karşılıklı çarpılır. 
% Matematiksel olarak maskenin 1 olduğu dairesel alan içindeki pikseller 
% değerini korurken (X * 1 = X), çerçevenin dışında kalan pikseller yutulup 
% sıfırlanır (X * 0 = 0). Sonucun ekranda düzgün görünmesi için uint8'e geri 
% çevrilmesi zorunludur.
% 
% 5. Negatif Dönüşüm Modeli
% 256 - 1 - Img formülü, piksellerin gri seviye eksenini tam tersine çevirir. 
% 0 olan siyahlar 255'e, 255 olan beyazlar 0'a dönüşür. Görüntü histogramı da 
% sanki ortadan bir ayna konmuş gibi x ekseninde simetrik olarak yer değiştirir.
% 
% 6. Üstel Fonksiyonlar İçin Güvenli Ölçekleme (Scaling)
% Kuvvet alma işlemleri (.^ gamma) piksel değerlerini çok hızlı büyüteceği 
% veya küçülteceği için, orijinal 0-255 aralığı formülü patlatabilir. Bu yüzden 
% Img_D / 255 ile tüm matris [0,1] aralığına ondalıklı olarak sıkıştırılır.
% - Bu güvenli aralıkta gamma = 0.5 (karekök) alındığında küçük değerler 
%   (karanlık pikseller) genişleyerek aydınlanır.
% - İşlem bittikten sonra sonuç 255 * Img_g ile tekrar [0, 255] aralığına 
%   genleşerek standart görüntü formatına oturtulur. Slaytınızın en altında 
%   gamma = 2 yapıldığında ise tam tersi bir etkiyle parlak noktaların 
%   daralıp resmin kontrastının arttığı (koyulaştığı) gösterilmiştir.
% =========================================================================

