close all;
clear;


rolloff_vals = [0, 0.25, 0.75, 1];  
span = 10;        
sps = 8;         
N = 1e4;           
SNR = 20;         

BP_Data = 2*randi([0 1], N, 1) - 1; 

for i = 1:length(rolloff_vals)
    alpha = rolloff_vals(i);
    rctFilt = rcosdesign(alpha, span, sps, 'sqrt');
    tx_signal = upfirdn(BP_Data, rctFilt, sps, 1);
    rx_signal = awgn(tx_signal, SNR, 'measured');

    figure;
    hold on;
    for k = 1:2000:(length(rx_signal) - 2*sps)
        segmento = rx_signal(k : k + 2*sps - 1);
        plot(segmento, 'b');  % azul
    end
    title(['Diagrama de Ojo, \alpha = ', num2str(alpha)], 'FontWeight', 'bold');
    xlabel('Muestras');
    ylabel('Amplitud');
    grid on;
end
