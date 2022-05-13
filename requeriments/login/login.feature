Feature: Login
Como um cliente, quero poder acessar a minha conta e me manter logado
Para que eu possa ver e responder enquetes de de forma rápida

Cenário: Credencias Válidas
Dado que o cliente informou credencias válidas
Quando solicitar para fazer o login
Então enviar para tela de pesquisas
E manter o usuário conectado

Cenário: Credenciais inválidas
Retornar mensagem de erro