import mysql.connector

if __name__ == "__main__":
    
    # Conecta ao banco de dados
    connector = mysql.connector.connect(
        host="localhost",
        user="yourusername",
        password="yourpassword"
    )

    # Aponta para os dados requisitados no banco
    cursor = connector.cursor()
    
    # Consulta 1
    # Retorna o nome e a nota dos alunos que alcançaram a média na tarefa 1
    print("Alunos que alcançaram média na tarefa 1.\n")
    alunos_media_tarefa1 = "SELECT fullname, total_score FROM Task_Is_Solved_By NATURAL JOIN User WHERE total_score >= 6"

    # Consulta 2
    # Retorna o nome a nota dos alunos que alcançaram a nota indicada pelo usuário na tarefa 1
    print("Alunos que tiveram nota maior ou igual a: ")
    nota_consulta = int(input())
    print("\n")
    alunos_nota_acima = f"SELECT fullname, total_score FROM Task_Is_Solved_By NATURAL JOIN User WHERE total_score >= {nota_consulta}"
    
    #alunos_nota_acima_valor = "SELECT * FROM User WHERE total_score >= ?"
    #cursor.execute(alunos_nota_acima_valor, (nota_consulta,))

    # Consulta 3
    # Retorna o nome e o enunciado das questões que têm a tag "Queda livre"
    print("Questões com a tag \"Queda Livre\".\n")
    questoes_tag_queda_livre = "SELECT name_question, enunciate FROM Question JOIN Question_Historic ON Question.ID_question = Question_Historic.ID_question"

    # Consulta 4
    # Retorna a disciplina e a turma do aluno indicado pelo usuário
    print("Disciplina e turma de: ")
    aluno_consulta = input()
    print("\n")
    disciplina_turma_aluno = f"SELECT D.code, C.code FROM User AS U JOIN Studies_At AS SA ON U.ID_user = SA.ID_user JOIN Classgroup AS C ON SA.ID_classgroup = C.ID_classgroup JOIN Discipline AS D ON C.ID_discipline = D.ID_discipline WHERE U.fullname = '{aluno_consulta}'"

    # Consulta 5
    # Retorna as linguagens de uma disciplina
    print("Linguagens de: ")
    disciplina_consulta = input()
    print("\n")
    linguagens_disciplina = f"SELECT CS.name_correction_strategy FROM Discipline AS D JOIN Discipline_Has_A_CS AS DCS ON D.ID_discipline = DCS.ID_discipline JOIN Correction_Strategy AS CS ON DCS.ID_correction_strategy = CS.ID_correction_strategy WHERE D.code = {disciplina_consulta}"

    # UPDATE
    # Atualiza o nome de um usuário
    print("Atualizar o nome do usuário de ID: ")
    id_usuario = int(input())
    print("\nNovo nome: ")
    novo_nome_usuario = input()
    print("\n")
    update_nome_usuario = f"UPDATE User SET fullname = '{novo_nome_usuario}' WHERE ID_user = {id_usuario}"

    # UPDATE
    # Atualiza o conteúdo de uma dica
    print("Atualizar o conteúdo da dica de ID: ")
    id_dica = int(input())
    print("\nNovo conteúdo: ")
    novo_conteudo_dica = input()
    print("\n")
    update_conteudo_dica = f"UPDATE Tip SET content = '{novo_conteudo_dica}' WHERE ID_tip = {id_dica}"

# Consulta 1
# Retorna o nome e a nota dos alunos que alcançaram a média na tarefa 1
def consulta1(connect):
    
    # Aponta para os dados requisitados no banco
    cursor = connector.cursor()
    
    # Retorna o nome e a nota dos alunos que alcançaram a média na tarefa 1
    alunos_media_tarefa1 = "SELECT fullname, total_score FROM Task_Is_Solved_By NATURAL JOIN User WHERE total_score >= 6"
    
    # 
    cursor.execute(alunos_media_tarefa1)
    
    #Armazena o resultado
    resultado = cursor.fetchall()
    
    for aluno in resultado:
        print(aluno)
        print("--------------------------------------------------")
    #
    cursor.close()

