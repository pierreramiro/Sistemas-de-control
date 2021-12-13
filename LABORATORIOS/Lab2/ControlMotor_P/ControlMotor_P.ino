/*
 * ---------- OBTENCIÓN DE LA CURVA DE VELOCIDAD vs TIEMPO DEL MOTOR DC DEL KIT XSPACE v1.0----------
 * 
 * Descripción: Este programa puede obtener la curva de respuesta usando el conector Motor A o Motor B
 *              con el Encoder 1 o Encoder 2
 * Version:     1.0
 * Creador:     Pablo Cárdenas Cáceres
 * Fecha:       22-09-2021 12:18
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
 
  XSpace_PWMinit(PWM_resolucion);  //Configura los pines 9 y 10 como salidas PWM de 400 de resolucion. La Frecuencia de la señal será F_CPU/resolucion. F_CPU = 8000000 
  
  digitalWrite(STBY,HIGH); //Habilitamos el driver

  xTaskCreate(ControlVelocidad,"-", 600, NULL, 1, NULL);
  vTaskStartScheduler();
}

void loop() {
  // put your main code here, to run repeatedly:

}

void ControlVelocidad(void* Parameters){
  double vm = 5;
  double Kp;
  double e_1=0;
  double u_1=0;

  double w,u=0;
  double e=0;
  double r=-180;//establecer la velocidad de giro
  while(1){
    w=375000.0/Periodo_1;
    e=r-w;
    if (u_1>=-4 && u_1<=-3){
      Kp=0.006734256559278;
    }else if (u_1>-3 && u_1<=0){
      Kp=0.002980895175846;
    }else if (u_1>0 &&u_1<=4){
      Kp=0.006546034970580;
    }else{
      Kp=0;
    }
    u=e*Kp;
    //hacer saturador
    if (u>=4) u=4;
    if (u<=-4) u=-4;
    if(u<0) digitalWrite(BIN1,HIGH);// Si BIN1==HIGH -> NEGATIVO, Si AIN1==LOW -> POSITIVO
    else    digitalWrite(BIN1,LOW);
    
    int Duty = (int) ((abs(u)/vm)*PWM_resolucion);
    XSpace_SetDuty(PWMB,Duty);
    vTaskDelay(6/portTICK_PERIOD_MS); //Retardo de 1500ms (esta funcion solo acepta multiplos de 2)
    Serial.print(u);
    Serial.print(" ");
    Serial.println(w);
  }
  vTaskDelete(NULL); //Eliminamos la tarea  
}


/* 
  Rutinas de interrupcion externa para calcular periodos 
  entre flancos de subida en los canales A de los encoders
  1 y 2.
*/
void ISR_ENCODER_1(){
  
  T_act_1 = micros();
  
  Periodo_1 = T_act_1 - T_ant_1;

  if(digitalRead(ENCODER1_CH_B) == LOW) Periodo_1 = Periodo_1*(-1);
 
  T_ant_1 = T_act_1;
}
