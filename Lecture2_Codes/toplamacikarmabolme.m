clc
clear
close all

Img1 = imread('cameraman.tif'); 
Img2 = imread('rice.png');

Img_Toplama = Img1 + Img2;
Img_Cikarma = Img1 - Img2;

% Bölme işlemi küsuratlı (ondalıklı) sonuçlar doğuracağı için 
% matrisleri işlem öncesi 'double' formatına çevirmek zorundayız.
Img1_D = double(Img1);
Img2_D = double(Img2);


% ./ PİKSEL BAZLI BÖLME YAPAR
% SIFIRA BÖLERKEN TANIMSIZ OLMASIN DİYE KÜÇÜK BİR SAYI EKLEDİK.

Img_Bolme = Img1_D ./ (Img2_D + 0.0000001);

figure(1);

subplot(2, 3, 1); imshow(Img1); title('Resim 1 (Cameraman)');
subplot(2, 3, 2); imshow(Img2); title('Resim 2 (Pirincler)');

subplot(2, 3, 4); imshow(Img_Toplama); title('Toplama (+)');
subplot(2, 3, 5); imshow(Img_Cikarma); title('Cikarma (-)');

subplot(2, 3, 6); imshow(Img_Bolme, []); title('Bolme (/)');
