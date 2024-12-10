# Curso de Inferencia Causal y Econometr?a Avanzada
# Agencia de los Estados Unidos para el Desarrollo Internacional
# M?dulo 5: Regresión Discontinua (RD)
# Fecha: 20 de julio de 2021
# Instructor: Profesor Alejandro Estefan

# Limpiar el espacio de trabajo y escoger el folder de trabajo.
rm(list=ls())
setwd("C:/Users/mestefan/Documents/Teaching/Paraguay USAID/Lectures/Lecture 5 - RDD/Ejercicio de R")

# Instalar paquetes.
library(ggplot2)
library(dplyr)
#install.packages('rdrobust')
library(rdrobust)
library(rddensity)

# Obtener datos.
datosrd<-read.table("DataLee.txt",header=TRUE,sep=",")
datosrd$tratamiento<-as.factor(ifelse(datosrd$difshare>0,1,0))
datosrd<-subset(datosrd,abs(difshare)<0.25)
datosrd<-subset(datosrd,use==1)

# Mostrar datos.
head(datosrd)

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


# Agregar una l?nea de regresi?n segmentada.
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

# Gr?fico con regresi?n local lineal de Skovron y Titinuik(2015).
rdplot(datosrd$mmyoutcomenext,datosrd$difshare,
       x.lab="Margen de victoria",y.lab="Probabilidad de victoria", title = "Elecciones siguientes")

# Estimar el efecto utilizando la regresi?n local lineal de Skovron y Titinuik(2015).
reglocal<-rdrobust(datosrd$myoutcomenext,datosrd$difshare,c = 0,all=TRUE)
summary(reglocal)

# Test formal de McCrary (2007).
'
La hipótesis nula es que la densidad es continua. 
'
mccrary<-rddensity(X = datosrd$difshare, vce="jackknife")
summary(mccrary)

# Test gr?fico de McCrary (2007).
rdplotdensity(mccrary,X = datosrd$difshare)

# Continuidad de variables independientes (gr?fico)
rdplot(datosrd$mofficeexp,datosrd$difshare,
       x.label="Margen de victoria",y.label="Victorias en el pasado", title = "Elecciones siguientes",
       p=1)

# Limpiar el espacio de trabajo
rm(list=ls())

