
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function: test_record() ¼�������м�⣬��gui���ã������ؽ����gui
% author:   yuhansgg��Shi Gaige��
% time:     2017.4.9
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fs=16000;
fprintf('testing...\n');

y=audiorecorder(fs, 16, 1);  % 16000Hz  16bit  ������
recordblocking(y,5);%¼��5��

rbd=get(con_rbd,'value') ;
if (rbd)
    delete('test_record/*.wav');
    m=1;%��ͷ��ʼ
end

name=strcat('test_record\',...
            num2str(m),'.wav'); 
y1 = getaudiodata(y,'int16');        
audiowrite(name,y1,fs);  %������Ƶ�ļ� 1.wav
cut(name);
result = PitchDetect(name);  
disp(result);
m=m+1;
set(con_text,'string',result);


