
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

  xTaskCreate(TaskCurvaEntradaEscalon,"-", 600, NULL, 1, NULL); //MotorA + Encoder 1
  vTaskStartScheduler();
}

void loop() {
  // put your main code here, to run repeatedly:

}

void TaskCurvaEntradaEscalon(void* Parameters){
  double vm = 5;
  double vp=3;//Entrada de 3V
  //Se imprime el codigo necesario para MATLAB
  Serial.println("clc;clear;close all;");
  Serial.println(""); //linea en blanco
  digitalWrite(BIN1,HIGH);
  int Duty = (int) ((vp/vm)*PWM_resolucion);   
  XSpace_SetDuty(PWMB,Duty);
  //vTaskDelay(10/portTICK_PERIOD_MS); //Retardo de 10 ms (esta funcion solo acepta multiplos de 2)    
    
  //Se imprime un vector de velocidad vel=[.........];
  Serial.print("vel=[");
  for(double muestra=1; muestra<=520; muestra=muestra+1){
    vTaskDelay(2/portTICK_PERIOD_MS); //Retardo de 2 ms (esta funcion solo acepta multiplos de 2)    
    Serial.print(375000.0/Periodo_1); //unidades en °/seg
    Serial.print(" ");
  }
  XSpace_SetDuty(PWMB,0);
  digitalWrite(STBY,LOW); //Apagamos el driver
  
  Serial.println("];");
  
  Serial.println(""); //linea en blanco

  //Se imprime el codigo para graficar la curva estática
  Serial.println("plot(vel);");
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
