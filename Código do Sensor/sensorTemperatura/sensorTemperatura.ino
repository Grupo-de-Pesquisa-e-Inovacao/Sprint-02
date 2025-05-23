// Definições dos pinos e variáveis

// Pino da placa Arduino que esta conectado ao sensor LM35
const int PINO_SENSOR_TEMPERATURA = A0;

// Variável para armazenar a temperatura em Celsius 
float temperaturaCelsius; 

// Função de inicialização
void setup() {
  // Inicializa a comunicação serial a 9600 bps
  Serial.begin(9600);  
}

// Função principal de execução contínua
void loop() {

  // Lê o valor analógico do sensor
  int valorLeitura = analogRead(PINO_SENSOR_TEMPERATURA);
  
  // Converte o valor lido para Celsius 
  temperaturaCelsius = ((valorLeitura * 5.0 / 1023.0) / 0.01) ;
  
  // Exibe a temperatura no gráfico
  Serial.println(temperaturaCelsius);

  // Espera 5 segundos para proxima execução
  delay(3000);
}