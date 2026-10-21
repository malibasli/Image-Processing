clc
clear
close all

Img = imread('peppers.png');
Img_Gri = rgb2gray(Img);

%yakın komşu kullnarak 0.1 oranında yanı 10 kat küçült
Img_Kucuk = imresize(Img_Gri, 0.1, 'nearest');

Img_Bilinear = imresize(Img_Kucuk, 10, 'bilinear');

Img_Bicubic = imresize(Img_Kucuk, 10, 'bicubic');

figure(1);

subplot(1, 4, 1);
imshow(Img_Gri);
title('Orijinal Goruntu');

subplot(1, 4, 2);
imshow(Img_Kucuk);
title('Nearest-neighbor (Kareli)');

subplot(1, 4, 3);
imshow(Img_Bilinear);
title('Bilinear (Puruzsuz)');

subplot(1, 4, 4);
imshow(Img_Bicubic);
title('Bicubic');