clc
clear
close all

Img = imread('cameraman.tif');
disp('Görüntü Boyutları:');
size(Img)

figure(1);

imshow(Img);
title('Original Image');



Yuz = Img(40:100, 100:160);

%figure(2);
%imshow(Yuz);
title('Kırpılan Bolge');

maksimum_deger = max(Img(:))
minimum_deger = min(Img(:))

figure(3);
imhist(Img);
title('Orijinal Goruntu Histogrami');

%-------------------------------------------------------------------

% --- 6. GÖRÜNTÜ NEGATİFİ (Slayt 32 ve 45) ---
% Siyahları beyaz, beyazları siyah yapar. Formül: s = (L-1) - r 
Img_N = 256 - 1 - Img;

figure(4);
imshow(Img_N);
title('Negatif Goruntu');

figure(5);
imhist(Img_N); 
title('Negatif Goruntu Histogrami');

%---------------------------------------------------------------

% --- 7. GAMMA DÖNÜŞÜMÜ (Slayt 36, 38 ve 46) ---
% Slayt 46'daki gibi, işlemi yapabilmek için pikselleri [0, 1] aralığına çekiyoruz.
Img_D = double(Img);
Img_scaled = Img_D / 255;

gamma = 2; % Gamma değeri 1'den küçük olursa karanlık bölgeler aydınlanır.
c = 1;

% Kuvvet (Power-law) formülü: s = c * r^gamma
Img_g = c * (Img_scaled .^ gamma);

% Değerleri tekrar 0-255 aralığına çekip resmi eski formatına (uint8) döndürüyoruz.
Img_g = 255 * Img_g;
Img_g = uint8(Img_g);

figure(6);
imshow(Img_g);
title('Gamma Donusumu (gamma = 0.5)');

figure(7);
imhist(Img_g);
title('Gamma Donusumu Histogrami');

%--------------------------------------------------------------------------------



