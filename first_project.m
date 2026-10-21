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

figure(2);
imshow(Yuz);
title('Kırpılan Bolge');

maksimum_deger = max(Img(:))
minimum_deger = min(Img(:))

figure(3);
imhist(Img);
title('Orijinal Goruntu Histogrami');

% --- 6. GÖRÜNTÜ NEGATİFİ (Slayt 32 ve 45) ---
% Siyahları beyaz, beyazları siyah yapar. Formül: s = (L-1) - r 
Img_N = 256 - 1 - Img;

figure(4);
imshow(Img_N);
title('Negatif Goruntu');

figure(5);
imhist(Img_N); 
title('Negatif Goruntu Histogrami');
