clc
clear
close all

Img = imread('cameraman.tif');

% Uygulanacak işlemlerin sağlığı için 0-1 aralığına ölçeklenmesi lazım
Img_D = double(Img) / 255;


% 0-1 arasına ölçeklendirdiğimiz için negatif alma formülü değişti
Img_Negatif = 1 - Img_D;

% c sabiti logaritmanın parlaklık çarpanıdır; görüntüyü [0,1] aralığına zaten küçülttüğümüz için 1 seçilmesi yeterlidir.
c_log = 1;
Img_Log = c_log * log(1 + Img_D);


% C) Gamma Dönüşümü (Karanlık resimler için, Gamma < 1)
gamma_kucuk = 0.5;
Img_Gamma_05 = Img_D .^ gamma_kucuk;

% D) Gamma Dönüşümü (Aydınlık/Soluk resimler için, Gamma > 1)
gamma_buyuk = 3.0;
Img_Gamma_30 = Img_D .^ gamma_buyuk;

figure(1);
subplot(2, 3, 1); imshow(Img_D); title('Orijinal');
subplot(2, 3, 2); imshow(Img_Negatif); title('Negatif');
subplot(2, 3, 3); imshow(Img_Log, []); title('Logaritmik');
subplot(2, 3, 4); imshow(Img_Gamma_05); title('Gamma = 0.5 (Aydınlatma)');
subplot(2, 3, 5); imshow(Img_Gamma_30); title('Gamma = 3.0 (Koyulaştırma)');



