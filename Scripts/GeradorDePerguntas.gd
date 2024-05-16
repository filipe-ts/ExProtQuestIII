extends Node2D


var left_interval_bound = 1
var righ_interval_bound = 100
var righ_interval_bound_easy = 20
var right_interval_multiplication = 10

# Lista de operações matemáticas
var operacoes_2 = ["+", "-", "*"]
var operacoes_3 = ["+", "-"]

# Dicionário para armazenar a pergunta atual
var pergunta_atual = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func gerar_pergunta_aleatoria():
	var operacao
	var numero1
	var numero2
	var numero3
	var resposta_correta
	var pergunta
	var opcoes = []
	if randi_range(1, 2) == 1: # Se for 2 tipos de operações
		operacao = operacoes_2[randi() % operacoes_2.size()]
		numero1 = randi_range(left_interval_bound, righ_interval_bound)
		numero2 = randi_range(left_interval_bound, righ_interval_bound)
		# Determinar a pergunta com base na operação selecionada
		match operacao:
			"+" :
				resposta_correta = numero1 + numero2
				pergunta = str(numero1) + " + " + str(numero2)
			"-" :
				while numero1 < numero2:  # número 1 sempre maior que número 2, para não
				# termos números negativos na resposta
					numero1 = randi_range(numero2-1, righ_interval_bound)
					print("while 1")
					
				resposta_correta = numero1 - numero2
				pergunta = str(numero1) + " - " + str(numero2)
			"*" :
				while numero2 > 10 and numero1 > 10:  # evitar multiplicações muito grandes
					numero1 = randi_range(left_interval_bound, right_interval_multiplication)
					numero2 = randi_range(left_interval_bound, right_interval_multiplication)
					print("while 2")
				resposta_correta = numero1 * numero2
				pergunta = str(numero1) + " * " + str(numero2)
	else: # Se for 3 tipos de operações
		operacao = operacoes_3[randi() % operacoes_3.size()]
		numero1 = randi_range(left_interval_bound, righ_interval_bound_easy)
		numero2 = randi_range(left_interval_bound, righ_interval_bound_easy)
		numero3 = randi_range(left_interval_bound, righ_interval_bound_easy)
		match operacao:
			"+" :
				resposta_correta = numero1 + numero2 + numero3
				pergunta = str(numero1) + " + " + str(numero2) + " + " + str(numero3)
			"-" :
				while numero1 < (numero2 + numero3):  # número 1 sempre maior que a soma dos demias, para não
				# termos números negativos na resposta
					numero1 = randi_range(left_interval_bound, righ_interval_bound)
					numero2 = randi_range(left_interval_bound, 5)
					numero3 = randi_range(left_interval_bound, 10)
					print("while 3")
					
				resposta_correta = numero1 - numero2 - numero3
				pergunta = str(numero1) + " - " + str(numero2)  + " - " + str(numero3)
			"*" :
				resposta_correta = numero1 + numero2 + numero3
				pergunta = str(numero1) + " + " + str(numero2) + " + " + str(numero3)

	# Gerar opções de resposta (incluindo a resposta correta)
	opcoes = [resposta_correta]

	# Adicionar opções incorretas únicas
	for opcoes_perguntas in range(4):
		var opcao_incorreta
		var resposta_offset = int(resposta_correta/10) + 10
		while true:
			print("while 4")
			
			opcao_incorreta = resposta_correta + randi_range(-resposta_offset, resposta_offset)  # Números aleatórios para opções incorretas
			if opcao_incorreta != resposta_correta and !opcoes.has(opcao_incorreta) and opcao_incorreta > 0:
				break
		opcoes.append(opcao_incorreta)

	# Armazenar a pergunta atual
	pergunta_atual = {
		"resposta_correta": resposta_correta,
		"opcoes": opcoes,
		"pergunta": pergunta
	}
