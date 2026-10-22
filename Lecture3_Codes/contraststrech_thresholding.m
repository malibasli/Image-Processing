clc
clear
close all

Img1 = imread('pout.tif');
Img1_D = double(Img1);

r_min = min(Img1_D(:)); 
r_max = max(Img1_D(:));
L_eksi_1 = 255;

% Formül: Yeni Değer = ((L-1) / (r_max - r_min)) * (r - r_min)
% Bu formül pikselleri [0, L-1] aralığına doğrusal olarak gerer.
Img_Gerilmis = (L_eksi_1 / (r_max - r_min)) * (Img1_D - r_min);

% double dan tekrar uint8 e döndük
Img_Gerilmis = uint8(Img_Gerilmis);


% THRESHOLDING

Img2 = imread('coins.png');

% Eşik değerini (m) belirliyoruz
m = 100;

% Formül: r >= m ise 1, r < m ise 0
% MATLAB'daki ">=" operatörü bu matematiksel kuralı otomatik uygular.
Img_Esiklenmis = Img2 >= m; % Sonuç "logical" (0 ve 1) matrisidir

figure(1);
subplot(2, 4, 1); imshow(Img1); title('Orijinal Soluk Resim (r)');
subplot(2, 4, 2); imhist(Img1);
subplot(2, 4, 3); imshow(Img_Gerilmis); title('Kontrasti Gerilmis (s = T(r))');
subplot(2, 4, 4); imhist(Img_Gerilmis);
subplot(2, 4, 5); imshow(Img2); title('Orijinal Paralar (f(x,y))');
subplot(2, 4, 6); imhist(Img2);
subplot(2, 4, 7); imshow(Img_Esiklenmis); title('Esiklenmis / Binary (g(x,y))');
subplot(2, 4, 8); imhist(Img_Esiklenmis);