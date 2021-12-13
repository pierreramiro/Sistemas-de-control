/*
 * ---------- OBTENCIÓN DE LA CURVA ESTÁTICA (VOLTAJE VS VELOCIDAD) DEL MOTOR DC DEL KIT XSPACE v1.0----------
 * 
 * Descripción: Este programa puede obtener la curva de respuesta usando el conector Motor A + Encoder 1
 * 
 * Version:     1.0
 * Creador:     Pablo Cárdenas Cáceres
 * Fecha:       21-09-2020 10:17
 *  
 */

#include <FreeRTOS_XSpace.h>

//STANDBY DEL TB6612FNG
#define STBY 8

//PARA CONTROLAR CON EL CONECTOR MOTOR A
#define BIN1 7
#define PWMB 10

//PARA SENSAR CON EL CONECTOR ENCODER 1
#define ENCODER1_CH_A 2
#define ENCODER1_CH_B 4


//Variables para el Encoder 1
volatile double T_act_1 = 0;
volatile double T_ant_1 = 0;
volatile double Periodo_1 = 100000000;

//Variables globales
uint16_t PWM_resolucion = 400;

void setup() {

  Serial.begin(9600);
  
  pinMode(STBY,OUTPUT);
  pinMode(BIN1,OUTPUT);

  pinMode(ENCODER1_CH_A, INPUT_PULLUP);
  pinMode(ENCODER1_CH_B, INPUT_PULLUP);

  attachInterrupt(digitalPinToInterrupt(ENCODER1_CH_A), ISR_ENCODER_1, RISING); //Activamos la interrupcion por flanco de subida en el canal A del encoder 1

  XSpace_PWMinit(PWM_resolucion); //Configura los pines 9 y 10 como salidas PWM de 400 de resolucion. La Frecuencia de la señal será F_CPU/resolucion
  
  digitalWrite(STBY,HIGH); //Habilitamos el driver

  xTaskCreate(TaskCurvaEstaticaMotorA,"-", 600, NULL, 1, NULL); //MotorA + Encoder 1
  vTaskStartScheduler();
}

void loop() {
  // put your main code here, to run repeatedly:

}

void TaskCurvaEstaticaMotorA(void* Parameters){
  double vm = 5;
  
  //Se imprime el codigo necesario para MATLAB
  Serial.println("clc;");
  Serial.println("clear;");
  Serial.println("close all;");
  Serial.println(""); //linea en blanco
  Serial.println(""); //linea en blanco
  
  //Se imprime un vector de velocidad vel=[.........];
  Serial.print("vel=[");
  for(double u=-4.0; u<=4.2; u=u+0.2){
    if(u<0) digitalWrite(BIN1,HIGH);// Si BIN1==HIGH -> NEGATIVO, Si AIN1==LOW -> POSITIVO
    else    digitalWrite(BIN1,LOW);
    
    int Duty = (int) ((abs(u)/vm)*PWM_resolucion);
    XSpace_SetDuty(PWMB,Duty);

    vTaskDelay(1500/portTICK_PERIOD_MS); //Retardo de 1500ms (esta funcion solo acepta multiplos de 2)
    
    Serial.print(375000.0/Periodo_1);
    Serial.print(" ");
    
  }
  analogWrite(PWMB,0);
  digitalWrite(STBY,LOW); //Apagamos el driver
  
  Serial.println("];");
  
  //Se imprime el vector de entrada
  Serial.println("u= -4 : 0.2 : 4;");

  Serial.println(""); //linea en blanco
  Serial.println(""); //linea en blanco

  //Se imprime el codigo para graficar la curva estática
  Serial.println("plot(u,vel);");

  vTaskDelete(NULL); //Eliminamos la tarea
  
 }



/* 
  Rutina de interrupción externa para calcular el periodo 
  entre flancos de subida en el canal A del conector ENCODER 1.
*/
void ISR_ENCODER_1(){
  
  T_act_1 = micros();
  
  Periodo_1 = T_act_1 - T_ant_1;

  if(digitalRead(ENCODER1_CH_B) == LOW) Periodo_1 = Periodo_1*(-1);
 
  T_ant_1 = T_act_1;
}
