Feature: Administrar uma conta API

Scenario: Cadastrar uma conta com sucesso
	Given o nome de usuário "bafm" ou email "bafm@cin.ufpe.br" não existe no UserService
	When uma requisição POST é enviada para "/user/create_user" com os dados
		| id | name   | surname  | username | email               | password | same_password |
		|  1 | Breno  | Miranda  | bafm     | bafm@cin.ufpe.br    | senha123 | senha123      |
	Then o status da resposta deve ser "201"
	And o JSON da resposta deve conter o nome de usuário "bafm" 
	And o usuário com o nome de usuário "bafm" está cadastrado no UserService

Scenario: Cadastrar uma conta com e-mail já existente
	Given o UserService possui os usuários
		| id | name   | surname  | username | email               | password | same_password |
		| 1  | Breno  | Miranda  | bafm     | bafm@cin.ufpe.br    | senha123 | senha123      |
	When uma requisição POST é enviada para "/user/create_user" com os dados
		| id | name   | surname  | username | email               | password | same_password |
		| 1  | Breno  | Miranda  | bafm1    | bafm@cin.ufpe.br    | senha123 | senha123      |
	Then o status da resposta deve ser "409"
	And a resposta deve conter uma mensagem de erro "Email indisponivel"
	And o usuário com o nome de usuário "bafm" está cadastrado no UserService

Scenario: Cadastrar uma conta sem e-mail
	Given o nome de usuário "bafm" ou email "bafm@cin.ufpe.br" não existe no UserService
	When uma requisição POST é enviada para "/user/create_user" com os dados
		| id | name   | surname  | username | email               | password | same_password |
		| 1  | Breno  | Miranda  | bafm     |                     | senha123 | senha123      |
	Then o status da resposta deve ser "400"
	And a resposta deve conter uma mensagem de erro "Email é um campo obrigatório."

Scenario: Deletar uma conta com senha correta
	Given o UserService possui os usuários
		| id | name   | surname  | username | email               | password | same_password |
		| 1  | Breno  | Miranda  | bafm     | bafm@cin.ufpe.br    | senha123 | senha123      |
	When uma requisição DELETE for enviada para "/user/delete_user/1" com a senha "senha123"
	Then o status da resposta deve ser "200"
	And o usuario com o nome de usuário "bafm" não está cadastrado no UserService

Scenario: Deletar uma conta com senha incorreta
	Given o UserService possui os usuários
		| id | name   | surname  | username | email               | password | same_password |
		| 1  | Breno  | Miranda  | bafm1    | bafm1@cin.ufpe.br   | senha123 | senha123      |
	When uma requisição DELETE for enviada para "/user/delete_user/1" com a senha "senha12"
	Then o status da resposta deve ser "400"
	And a resposta deve conter uma mensagem de erro "Senha incorreta. A conta não foi deletada."

Scenario: Editar o nome de usuário de uma conta com sucesso
	Given o UserService possui os usuários
		| id | name   | surname  | username | email               | password | same_password |
		| 1  | Breno  | Miranda  | bafm2    | bafm1@cin.ufpe.br   | senha123 | senha123      |
	When uma requisição PUT é enviada para "/user/update_user/1" com os dados
		| id | name   | surname  | username | email               | password | same_password |
		| 1  | Breno  | Miranda  | bafm1    | bafm1@cin.ufpe.br   | senha123 | senha123      |
	Then o status da resposta deve ser "200"
	And o JSON da resposta deve conter o nome de usuário "bafm1" 

Scenario: Editar nome de usuário por um já existente
	Given o UserService possui os usuários
		| id | name   | surname  | username | email               | password | same_password |
		| 1  | Breno  | Miranda  | bafm1    | bafm1@cin.ufpe.br   | senha123 | senha123      |
		| 2  | Breno  | Miranda  | bafm     | bafm@cin.ufpe.br    | senha123 | senha123      |
	When uma requisição PUT é enviada para "/user/update_user/1" com os dados
		| id | name   | surname  | username | email               | password | same_password |
		| 1  | Breno  | Miranda  | bafm     | bafm1@cin.ufpe.br   | senha123 | senha123      |
	Then o status da resposta deve ser "409"
	And a resposta deve conter uma mensagem de erro "Nome de usuário indisponivel"

