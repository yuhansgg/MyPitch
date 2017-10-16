
function   pd=PitchDetect(s_address)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function: PitchDetect() ��Ů������Ƶ��ʶ�����
% input :   ��Ƶ�ļ���ַ
% output:   ʶ����
% author:   yuhansgg��Shi Gaige��
% time:     2017.4.9
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
waveFile = s_address;
% fs = 16000
% y = cut(s_address);
[y, fs] = audioread(waveFile);
time=(1:length(y))/fs;
frameSize=floor(40*fs/1000);     %֡��40ms һ��640����   floor������x���������
startIndex=round(7000);         %��ʼ���
endIndex=startIndex+frameSize-1; %�������
frame = y(startIndex:endIndex);  %ȡ����֡
frameSize=length(frame);
frame2=frame.*hamming(length(frame));  % ��hamming��
rwy = rceps(frame2);                   % ����
ylen=length(rwy);
cepstrum=rwy(1:ylen/2); %�������
LF=floor(fs/500);     %���û��������ķ�Χ  ����
HF=floor(fs/70);      %���û��������ķ�Χ  ����
cn=cepstrum(LF:HF);   %����
[mx_cep ind]=max(cn); %�������ޣ��ҵ���ֵλ��
if mx_cep > 0.08 & ind >LF
    a= fs/(LF+ind);
else
    a=0;
end
figure(2);
plot(time, y); title(waveFile); axis tight
ylim=get(gca, 'ylim');
line([time(startIndex), time(startIndex)], ylim, 'color', 'r');
line([time(endIndex), time(endIndex)], ylim, 'color', 'r');
title('��������');
figure(3);
subplot(2,1,1);
plot(frame);
title('ȡ��֡�Ĳ���');
subplot(2,1,2);
plot(cepstrum);
title('����ͼ');

[x,sr]=audioread(s_address);  
meen=mean(x);
x= x - meen;
updRate=floor(20*sr/1000);          %ÿ20ms����
fRate=floor(40*sr/1000);            %40msһ֡
n_samples=length(x);
nFrames=floor(n_samples/updRate)-1; %֡��
k=1;
pitch=zeros(1,nFrames);
f0=zeros(1,nFrames);
LF=floor(sr/500);
HF=floor(sr/70);
m=1;
avgF0=0;
for t=1:nFrames
        yin=x(k:k+fRate-1);
        cn1=rceps(yin);
        cn=cn1(LF:HF);
        [mx_cep ind]=max(cn);
        if mx_cep > 0.08 & ind >LF
           a= sr/(LF+ind);
        else
            a=0;
        end 
        f0(t)=a;
        if t>2 & nFrames>3   %��ֵ�˲��Ի����켣ͼ����ƽ��
           z=f0(t-2:t);
           md=median(z);
           pitch(t-2)=md;
           if md > 0
             avgF0=avgF0+md;
             m=m+1;
           end
        else
            if nFrames<=3
            pitch(t)=a;
            avgF0=avgF0+a;
            m=m+1;
           end 
        end
     k=k+updRate;
end
figure(4)
subplot(211);
plot((1:length(x))/sr, x);
ylabel('����');
xlabel('ʱ��');
subplot(212);
xt=1:nFrames;
xt=20*xt;
plot(xt,pitch)
xlim([0,3]);
axis([xt(1) xt(nFrames) 0 max(pitch)+50]);
ylabel('����Ƶ��/HZ');
xlabel('ʱ��');
 
Mypitch = max(pitch)
if Mypitch>220
    pd = ['Woman  ', num2str(Mypitch)];
elseif Mypitch<200
    pd = ['Man  ', num2str(Mypitch)];
else pd = ['Sorry  ', num2str(Mypitch)];
end

