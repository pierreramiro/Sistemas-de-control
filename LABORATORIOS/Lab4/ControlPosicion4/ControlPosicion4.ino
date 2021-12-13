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
volatile double Contador_1 = 0;

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

  xTaskCreate(ControlPosicion,"-", 600, NULL, 1, NULL); //MotorA + Encoder 1
  vTaskStartScheduler();
}

void loop() {
  // put your main code here, to run repeatedly:

}

void ControlPosicion(void* Parameters){
  double vm = 5;
    //Controlador P
      //double K0=0.026;
    //Control cascada
  double Ts=0.014285714285714;
  double K=3.201953326228203;
  double Kd=0.0213908809213747;
  double Ki=-0.580631241535925;
  double e_1=0;
  double x_1=0;

  double theta,w,u;
  double e,x;
  double r=-205;//establecer la pocisión
  //por simulación el momento que empiezan a haber picos es a 330°
  //experimentalmente resulta que se presentan sobreimpulsos a 205°
  while(1){
    theta=Contador_1*0.375;//Formula para convertir los ticks del encoder a angulos 
    w=375000.0/Periodo_1;//Formula para obtener la velocidad
    //establecer controlador
      //Control P: 
        //r_int=K*(r-theta);
      //Sistema Lazo interno
      e=K*(r-theta)-w;
      x=x_1+Ts/2*(e+e_1);
      u = -Kd*w-Ki*x;
      e_1=e;
      x_1=x;
    //hacer saturador
    if (u>=5) u=5;
    if (u<=-5) u=-5;
    if(u<0) digitalWrite(BIN1,HIGH);// Si BIN1==HIGH -> NEGATIVO, Si AIN1==LOW -> POSITIVO
    else    digitalWrite(BIN1,LOW);
    
    int Duty = (int) ((abs(u)/vm)*PWM_resolucion);
    XSpace_SetDuty(PWMB,Duty);
    Serial.println(theta);
    vTaskDelay(14/portTICK_PERIOD_MS); //    
  }
  vTaskDelete(NULL); //Eliminamos la tarea, en caso de error del while
}

/* 
  Rutina de interrupción externa para calcular el periodo 
  entre flancos de subida en el canal A del conector ENCODER 1.
*/
void ISR_ENCODER_1(){
  
  T_act_1 = micros();
  
  Periodo_1 = T_act_1 - T_ant_1;

  if(digitalRead(ENCODER1_CH_B) == LOW){ 
    Periodo_1 = Periodo_1*(-1);
    Contador_1--;
  } else{
    Contador_1++;
  }
  T_ant_1 = T_act_1;
}
