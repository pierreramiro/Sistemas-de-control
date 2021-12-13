
#include <FreeRTOS_XSpace.h>

//De MATLAB obtenemos el array usando la siguiente linea de cógido
//t=linspace(0,2,25);seno_values=2.5*sin(pi*t)+2.5;regexprep(num2str(seno_values),'\s+',',')
const double sin_val[25]={2.5,3.147,3.75,4.2678,4.6651,4.9148,5,4.9148,4.6651,4.2678,3.75,3.147,2.5,1.853,1.25,0.73223,0.33494,0.085185,0,0.085185,0.33494,0.73223,1.25,1.853,2.5}; 

//STANDBY DEL TB6612FNG
#define STBY 8

//PARA CONTROLAR CON EL CONECTOR MOTOR A
#define BIN1 7
#define PWMB 10

//PARA SENSAR CON EL CONECTOR ENCODER 1
#define ENCODER1_CH_A 2
#define ENCODER1_CH_B 4

//Para encender LED
#define LED 9

//Variables para el Encoder 1
volatile double T_act_1 = 0;
volatile double T_ant_1 = 0;
volatile double Periodo_1 = 100000000;

//Variables globales
uint16_t PWM_resolucion = 400;
double Vout;
void setup() {

  Serial.begin(9600);
  
  pinMode(STBY,OUTPUT);
  pinMode(BIN1,OUTPUT);

  pinMode(ENCODER1_CH_A, INPUT_PULLUP);
  pinMode(ENCODER1_CH_B, INPUT_PULLUP);

  attachInterrupt(digitalPinToInterrupt(ENCODER1_CH_A), ISR_ENCODER_1, RISING); //Activamos la interrupcion por flanco de subida en el canal A del encoder 1

  XSpace_PWMinit(PWM_resolucion); //Configura los pines 9 y 10 como salidas PWM de 400 de resolucion. La Frecuencia de la señal será F_CPU/resolucion
  
  digitalWrite(STBY,HIGH); //Habilitamos el driver

  xTaskCreate(Task1,"-", 200, NULL, 1, NULL); 
  xTaskCreate(Task2,"-", 200, NULL, 2, NULL); 
  xTaskCreate(Task3,"-", 200, NULL, 3, NULL); 
  vTaskStartScheduler();
}

void loop() {
  // put your main code here, to run repeatedly:

}

void Task1(void* Parameters){
  double T_triangle=3000,V_max=3,vm=5,delta_T=T_triangle/30;// un total de 100 pasos
  double m,vp,delta_volt;
  m=V_max/T_triangle;
  delta_volt=m*delta_T;
  digitalWrite(BIN1,LOW);
  while(1){
    for(Vout= 0; Vout<=3; Vout=Vout+delta_volt){
      int Duty = (int) ((Vout/vm)*PWM_resolucion);     
      XSpace_SetDuty(PWMB,Duty);
      vTaskDelay(delta_T/portTICK_PERIOD_MS);    
    }
  }
  //vTaskDelete(NULL); //Eliminamos la tarea
}

void Task2(void* Parameters){
  double Vel_motor;
  while(1){
    Vel_motor =375000.0/Periodo_1;
    Serial.print(Vout);
    Serial.print(",");
    Serial.println(Vel_motor);  
    vTaskDelay(10/portTICK_PERIOD_MS); //delay de 10ms 
  }
  vTaskDelete(NULL); //Eliminamos la tarea
}

void Task3(void* Parameters){
  double vm=5;
  while(1){
    for (int i=0; i<25;i=i+1){
      int Duty = (int) ((sin_val[i]/vm)*PWM_resolucion);     
      XSpace_SetDuty(LED,Duty);
      vTaskDelay(80/portTICK_PERIOD_MS); //25 pasos
    }
  }
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
