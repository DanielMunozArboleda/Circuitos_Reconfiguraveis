# Projeto com Circuitos Reconfiguraveis - Plano de Ensino
Repositório da disciplina de Projeto com Circuitos Reconfiguráveis do curso de Engenharia Eletrônica da Faculdade UnB Gama. | Repository for the discipline  Reconfigurable Circuits Design at the Electronics Engineering course at Faculty of Gama, University of Brasilia, Brazil.

## Metodologia de ensino
O curso é composto de aulas teóricas e de experimentos em laboratório. As aulas são ministradas em períodos de 1h50 (uma hora e cinquenta minutos).

## Conhecimentos prévios desejados
VHDL, arquitetura de computadores, microcontroladores

## Programa
### 1. Introdução: hardware reconfigurável e sua evolução histórica:
*	Por que usar Circuitos Reconfiguráveis?
*	Implementação de circuitos digitais
*	Comparação entre ASICs, FPGAs, Microprocessadores
### 2.	Conceitos básicos de Projeto com Dispositivos Lógicos Programáveis (nivelamento):
*	Níveis de abstração de projeto. Domínios de representação
*	Fluxo de projeto
*	Linguagens de descrição de hardware
*	Arquitetura Interna de um FPGA. Plataformas comerciais e tecnologias
*	Ferramentas EDA. Ferramentas de simulação comportamental e funcional 
### 3. Projeto Lógico Combinacional em FPGAs (nivelamento):
*	Descrição hardware de funções booleanas
*	Descrição hardware de processos combinacionais
*	Descrição hardware de decodificadores e muxes
*	Simulação de circuitos combinacionais.
### 4.	Projeto Lógico Sequencial em FPGAs (nivelamento):
*	Descrição hardware de flip-flops, latches e registradores
*	Descrição hardware de máquinas de estados finitos
*	Descrição hardware de somadores, comparadores, shifters, contadores, multiplicadores.
*	Simulação de circuitos sequenciais
### 5. Uso de Blocos de Propriedade Intelectual (IP-Cores):
*	Aritmética de ponto fixo vs aritmética de ponto flutuante
*	Instanciação de IPs
*	Configuração de IPs
### 6.	Simulação automática:
*	Criação de Testbenches para leitura e escrita de dados
*	Simulação funcional
*	Ferramentas de co-simulação
### 7. Análise de Arquiteturas de Hardware:
*	Estimação do consumo de recursos de hardware, Otimização e trafeoff.
*	Estimação de tempo de execução. Análise de Timming. Otimização e trafeoff.
*	Estimação do consumo de potência. Otimização e trafeoff.
### 8.	Projeto com o microprocessador ARM e MicroBlaze:
*	Arquitetura do ARM na plataforma Zynq 
*	Barramentos AXI, LMB e PLB
*	Arquitetura do MicroBlaze
*	Projeto com ARM
*	Projeto com MicroBlaze
### 9.	Co-projeto Hardware-Software:
*	Análise de desempenho. Code Profiling usando GPROF
*	Particionamento HW/SW.
*	Aceleradores de hardware no ARM e MicroBlaze
*	Sistema em Chip usando ARM e MicroBlaze
*	Uso da biblioteca RTOS
*	Análise de desempenho HW/SW
*	Estimação do consumo de recursos
### 10. Tópicos especiais com circuitos reconfiguráveis:
*	Uso do conversor XADC
*	Técnicas de tolerância a falha
*	Modelagem em alto nível de abstração (HLS)
*	Reconfiguração dinâmica parcial

## Avaliação
A avaliação é constituída por uma prova, listas de exercícios e um projeto final. 

A __prova__ consistirá na implementação e caracterização de um circuito digital usando projeto RTL. A implementação será realizada em sala de aula (duração de 1 hora e 50 minutos) e a caracterização será feita em casa e deverá ser entregue 48 horas depois.

As __listas de exercícios__ são individuais. Deverão ser entregues os arquivos necessários para replicar os resultados. Os principais resultados e conclusões deverão ser anotados em uma folha de dados fornecida pelo professor.

Os estudantes deverão formar duplas para elaborar o __projeto final__, cobrindo os tópicos vistos em sala de aula. Será entregue um protótipo em funcionamento acompanhado de um relatório científico no formato IEEE. Os projetos serão propostos pelos estudantes e devem abordar implementações em hardware e software. O andamento do projeto final será acompanhado através de três pontos de controle (PC).

