'
Script: RDD - Analizando el paper de LEE
Módulo: Regresión Discontinua
Profesor: José Incio
'

# Removamos el directorio. 

rm(list=ls())

# Instalar paquetes.
library(ggplot2)
library(dplyr)
library(rdrobust)
library(rddensity)

# Obtenemos los datos

datosrd<-read.table("DataLee.txt",
                    header=TRUE,sep=",")

## Marcamos los el bandwith (h)

datosrd$tratamiento<-as.factor(ifelse(datosrd$difshare>0,1,0))
datosrd<-subset(datosrd,abs(difshare)<0.25)

## Filtramos los casos que son útiles para el análisis
datosrd<-subset(datosrd,use==1)

## Veamos los datos 

View(datosrd)

# Chequeemnos los supuestos 

# Graficar el cambio en la probabilidad de tratamiento cerca del umbral.

'
La gráfico muestra que efectivamente la probabilidd de victoria
en la primera elección se relaciona con el ganador.
cuando el margen es mayor a 0 entra a poder. 
'
ggplot(datosrd,aes(difshare,myoutcome))+
  geom_vline(xintercept=0,color="red")+
  geom_point(color="blue")+
  labs(title="Elecciones actuales",
       x="Margen de victoria",
       y="Probabilidad de victoria")

# Graficar el cambio la variable de resultado cerca del umbral.
ggplot(datosrd,aes(difshare,mmyoutcomenext,shape=tratamiento))+
  geom_vline(xintercept=0,color="red")+
  geom_point(color="blue")+
  #scale_shape_manual(values = c(1, 2))+
  labs(title="Elecciones siguientes",
       x="Margen de victoria",
       y="Probabilidad de victoria")

ggplot(datosrd,aes(difshare,myoutcomenext,shape=tratamiento))+
  geom_vline(xintercept=0,color="red")+
  geom_point(color="blue")+
  #scale_shape_manual(values = c(1, 2))+
  labs(title="Elecciones siguientes",
       x="Margen de victoria",
       y="Probabilidad de victoria")

### Veamos como se ve con las regresiones "locales'
ggplot(datosrd,aes(difshare,mmyoutcomenext,shape=tratamiento))+
  geom_vline(xintercept=0,color="red")+
  geom_point(color="blue")+
  geom_smooth(method=lm,se=FALSE,color="black")+
  theme(legend.position = "none")+
  labs(title="Elecciones siguientes",
       x="Margen de victoria",
       y="Probabilidad de victoria")

# Estimar el efecto utilizando la regresi?n lineal.
reg<-lm(myoutcomenext~difshare*tratamiento,data=datosrd)
summary(reg)

# Aquí agregandole peso a los puntos que están más cerca del punto de corte
rdplot(datosrd$mmyoutcomenext,datosrd$difshare,
       x.lab="Margen de victoria",y.lab="Probabilidad de victoria", title = "Elecciones siguientes")

# Regresión robusta

reglocal<-rdrobust(datosrd$myoutcomenext,datosrd$difshare,c = 0,all=TRUE)
summary(reglocal)

# Test formal de McCrary (2007).
'
La hipótesis nula es que la densidad es continua. 
'
mccrary<-rddensity(X = datosrd$difshare, vce="jackknife")
summary(mccrary)

## Densidad McCrary 

rdplotdensity(mccrary,X = datosrd$difshare)

## Continuidad de variables independientes (gráfico)
rdplot(datosrd$mofficeexp,datosrd$difshare,
       x.label="Margen de victoria",y.label="Victorias en el pasado", title = "Elecciones siguientes",
       p=1)


