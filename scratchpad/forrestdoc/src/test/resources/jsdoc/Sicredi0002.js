/**
* @summary Fun��es de aux�lio � c�lculos monet�rios.
*/

Padr�o de codifica��o JavaScript:

Declara��o de vari�veis:

O nome da vari�vel dever� ser iniciado por letra min�scula,
e suas palavras n�o ser�o separadas por espa�o, e sim pela
inicial da palavra mai�scula.
Para cada declara��o de vari�vel, dever� ser inclu�do um 
coment�rio com a sua funcionalidade, como no exemplo:

var nomeCliente; // armazena o nome do cliente
var endResidCliente; // armazena o endere�o residencial do cliente;


Declara��o de fun��es:

O nome da fun��o dever� ser iniciado por letra min�scula,
e suas palavras n�o ser�o separadas por espa�o, e sim pela
inicial da palavra mai�scula.
Para cada declara��o de fun��o, dever� ser inclu�do um 
coment�rio com a sua funcionalidade, como no exemplo:

/**
* fecha uma modal que est� ativada 					
* @author Mailton Almeida											
* @param x: um par�metro qualquer												
* @return um retorno qualquer 
*/

function fechaModal(){
	...
}

/**
* fun��o de teste 					
* @author Mailton Almeida											
* @param nome: o nome do cliente
* @param agencia: a agencia onde o cliente possui conta
* @return a conta do cliente 
*/

function funcaoTeste(nome, agencia)
{
	...
}


Declara��o de blocos condicionais dever�o conter um
coment�rio ao final de cada bloco descrevendo a
condi��o de entrada para cada caso.
Trechos de c�digo que pertencerem a um bloco condicional
dever�o ser identados com um "tab".

Ex:

if(navigator.appName == "Netscape"){	//se o browser for o netscape	
	self.window.close();
}else{ 									//se o browser for o IE
	window.close();
}