São esperados os seguintes resultados em cada ponto de controle:
* PC1: proposta do projeto (justificativa, objetivos, metodologia, revisão bibliográfica)
* PC2: implementação e caracterização dos módulos de hardware (VHDL).
* PC3: co-projeto HW/SW, implementação da(s) aplicações de software e conexão com co-processadores.

A nota final (NF) na disciplina será calculada da seguinte maneira:

NF = NP * 0.3 + NL * 0.3 + NPF * 0.4

Sendo, 
* NP: Nota da prova
* NL: média aritmética das listas de exercícios
* NPF: Nota do projeto final

A Aprovação ou Reprovação do Curso de Projeto com Circuitos Reconfiguráveis será obtida se:
* Aprovação: se NF ≥ 5,0 e se percentual de faltas (PF) < 25%. Onde PF é dado pelo número de aulas com faltas registradas dividido pelo número de aulas ministradas.
* Reprovação: se NF < 5,0 ou se PF > 25%, então o aluno será considerado reprovado por nota ou por falta.

## Horário de aulas
Terça-feira entre 08:00 e 09:50 Lab. SS – UED - FGA

Quinta-feira entre 08:00 e 09:50 Lab. SS – UED - FGA

## Avisos
* A entrega de arquivos das prova, listas e projeto final deverá ser feita através usando repositório do github.
* Cada estudante deve criar um __ÚNICO__ repositório que será usado para esta disciplina durante todo o semestre. 
* Organize as entregas de arquivos usando pastas. Uma pasta para a prova, outra pasta para listas de exercícios e uma pasta para cada ponto de controle.
* A prova e lista de exercícios são individuais. 
* Não serão aceitos arquivos entregues fora do prazo para a prova e listas de exercícios.
* Haverá penalidade de 1 ponto por dia de atrás na entrega dos pontos de controle do projeto final.
* Usar template IEEE Conference para realização do relatório técnico.
* O relatório técnico do projeto final deverá conter as seguintes seções: resumo, introdução, desenvolvimento, resultados, conclusões e bibliografia. No __resumo__ deve-se descrever com poucas palavras (máximo 350 palavras) o projeto de forma geral e os resultados alcançados. Na __introdução__ deve-se descrever o problema a ser resolvido e a revisão bibliográfica. No __desenvolvimento__ deve-se incluir um diagrama de blocos que descreva a arquitetura de hardware e software proposta incluindo as interfaces de conexão entre módulos, diagramas de máquinas de estado (se aplica), e todos os parâmetros adotados para a solução encontrada. Nos __resultados__ deve-se explicar quais foram os protocolos de teste e os experimentos realizados para validar o desenvolvimento. Deve-se incluir o consumo de recursos de hardware, estimativa do consumo de energia, estimativa de desempenho em frequência de operação, prints de simulação, etc. Na __conclusão__ deve-se seguir uma analise crítica entre os resultados esperados os resultados alcançados. Em caso de divergência explicar como poderiam ser melhorados os resultados, quais modificações podem ser feitas na solução proposta para otimizar o circuito. A __bibliografia__ deve mostrar as principais referências usadas na revisão da literatura. __Nota:__ Não é necessário colocar como anexo o código fonte.
* Os FPGAs não poderão ser usados fora da sala de aula, mas não podem ser retirados da FGA. 
* Criar um usuário no site da Xilinx (www.xilinx.com)
* Instalar ferramenta Vivado e SDK (Software Development Kit) nos notebooks disponíveis. Nota: usar licença webpack edition.

## Bibliografia
Básica:
* Sass, R.S., Andrew, G., Embedded Systems Design with Platform FPGAs : Principles and Practices, Elsevier Science and Technology, 2010. (disponível na Minha Biblioteca)
* Hauck,  S.,  DeHon, A,  Systems on Silicon : Reconfigurable Computing : The Theory and Practice of FPGA-Based Computation, Morgan Kaufman Publishers, 2007. (disponível na Minha Biblioteca)
* Vahid, F., Digital Design, John Wiley & Sons, 2007.
* Chu, P.P., FPGA Prototyping by VHDL Examples: Xilinx Spartan-3 Version, Wiley, 2008

