#include <FreeRTOS_XSpace.h>

//Definimos las matrices
#define G11  0.6839
#define G12 -0.7547
#define G21 -0.2535
#define G22  0.2798

#define H1  -0.0111
#define H2  -0.0118

#define C1   21.5300
#define C2  -20.2500

//Definimos los puntos de operacion
#define PO_valv
#define PO_presion

//Sensor de presión
int PSI_sensor=A0;
//Pin de salida
int PWM_pin=10;

void setup() {

  Serial.begin(9600);
  pinMode(PSI_sensor,INPUT);  
  xTaskCreate(ControlPresion,"-", 600, NULL, 1, NULL);
  vTaskStartScheduler();
}

void loop() {
  // put your main code here, to run repeatedly:

}

void ControlPresion(void* Parameters){
  unsigned int temp;
  double presion;
  //Leemos valores entre 1V y 5V, que es lo mismo a obtener valores
  //entre 205 y 1023 por la resolución de 10 bits en arduino MEGA. 
  //Además, el valor umbral del ADC entre 205 y 204 es 0.9995V. Y dado que solo
  //recibimos valores mayores o iguales a 1, el resultado que siempre brindará el ADC
  //será mayor o igual a 205. [1.002 V HASTA 5.000 V]
  //Podemos reducir el proceso de mapeo con la siguiente formula
  //presion=analogRead(PSI_sensor); presion=(presion*5/1023-1)/4*120; 
  //Que es lo mismo a:   presion=(analogRead(PSI_sensor)*0.0048875855327468-1)*30;
  
  //Definimos los valores de las contantes del control
  double K1=1.8986;
  double K2=275.5207;
  double K3=-293.8739;
  //Definimos los valores del observador
  double Ke1=0.0315;
  double Ke2=-0.0117;
  //Especificamos el valor de referencia
  double ref_presion=45;//Colocamos la referencia
  //creamos la variable de error de referencia y de estimacion
  double e_ref,e_est;
  //inicializamos las variables de estimación
  x1_est=0;
  x2_est=0;
  //Realizamos el control
  while(1){
    //Controlador
    presion=(analogRead(PSI_sensor)*0.0048875855327468-1)*30;
    e_ref=(ref_presion-PO_presion)-(presion-PO_presion);
    u=(e_ref+e_ref_1)*K1-K2*x1_est-K3*x2_est;
    e_ref_1=e_ref;
    //Observador
    presion_est=C1*x1_est+C2*x2_est;
    e_est=presion-presion_est
    x1_est=G11*x1_est+G12*x2_est+H1*u+Ke1*e_est;//estimamos los nuevos valores
    x2_est=G21*x1_est+G22*x2_est+H2*u+Ke2*e_est;//estimamos los nuevos valores
    //Adicionamos el punto de operación y enviamos el PWM
    temp=(unsigned int)((u+PO_valv)/100*255);
    analoglWrite(PWM_pin,temp);
    vTaskDelay(400/portTICK_PERIOD_MS);// tiempo de muestreo de 400ms
  }
  vTaskDelete(NULL); //Eliminamos la tarea  
}
