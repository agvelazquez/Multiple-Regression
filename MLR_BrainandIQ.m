clc;
clear all;
close all;

%% load data
data1 = xlsread('LRdata.xlsx','(H2:K39)');

PIQ = data1(:,1);
Brain = data1(:,2);
Height = data1(:,3);
Weight = data1(:,4);

X = [Brain, Height, Weight];
y = [PIQ];
corrplot(X,'testR','on')
%% grafico
figure
a1= subplot (3,3,1);
scatter (a1, Brain, PIQ) 
ylabel(a1, 'PIQ')
xlabel(a1, 'Brain')
a2= subplot (3,3,2);
scatter (Height, PIQ)
a3= subplot (3,3,3);
scatter (Weight, PIQ)
a5= subplot (3,3,5);
scatter (Height, Brain)
ylabel (a5, 'Brain')
xlabel(a5, 'Height')
a9= subplot (3,3,6);
scatter (Weight, Brain)
a9= subplot (3,3,9);
scatter (Weight, Height)
ylabel (a9, 'Height')
xlabel(a9, 'Weight')

%% Multiple regression model

mdl = fitlm(X,y)
ypred = predict(mdl,X);
e = PIQ - ypred;
VIF = vif(X)
%% Verificacion de los supuestos
%% Residuals vs Fitted value
figure
scatter (ypred, e)

%% Residual vs Predictors

figure
subplot(3,1,1)
scatter (Brain,e)
subplot(3,1,2)
scatter (Height,e)
subplot(3,1,3)
scatter (Weight,e) %no hay una tendencia lineal alrededor de cero por lo cual deberia quitarse del modelo
%existe una especie de curva (ups and downs) pero al ser poca la muestra no
%podemos decir mucho

%% Normalidad de e
figure
hist(e)
%no tiene la curva normal pero la muestra es baja para decir algo 
%tener en cuenta que queda afectado por el tamaño de las barras
pd = fitdist(e,'Normal')
figure
normplot(e)

%% Nuevo modelo sin Weight
Xb = [Brain, Height];
mdl2 = fitlm(Xb,y)