Scenario: Editar conta sem preencher usuário
	Given o UserService possui os usuários
		| id | name   | surname  | username | email               | password | same_password |
		| 1  | Breno  | Miranda  | bafm1    | bafm1@cin.ufpe.br   | senha123 | senha123      |
	When uma requisição PUT é enviada para "/user/update_user/1" com os dados
		| id | name   | surname  | username | email               | password | same_password |
		| 1  | Breno  | Miranda  |          | bafm1@cin.ufpe.br   | senha123 | senha123      |
	Then o status da resposta deve ser "400"
	And a resposta deve conter uma mensagem de erro "Nome de usuário é um campo obrigatório."

# Feature: Administrar uma conta
# 	As a usuário 
# 	I want to ser capaz de cadastrar, atualizar e deletar uma conta
# 	So that possa administrar uma conta no sistema de reviews

# Scenario: Cadastrar uma conta com todas as informações corretas
# 	Given estou na página “Cadastrar Conta”
# 	When preencho nome “Breno”, sobrenome "Miranda", nome de usuário “bafm”, senha “senhaTeste” e repito a senha “senhaTeste”
# 	And adiciono a foto "fotoPerfil.jpg"
# 	Then estou na página “Página Inicial”
# 	And estou logado como "bafm"

# Scenario: Cadastrar uma conta com um nome de usuário já existente
# 	Given estou na página “Cadastrar Conta”
# 	And existe um usuário com nome de usuário “bafm”
# 	When preencho nome “Breno”, nome de usuário “bafm”, e-mail “bafm@cin.ufpe.br", senha “senhaTeste” e repito a senha “senhaTeste” 
# 	Then estou na página “Cadastrar Conta”
#   And vejo a mensagem “Nome de usuário indisponivel”

# Scenario: Cadastrar uma conta com um e-mail já existente
# 	Given estou na página “Cadastrar Conta”
# 	And existe um usuário com e-mail “bafm@cin.ufpe.br”
# 	When preencho nome “Breno”, nome de usuário “bafm”, e-mail “bafm@cin.ufpe.br", senha “senhaTeste” e repito a senha “senhaTeste” 
# 	Then estou na página “Cadastrar Conta”
#   And vejo a mensagem “Nome de usuário indisponivel”

# Scenario: Cadastrar uma conta sem o nome
# 	Given estou na página “Cadastrar Conta”
# 	When preencho nome de usuário “bafm”, senha “senhaTeste” e repito a senha “senhaTeste” 
# 	Then estou na página “Cadastrar Conta”
# 	And vejo a mensagem “Nome é um campo obrigatório”

# Scenario: Cadastrar uma conta com duas senhas diferentes
# 	Given estou na página “Cadastrar Conta”
# 	When preencho nome “Breno”, nome de usuário “bafm”, senha “senhaTeste” e repito a senha “senhaTeste2” 
# 	Then estou na página “Cadastrar Conta”
# 	And vejo a mensagem “As senhas não são iguais”

# Scenario: Deletar uma conta com senha correta
# 	Given estou logado com o nome de usuário "bafm"
# 	And estou na página "Deletar Perfil"
# 	When preencho senha "senhaTeste"
# 	Then estou na página "Login"
# 	And não estou logado no sistema

# Scenario: Deletar uma conta com senha incorreta
# 	Given estou logado com o nome de usuário "bafm"
# 	And estou na página "Deletar Perfil"
# 	When preencho senha "senhaTeste2"
# 	Then estou na página "Login"
# 	And estou logado como "bafm"

# Scenario: Editar nome de usuário com sucesso
# 	Given estou logado com o nome de usuário "bafm"
# 	And estou na página "Atualizar Cadastro de Usuário"
# 	When preencho nome de usuário "brenomiranda"
# 	And nome de usuário "brenomiranda" está disponível
# 	Then estou na página "Perfil"
# 	And estou logado com o nome de usuário "brenomiranda" 

# Scenario: Editar nome de usuário por um já existente
# 	Given estou logado com o nome de usuário "bafm"
# 	And estou na página "Atualizar Cadastro de Usuário"
# 	When preencho nome de usuário "brenomiranda"
# 	And nome de usuário "brenomiranda" não está disponível
# 	Then vejo uma mensagem "Nome de usuário não disponível"
# 	And estou na página "Atualizar Cadastro de Usuário"
# 	And estou logado com o nome de usuário "bafm" 