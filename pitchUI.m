
clear;clc;close all;
global n;
n=1;

set(0,'defaultfigurecolor','w');
%��һ��ͼ�ν���
con_car=figure('position',[400 200 680 380],...
                'numbertitle','off',...
                'name','Man or Woman');
set(con_car,'defaultuicontrolunits','normalized');

rbd=0;
con_rbd=uicontrol('Style','radiobutton',...
              'Position',[0.15  0.62  0.15  0.05],...
              'Value',rbd,...   rbd��ֵΪ0��1��ѡ��Ϊ1��δѡ��Ϊ0
              'String','���²���','backgroundcolor',get(gcf,'color'));

% �رհ�ť
con_close=uicontrol('style','pushbutton','position',[0.5 0.6 0.2 0.1],...
        'string','�ر�','callback','close');


% ���԰�ť
con_test=uicontrol('style','pushbutton','position',[0.3 0.6 0.2 0.1],...
        'string','����');       % [left bottom width height]

% ��ʾ�ַ�������һֱ˵�����Ͳ��Խ��
con_text=uicontrol('style','text','position',[0.3 0.1 0.4 0.4],...
        'FontSize',30,'string','��һֱ˵��','backgroundcolor',get(gcf,'color'));

% ����¼�����Գ���
set(con_test,'callback','test_record');

