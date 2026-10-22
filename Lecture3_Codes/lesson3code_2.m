% --- BAŞLANGIÇ TEMİZLİĞİ ---
clc; clear; close all;

% =========================================================================
% BÖLÜM 1: MANUEL DÖNGÜLERLE (FOR) 9x9 AVERAGE FİLTRELEME (Slayt 65)
% =========================================================================
A = imread('cameraman.tif'); % penguenler yoksa cameraman kullanıyoruz
A = double(A);               % İşlem güvenliği için double formatı
B = zeros(size(A));          % Filtre çıktısı için siyah boş tuval

% 9x9 boyutunda bir ortalama alma (box) filtresi
mask = (1/81) * ones(9);

% Slayt 65'teki For Döngüsü Analizi:
% Slayttaki kod "ignoring border pixels" (kenar pikselleri görmezden gelme) mantığına dayanır.
% 9x9'luk bir maskenin tam ortası (merkezi) 5. satır/sütundur. 
% Bu yüzden döngü 1'den değil, maskenin merkeze oturabileceği 5'ten (i=5, j=5) başlar
% ve matrisin sınırından 4 piksel içeride (end-4) biter.
for i = 5 : size(B,1)-4
    for j = 5 : size(B,2)-4
        % 9x9 boyutunda alt matrisi koparma işlemi
        sub_image = A(i-4:i+4, j-4:j+4);
        
        % Maske ile koparılan alanı karşılıklı (noktalı çarpım) çarpma
        s = sub_image .* mask;
        
        % Tüm çarpım sonuçlarını toplayıp merkeze (i,j) yazdırma
        B(i,j) = sum(s(:));
    end
end

figure(1);
subplot(1,2,1); imshow(uint8(A)); title('Orijinal');
subplot(1,2,2); imshow(uint8(B)); title('Manuel For Döngüsü (9x9 Blur)');


% =========================================================================
% BÖLÜM 2: MANUEL DÖNGÜLERLE (FOR) LAPLACE KESKİNLEŞTİRME (Slayt 66)
% =========================================================================
f_mask = [0 -1  0; 
         -1  4 -1; 
          0 -1  0];

% Kenar Pikselleri Yönetmek (Zero Padding):
% Slayt 66'da, matrisin kenarlarına 0'lardan oluşan bir çerçeve ekleniyor.
% Matris boyutunu 2 satır ve 2 sütun (+2) büyütüp siyah (zeros) yapıyoruz.
Ab = zeros(size(A,1)+2, size(A,2)+2); 

% Orijinal A matrisini, bu siyah çerçevenin tam ortasına oturtuyoruz
Ab(2:end-1, 2:end-1) = A; 
B_Laplace = zeros(size(A));

for i = 1 : size(A,1)
    for j = 1 : size(A,2)
        % Artık etrafı sıfırlarla çevrili (Ab) matrisinden rahatça 3x3'lük alan kopardığımız 
        % için sınır dışına taşma hatası (index out of bounds) almıyoruz.
        ij_window = Ab(i:i+2, j:j+2);
        a = ij_window .* f_mask;
        B_Laplace(i,j) = sum(a(:));
    end
end

C_keskin_manuel = A + B_Laplace; % Orijinal resme kenarları geri ekleme

figure(2);
subplot(1,3,1); imshow(uint8(A)); title('Orijinal');
subplot(1,3,2); imshow(abs(B_Laplace), [0 max(B_Laplace(:))]); title('Laplace (Kenar)');
subplot(1,3,3); imshow(uint8(C_keskin_manuel)); title('Keskinleşmiş (C = A + B)');


% =========================================================================
% BÖLÜM 3: MATLAB'IN HAZIR 'imfilter' KOMUTU (Slayt 67)
% =========================================================================
% Slayt 67, tüm o karmaşık ve yavaş for döngülerini tek satırda nasıl çözeceğimizi gösterir.

B_hizli = imfilter(A, f_mask, 'replicate');
C_hizli = A + B_hizli;

figure(3);
subplot(1,2,1); imshow(uint8(A)); title('Orijinal');
subplot(1,2,2); imshow(uint8(C_hizli)); title('imfilter ile Keskinleşmiş (Slayt 67)');