clc
clear
close all

I = [0 0 1 1; 
     1 2 2 2; 
     2 3 3 3; 
     3 3 4 7];

% numel fonksiyonu toplam piksel sayısını hesaplar.
n = numel(I);
L_eksi_1 = 7;

benzersiz_pikseller = unique(I);  %kaç farklı piksel değeri var onu bulduk
% BURADA YAZILIRKEN PİKSELLER KÜÇÜKTEN BÜYÜĞE YAZILIR !!!

fprintf('--- Slayt 51 Matris Örneği Adım Adım Çözümü ---\n');

kumulatif_toplam = 0;
I_yeni = zeros(size(I)); 
% bu yeni matris hpsine 0 yazdık.

for i = 1:length(benzersiz_pikseller)
    rk = benzersiz_pikseller(i); % o benzersiz piksel değerini rk attık
    nk = sum(I(:) == rk);
    % I(:) bütün matrisi gezer 
    % piksel değeri rk ya eşit ise 1 değilse 0 döndürür.
    % sum ise bu 1 değerleri toplar
    % böylece o piksel değerinden matriste kaç tane var bulmuş oluruz.
    pr_rk = nk / n;    
    % burada da normalizasyon yaparız o piksel değeri hangi oranda
    % matris içinde onu buluruz.
    
    kumulatif_toplam = kumulatif_toplam + pr_rk;
    % her adımda bir önceki piksel değerinin oranıyla 
    % bir sonrakini orası toplanır.
    
    % (L-1) ile çarpıp en yakın tam sayıya yuvarlanır
    sk_hesaplanan = L_eksi_1 * kumulatif_toplam;
    sk_yuvarlanan = round(sk_hesaplanan); 
    
    % I matrisindeki rk değerlerinni hepsi yuvarlanan ile değiştirilir.
    I_yeni(I == rk) = sk_yuvarlanan;
    
    fprintf('Eski Piksel rk=%d -> Olasılık: %.2f -> Yeni Piksel sk=%.2f yuvarlandı: %d\n', ...
    rk, pr_rk, sk_hesaplanan, sk_yuvarlanan);
end

disp('Orijinal Matris:'); disp(I);
disp('Histogramı Eşitlenmiş Yeni Matris:'); disp(I_yeni);

Img = imread('tire.tif');
Img_Esitlenmis = histeq(Img);
figure(1);
subplot(2, 2, 1); imshow(Img); title('Orijinal Karanlik Resim');
subplot(2, 2, 3); imhist(Img); title('Dar Histogram');
subplot(2, 2, 2); imshow(Img_Esitlenmis); title('Eşitlenmis (Yüksek Kontrast)');
subplot(2, 2, 4); imhist(Img_Esitlenmis); title('Tam Spektruma Yayilmis Histogram');