Complementar:
* Pedroni, V., Circuit Design with VHDL, MIT Press, 2004. (disponível na Minha Biblioteca)
* Brown, S., Vranesic, Z., Fundamentals of Digital Logic with VHDL Design, 2nd ed, McGraw Hill, 2005.
* Kilts, S., Advanced FPGA Design Architecture, Implementation and Optimization, John Wiley & Sons, 2007. (disponível na Minha Biblioteca)
* Bobda, C., Introduction to Reconfigurable Computing: Architectures, Algorithms and Applications, Springer, 2008. (disponível na Minha Biblioteca)
* Wakerly, J., Digital Design Principles & Practices, 3rd ed, Prentice Hall, 1999.
* Cardoso, J., Hubner, M., Reconfigurable Computing : From FPGAs to Hardware/Software Codesign, Spriger, 2011 (disponível na Minha Biblioteca)
* Maya, G., Paul, S., Reconfigurable Computing : Accelerating Computation with Field-Programmable Gate Arrays, Springer, 2005. (disponível na Minha Biblioteca)
* Zeidman, B., Designing with FPGAs and CPLDs, CMP Technology. (disponível na Minha Biblioteca)

## Proposta de calendário
Data  | Dia    | Aula                                                           | Observação 
------|--------|----------------------------------------------------------------|------------
14/03 | Quinta | Apresentação do curso                                          | 
19/03 |	Terça  | Níveis de Abstração, Arquitetura FPGA, Fluxo Projeto no Vivado |
21/03 | Quinta | Revisão projeto combinacional em VHDL                          |
26/03 |	Terça  | Revisão projeto sequencial em VHDL	                        | 
28/03 | Quinta | Simulação comportamental automática                            |
02/04 |	Terça  | Revisão FSMs em VHDL	                                        |
04/04 | Quinta | Aritmética de ponto fixo vs ponto flutuante                    | 
09/04 |	Terça  | IP-Cores: circuito digital usando ponto fixo	                |
11/04 | Quinta | IP-Cores: circuito digital usando ponto flutuante              |Ponto Controle 1
16/04 |	Terça  | IP-Cores: circuito digital usando ponto flutuante	        | 
18/04 | Quinta |Simulação: estimação do erro. Precisão como parâmetro de projeto|
23/04 |	Terça  |Análise e otimização de consumo de recursos usando FPGAs	|
25/04 | Quinta |Análise e otimização do tempo de execução em HW – timming	|
30/04 |	Terça  |Análise e otimização do tempo de execução em HW – timming	|
02/05 |	Quinta |Estimação de consumo de potência usando FPGAs			|
07/05 | Terça  |Prova								|
09/05 | Quinta |Co-projeto HW/SW: Analise de profile usando Gprof 		|Entrega prova
14/05 | Terça  |MicroBlaze – arquitetura interna 				|
16/05 | Quinta |Barramento AXI							|Ponto Controle 2
21/05 |	Terça  |Projeto com MicroBlaze/AXI/co-processadores			|
23/05 | Quinta |ARM/AXI - arquitetura interna					|
28/05 |	Terça  |Projeto com ARM/AXI						|
30/05 | Quinta |Projeto com ARM/AXI/co-processadores				|
04/06 |	Terça  |Projeto com ARM e biblioteca RTOS				|
06/06 | Quinta |Conceitos de projeto com tolerância a falha			|
11/06 |	Terça  |Projeto de tolerância a falha com FPGAs				|
13/06 | Quinta |Tópico especial SoC: conversor XADC 				|Ponto Controle 3
18/06 | Terça  |Tópico especial SoC: conversor XADC 				|
20/06 | Quinta |Feriado: Corpus Christi						|
25/06 |	Terça  |Tópico especial: Síntese de alto nível				|
27/06 | Quinta |Tópico especial: Síntese de alto nível 				|
02/07 |	Terça  |Tópico especial SoC: reconfiguração dinâmica parcial		|
04/07 | Quinta |Tópico especial SoC: reconfiguração dinâmica parcial 		|
09/07 | Terça  |Apresentação dos protótipos do projeto e entrega do relatório	|
11/07 | Quinta |Revisão de notas						|
12/07 | Terça  |								|
	
