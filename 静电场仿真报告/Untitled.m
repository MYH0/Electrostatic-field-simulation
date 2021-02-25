%****************************清空*****************************************%
clc;clear;
%****************************操作*****************************************%
results = ones(150, 1);         %存储不同alpha的迭代次数
 
for alpha = 1.01:0.01:1.99      %步长0.01寻找松弛因子最优解
    
    hx=101;hy=101;              %设置长、宽节点数
    v1=zeros(hy,hx);            %用0初始化
    v1(hy,:)=zeros(1,hx); 
    v1(1,:)=ones(1,hx)*100;     
    v1(:,1)=zeros(hy,1); 
    v1(:,hx)=zeros(hy,1); 
 
    v2=v1;                      %初始化结果
    maxt=1;
    t=0; 
    iteration=0;                %本次迭代次数
    while(maxt>1e-5)            %设置精度跳出迭代
        iteration=iteration+1;
        maxt=0;
        for i=2:hy-1
            for j=2:hx-1        
                v2(i,j)=v1(i,j)+(v1(i,j+1)+v1(i+1,j)+v2(i-1,j)+v2(i,j-1)-4*v1(i,j))*alpha/4;
                t=abs(v2(i,j)-v1(i,j));
                if(t>maxt)
                    maxt=t;
                end
            end
        end
        v1=v2;
    end
    results(int16(alpha * 100) - 100, 1) = iteration;
end
 
%************************************绘图*********************************%
clf
subplot(1,2,1),mesh(v2) 
axis([0,101,0,101,0,100]) 
subplot(1,2,2),contour(v2,15) 
hold on 
axis([-1,102,-1,110]) 
plot([1,1,hx,hx,1],[1,hy+1,hy+1,1,1],'r') 
text(hx/2,0.3,'0V','fontsize',11); 
text(hx/2-0.5,hy+0.5,'100V','fontsize',11); 
text(-0.5,hy/2,'0V','fontsize',11); 
text(hx+0.3,hy/2,'0V','fontsize',11); 
hold off