# Consulta 2
# Retorna o nome a nota dos alunos que alcançaram a nota indicada pelo usuário na tarefa 1
def consulta2(connect):

    # Aponta para os dados requisitados no banco
    cursor = connector.cursor()

    print("Consultar alunos que tiveram nota maior ou igual a: ")

    # Verifica se o número é um inteiro e se está entre 0 e 10.
    try:
        numero = int(input())
        if numero < 0 or numero > 10:
            raise NumeroForaDoIntervaloException("O número deve estar entre 0 e 10.")
    except NumeroForaDoIntervaloException as e:
        print(e)
        return
    except ValueError:
        print("Valor inválido. Por favor, digite um número inteiro.")
        return
    

    print(numero)

    


    alunos_nota_acima_input = f"SELECT fullname, total_score FROM Task_Is_Solved_By NATURAL JOIN User WHERE total_score >= {nota_consulta}"
    
# Consulta 3
# Retorna o nome e o enunciado das questões que têm a tag "Queda livre"
def consulta3(connect):
    print("Questões com a tag \"Queda Livre\".\n")
    questoes_tag_queda_livre = "SELECT name_question, enunciate FROM Question JOIN Question_Historic ON Question.ID_question = Question_Historic.ID_question"
    

# Consulta 4
# Retorna a disciplina e a turma do aluno indicado pelo usuário
def consulta4():
    print("Disciplina e turma de: ")
    aluno_consulta = input()
    print("\n")
    disciplina_turma_aluno = f"SELECT D.code, C.code FROM User AS U JOIN Studies_At AS SA ON U.ID_user = SA.ID_user JOIN Classgroup AS C ON SA.ID_classgroup = C.ID_classgroup JOIN Discipline AS D ON C.ID_discipline = D.ID_discipline WHERE U.fullname = {aluno_consulta}"

# Consulta 5
# Retorna as linguagens de uma disciplina
def consulta5():
    print("Linguagens de: ")
    disciplina_consulta = input()
    print("\n")
    linguagens_disciplina = f" SELECT CS.name_correction_strategy FROM Discipline AS D JOIN Discipline_Has_A_CS AS DCS ON D.ID_discipline = DCS.ID_discipline JOIN Correction_Strategy AS CS ON DCS.ID_correction_strategy = CS.ID_correction_strategy WHERE D.code = {disciplina_consulta}"

def testa_consultas(lista_consulta, connector):
    consulta1()
    consulta2()
    consulta3()
    consulta4()
    consulta5()



def mostra_menu():
    print("Aqui você pode realizar as seguintes consultas:")
    print("1. Nome e a nota dos alunos que alcançaram a média na tarefa 1.")
    print("2. Nome e a nota dos alunos que obtiveram uma nota maior que a digitada.")
    print("3. Nome e o enunciado das questões que têm a tag \"Queda livre\"")
    print("4. Disciplina e a turma do aluno indicado pelo usuário")
    print("5. Retorna as linguagens de uma disciplina")
    
    print("9. Para testar todas as consultas.")
    
    print("Caso queira sair, digite 0.")


def inicia_programa():
    print("\033[36mOlá, bem vindo ao programa do grupo: \033[0m")
    print("Bruno Alves, Gabriel Saldanha, Jéssica Machado, Kézia Brito, Vitor Oliveira")
    
    #problema da parada
    while True:
        mostra_menu()
        
        numero = input()
       
        try:
            match numero:
                case 1:
                    consulta1()
                case 2:
                    consulta2()
                case 3:
                    consulta3()
                case 4:
                    consulta4()
                case 5:
                    consulta5()
                case 9:
                    testa_consultas()
                case 0:
                    break
                case _:
                    print("Numero inválido, por favor digite o número para uma consulta válida.")      
        except Exception as e :
            print(e)
            print("Por favor, digite um valor válido.")
            

class NumeroForaDoIntervaloException(Exception):
    pass

