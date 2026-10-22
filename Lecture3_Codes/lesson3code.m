% --- BAŞLANGIÇ TEMİZLİĞİ ---
clc; clear; close all;

% Görüntüyü yükleme ve gri seviyeye çevirme
Img = imread('cameraman.tif'); 

% ==========================================
% 1. LOGARİTMİK DÖNÜŞÜM
% ==========================================
Ad = double(Img);
B_log = log(Ad + 1);
% Burada bizim c sabiti yerine, resmi [0-255] aralığına çekmek için 
% maksimum değere bölüp 255 ile çarpma matematiği kullanılmış.
B_log = uint8(255 * B_log / max(B_log(:))); 

% ==========================================
% 2. GAMMA DÖNÜŞÜMÜ
% ==========================================
gamma = 2;
Ad = double(Img);
% Resimdeki pikselleri matrisin maksimum değerine bölerek [0,1] aralığına çekiyor
Ad = Ad / max(Ad(:)); 
B_gamma = Ad.^gamma;
B_gamma = uint8(255 * B_gamma); % Tekrar [0-255] aralığına genişletme

% ==========================================
% 3. EŞİKLEME (THRESHOLDING)
% ==========================================
thr = 128;
% Piksel 128'den büyükse 1, küçükse 0 yapar. 255 ile çarpıp beyaz/siyah elde eder.
B_thr = 255 * uint8(Img > thr); 

% ==========================================
% 4. EKRANDA GÖSTERİM (Slayttaki gibi 2x2)
% ==========================================
figure(1);
subplot(2, 2, 1); imshow(Img); title('Orijinal Resim');
subplot(2, 2, 2); imshow(B_log); title('Logaritmik Dönüşüm');
subplot(2, 2, 3); imshow(B_gamma); title('Gamma Dönüşümü (gamma = 2)');
subplot(2, 2, 4); imshow(B_thr); title('Eşikleme (threshold = 128)');

