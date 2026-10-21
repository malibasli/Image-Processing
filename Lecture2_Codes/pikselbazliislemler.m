clc
clear
close all

Img = imread('cameraman.tif');

% Görüntünün boyutlarını alıyoruz
s = size(Img);
M = s(1); % Satır sayısı (256)
N = s(2); % Sütun sayısı (256)

C = zeros(M, N);

R_sqr = 80^2;

% pikselleri tek tek gezerek merkez noktaya olan uzaklığı 80 den az olan
% piksellere 1 veriyoruz. C komple siyahtı yuvarlak bir beyaz oluşturduk
% içine

for i = 1:M
    for j = 1:N
        % Merkez noktası: i=128 (Y ekseni), j=128 (X ekseni)
        dist = (128 - i)^2 + (128 - j)^2;
        
        % Eğer piksel dairenin içindeyse, değerini 1 (beyaz) yap
        if dist < R_sqr
            C(i, j) = 1;
        end
    end
end

figure(1);
subplot(1, 2, 1);
imshow(C);
title('Olusturulan Dairesel Maske');

Img_D = double(Img);            % görüntüyü matematiksel işlem için double a çevirdik.

Img_Maskeli_D = Img_D .* C      % maske ile çarptık.

Img_Maskeli = uint8(Img_Maskeli_D);

subplot(1, 2, 2);
imshow(Img_Maskeli);
title('Maskelenmis (Carpilmis) Goruntu');






