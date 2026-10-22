clc
clear
close all

Img = imread('cameraman.tif');

% biraz gürültü ekledik.
Img_Gurultulu = imnoise(Img, 'salt & pepper', 0.05);

% 5x5 boyutunda, her elemanı 1/25 olan maske
maske_box = ones(3, 3) / 9  ;

% ağırlıklı ortamala filtesi
maske_weighted = [1 2 1; 
                  2 4 2; 
                  1 2 1] / 16;

% Gaussian Filtresi: 5x5 boyutunda, sigma (standart sapma) değeri 1.5 olan maske
maske_gaussian = fspecial('gaussian', [3 3], 1.5);

% imfilter komutu konvülsüyon yapar.
% replicate kenarları doldurma biçimidir.

% Box filtresi uyguluyoruz
Img_Box = imfilter(Img_Gurultulu, maske_box, 'replicate');

% average wighted
Img_Weighted = imfilter(Img_Gurultulu, maske_weighted, 'replicate');

% Gaussian filtresi uyguluyoruz
Img_Gaussian = imfilter(Img_Gurultulu, maske_gaussian, 'replicate');


figure(1);
subplot(2, 2, 1); 
imshow(Img_Gurultulu); 
title('1. Gürültülü Orijinal');

subplot(2, 2, 2); 
imshow(Img_Box); 
title('2. Standart Box (Sert Bulanıklık)');

subplot(2, 2, 3); 
imshow(Img_Weighted); 
title('3. Ağırlıklı Ortalama (Biraz Daha Net)');

subplot(2, 2, 4); 
imshow(Img_Gaussian); 
title('4. Gaussian (En Doğal Pürüzsüzlük)');