
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function: test_record() 录音并进行检测，供gui调用，并返回结果给gui
% author:   yuhansgg（Shi Gaige）
% time:     2017.4.9
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fs=16000;
fprintf('testing...\n');

y=audiorecorder(fs, 16, 1);  % 16000Hz  16bit  单声道
recordblocking(y,5);%录制5秒

rbd=get(con_rbd,'value') ;
if (rbd)
    delete('test_record/*.wav');
    m=1;%从头开始
end

name=strcat('test_record\',...
            num2str(m),'.wav'); 
y1 = getaudiodata(y,'int16');        
audiowrite(name,y1,fs);  %生成音频文件 1.wav
cut(name);
result = PitchDetect(name);  
disp(result);
m=m+1;
set(con_text,'string',result);


