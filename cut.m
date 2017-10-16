
function y1=cut(s_address)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function: cut() �Ѿ����βü���
% input :   ��Ƶ�ļ���ַ
% output:   �ü�֮�����Ƶ
% author:   yuhansgg��Shi Gaige��
% time:     2017.4.9
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y=audioread(s_address);
h=hamming(320);

% �����ʱƽ������SAE��short average energe��
%�źŵ�ƽ�����봰�������
% E(n)��[x(m)]^2*h(n-m),m�Ӹ������������ͣ�h(n-m)Ϊ������
e=conv(y.*y,h);    % y.*2��y�и�Ԫ��ƽ����conv(u,v) ��u��v�ľ��

% �������źŽ����и��SAEС��������ֵ��1/100ʱ����Ϊ�������յ�

mx=max(e);
n=length(e);
y(n)=0; % ��ԭʼ�����źž���������nά
for i=1:n
    if e(i)<mx*0.01
        e(i)=0;
    else e(i)=1;    % e�з�0������1������
    end
end
y1=y.*e;
y1(find(y1==0))=[]; % ��0Ԫ���޳�
fs=16000;
audiowrite(s_address,y1,fs);
