extends CanvasLayer

# Variáveis que armazenam os elementos da UI
@onready var question_text = $Content/QuestionInfo/QuestionText
@onready var button_option_1 = $Content/QuestionHolder/ButtonOption1
@onready var button_option_2 = $Content/QuestionHolder/ButtonOption2
@onready var button_option_3 = $Content/QuestionHolder/ButtonOption3
@onready var button_option_4 = $Content/QuestionHolder/ButtonOption4

# Lista de operações matemáticas
var operacoes_2 = ["+", "-", "*"]
var operacoes_3 = ["+", "-"]

# Dicionário para armazenar a pergunta atual
var pergunta_atual = {}

func _ready():
	randomize()
	gerar_pergunta_aleatoria()

# Função para gerar uma pergunta aleatória
func gerar_pergunta_aleatoria():
	var operacao
	var numero1
	var numero2
	var resposta_correta
	var pergunta

	if randi_range(1, 2) == 1: # Se for 2 tipos de operações
		operacao = operacoes_2[randi() % operacoes_2.size()]
		numero1 = randi_range(1, 10) # Números entre 1 e 10
		numero2 = randi_range(1, 10)
	else: # Se for 3 tipos de operações
		operacao = operacoes_3[randi() % operacoes_3.size()]
		numero1 = randi_range(1, 10)
		numero2 = randi_range(1, 10)

	# Determinar a pergunta com base na operação selecionada
	match operacao:
		"+" :
			resposta_correta = numero1 + numero2
			pergunta = str(numero1) + " + " + str(numero2)
		"-" :
			resposta_correta = numero1 - numero2
			pergunta = str(numero1) + " - " + str(numero2)
		"*" :
			resposta_correta = numero1 * numero2
			pergunta = str(numero1) + " * " + str(numero2)

	# Exibir a pergunta na interface do usuário
	question_text.text = pergunta

	# Gerar opções de resposta (incluindo a resposta correta)
	var opcoes = [resposta_correta]

	# Adicionar opções incorretas únicas
	for opcoes_perguntas in range(3):
		var opcao_incorreta
		while true:
			opcao_incorreta = randi_range(1, 20)  # Números aleatórios para opções incorretas
			if opcao_incorreta != resposta_correta and !opcoes.has(opcao_incorreta):
				break
		opcoes.append(opcao_incorreta)

	# Embaralhar as opções de resposta
	opcoes.shuffle()

	# Exibir as opções de resposta nos botões
	button_option_1.text = str(opcoes[0])
	button_option_2.text = str(opcoes[1])
	button_option_3.text = str(opcoes[2])
	button_option_4.text = str(opcoes[3])

	# Armazenar a pergunta atual
	pergunta_atual = {
		"resposta_correta": resposta_correta,
		"opcoes": opcoes
	}

func _on_button_option_1_pressed():
	var opcao_selecionada = pergunta_atual["opcoes"][0]
	var resposta_correta = pergunta_atual["resposta_correta"]

	if opcao_selecionada == resposta_correta:
		print("Resposta correta!")
	else:
		print("Resposta incorreta!")

	gerar_pergunta_aleatoria()


func _on_button_option_2_pressed():
	var opcao_selecionada = pergunta_atual["opcoes"][1]
	var resposta_correta = pergunta_atual["resposta_correta"]

	if opcao_selecionada == resposta_correta:
		print("Resposta correta!")
	else:
		print("Resposta incorreta!")

	gerar_pergunta_aleatoria()


func _on_button_option_3_pressed():
	var opcao_selecionada = pergunta_atual["opcoes"][2]
	var resposta_correta = pergunta_atual["resposta_correta"]

	if opcao_selecionada == resposta_correta:
		print("Resposta correta!")
	else:
		print("Resposta incorreta!")

	gerar_pergunta_aleatoria()

func _on_button_option_4_pressed():
	var opcao_selecionada = pergunta_atual["opcoes"][3]
	var resposta_correta = pergunta_atual["resposta_correta"]

	if opcao_selecionada == resposta_correta:
		print("Resposta correta!")
	else:
		print("Resposta incorreta!")

	gerar_pergunta_aleatoria()
