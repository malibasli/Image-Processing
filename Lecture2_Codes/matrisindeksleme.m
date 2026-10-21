clc
clear
close all

% MATLAB'ın içindeki hazır renkli resmi okuyoruz
Img_Renkli = imread('peppers.png');

% Renkli (3 kanallı) matrisi, Gri (tek kanallı) matrise çeviriyoruz
Img_Gri = rgb2gray(Img_Renkli);             % RGB den Griye ( RGB2GRAY fonksinou ) 

disp('Gri Görüntünün Boyutları (Satır x Sütun):');
size(Img_Gri)

Kirpilmis_Bolge = Img_Gri(100:250, 150:300);
Piksel_Degeri = Img_Gri(120, 200);
fprintf('120. satir, 200. sutundaki pikselin degeri (0-255 arasi): %d\n', Piksel_Degeri);

% --- 3. EKRANDA GÖSTERME ---
figure(1);
subplot(1, 2, 1); % Pencereyi 1 satır, 2 sütuna bölüp 1. kısmına orijinali koyuyoruz
imshow(Img_Gri);
title('Orijinal Gri Görüntü');

subplot(1, 2, 2);  % Pencerenin 2. kısmına kırptığımız bölgeyi koyuyoruz
imshow(Kirpilmis_Bolge);
title('Kirpilmis (Crop) Bolge');