clc
clear
close all

Img = imread('cameraman.tif');

% RESMİ VEKTÖR HALİNE GETİRDİK
Img_Vektor = Img(:);

% BURADA DA KARIŞTIRMA İŞLEMİNİ GERÇEKLEŞTRİDİK.,
% PİKSELLERİ RASTGELE YERLEŞTRİDİK.

Rastgele_Sira = randperm(length(Img_Vektor));
Img_Karistirilmis_Vektor = Img_Vektor(Rastgele_Sira);

%KARIŞTIRILMIŞ BU VEKTÖRÜ IMG İLE AYNI BOYUTTA MATRİSE DİZDİK.
Img_Karistirilmis = reshape(Img_Karistirilmis_Vektor, size(Img));


figure(1);
subplot(2, 2, 1); imshow(Img); title('Orijinal Goruntu');
subplot(2, 2, 2); imhist(Img); title('Orijinal Histogram');
subplot(2, 2, 3); imshow(Img_Karistirilmis); title('Karistirilmis (Shuffled)');
subplot(2, 2, 4); imhist(Img_Karistirilmis); title('AYNI Histogram!');