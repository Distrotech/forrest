/**
* @summary Fun��es para valida��o de campos de formul�rio.afasdafasdfas
* @summary Fun��es para formata��o de CPF, CNPJ, e CC. 
* 
*/

Padr�o de codifica��o JavaScript:

Variable declaration:

The name of the variables has to start with a lower-case letter, 
and the words composing the name must not be separated by a space,
but should start with a higher-case letter. 

For every variable declaration, there should be included a 
comment on its functionality, as in the following example: 

var customerName; // the name of the client
var customerAddress; // the office address of the client


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

