import json
import os
from datetime import datetime


class SistemaEstoque:
    def __init__(self, arquivo_dados="estoque.json"):
        self.arquivo_dados = arquivo_dados
        self.itens = self.carregar_dados()
        self.categorias = ["Componente Eletrônico", "Ferramenta", "Peça de Computador"]

    def carregar_dados(self):
        """Carrega os dados do arquivo JSON ou cria um dicionário vazio"""
        if os.path.exists(self.arquivo_dados):
            with open(self.arquivo_dados, 'r', encoding='utf-8') as f:
                return json.load(f)
        return {"itens": {}, "proximo_id": 1}

    def salvar_dados(self):
        """Salva os dados no arquivo JSON"""
        with open(self.arquivo_dados, 'w', encoding='utf-8') as f:
            json.dump(self.itens, f, ensure_ascii=False, indent=4)

    def adicionar_item(self, nome, categoria, quantidade, preco, descricao=""):
        """Adiciona um novo item ao estoque"""
        item_id = self.itens["proximo_id"]
        self.itens["itens"][str(item_id)] = {
            "id": item_id,
            "nome": nome,
            "categoria": categoria,
            "quantidade": quantidade,
            "preco": preco,
            "descricao": descricao,
            "data_cadastro": datetime.now().strftime("%d/%m/%Y %H:%M")
        }
        self.itens["proximo_id"] += 1
        self.salvar_dados()
        return item_id

    def adicionar_item_por_peso(self, nome, categoria, peso_unitario_g, peso_total_g, preco, descricao=""):
        """Adiciona um item calculando a quantidade com base no peso"""
        # Calcula a quantidade baseada no peso
        quantidade = peso_total_g / peso_unitario_g

        item_id = self.itens["proximo_id"]
        self.itens["itens"][str(item_id)] = {
            "id": item_id,
            "nome": nome,
            "categoria": categoria,
            "quantidade": quantidade,
            "preco": preco,
            "descricao": descricao,
            "peso_unitario_g": peso_unitario_g,
            "peso_total_g": peso_total_g,
            "data_cadastro": datetime.now().strftime("%d/%m/%Y %H:%M"),
            "adicionado_por_peso": True  # Flag para identificar que foi adicionado por peso
        }
        self.itens["proximo_id"] += 1
        self.salvar_dados()
        return item_id, quantidade

    def listar_itens(self):
        """Retorna todos os itens do estoque"""
        return self.itens["itens"]

    def buscar_item(self, item_id):
        """Busca um item específico pelo ID"""
        return self.itens["itens"].get(str(item_id))

    def atualizar_item(self, item_id, **kwargs):
        """Atualiza um item existente"""
        if str(item_id) in self.itens["itens"]:
            for chave, valor in kwargs.items():
                if chave in self.itens["itens"][str(item_id)]:
                    self.itens["itens"][str(item_id)][chave] = valor
            self.itens["itens"][str(item_id)]["data_atualizacao"] = datetime.now().strftime("%d/%m/%Y %H:%M")
            self.salvar_dados()
            return True
        return False

    def remover_item(self, item_id):
        """Remove um item do estoque"""
        if str(item_id) in self.itens["itens"]:
            del self.itens["itens"][str(item_id)]
            self.salvar_dados()
            return True
        return False

    def buscar_por_nome_ou_descricao(self, termo_busca):
        """Busca itens por nome OU descrição (busca por trecho)"""
        resultados = []
        termo = termo_busca.lower()

        for item in self.itens["itens"].values():
            # Verifica se o termo está no nome OU na descrição
            nome_match = termo in item["nome"].lower()
            descricao_match = termo in item["descricao"].lower()

            if nome_match or descricao_match:
                resultados.append(item)

        return resultados


# Interface de usuário simples
def mostrar_menu():
    print("\n" + "=" * 50)
    print("SISTEMA DE GERENCIAMENTO DE ESTOQUE")
    print("=" * 50)
    print("1. Adicionar item")
    print("2. Adicionar itens por peso")
    print("3. Listar todos os itens")
    print("4. Buscar item por ID")
    print("5. Atualizar item")
    print("6. Remover item")
    print("7. Buscar por nome ou descrição")
    print("8. Sair")
    print("=" * 50)


def main():
    sistema = SistemaEstoque()

    while True:
        mostrar_menu()
        opcao = input("Escolha uma opção: ")

        if opcao == "1":
            print("\n--- ADICIONAR ITEM ---")
            nome = input("Nome: ")
            print("Categorias disponíveis:")
            for i, cat in enumerate(sistema.categorias, 1):
                print(f"{i}. {cat}")
            categoria_idx = int(input("Número da categoria: ")) - 1
            if 0 <= categoria_idx < len(sistema.categorias):
                categoria = sistema.categorias[categoria_idx]
            else:
                print("Categoria inválida!")
                continue
            quantidade = int(input("Quantidade: "))
            preco = float(input("Preço: R$ "))
            descricao = input("Descrição (opcional): ")

            item_id = sistema.adicionar_item(nome, categoria, quantidade, preco, descricao)
            print(f"Item adicionado com sucesso! ID: {item_id}")

        elif opcao == "2":
            print("\n--- ADICIONAR ITENS POR PESO ---")
            nome = input("Nome: ")
            print("Categorias disponíveis:")
            for i, cat in enumerate(sistema.categorias, 1):
                print(f"{i}. {cat}")
            categoria_idx = int(input("Número da categoria: ")) - 1
            if 0 <= categoria_idx < len(sistema.categorias):
                categoria = sistema.categorias[categoria_idx]
            else:
                print("Categoria inválida!")
                continue

            peso_unitario = float(input("Peso unitário (gramas): "))
            peso_total = float(input("Peso total (gramas): "))
            preco = float(input("Preço: R$ "))
            descricao = input("Descrição (opcional): ")

            item_id, quantidade = sistema.adicionar_item_por_peso(
                nome, categoria, peso_unitario, peso_total, preco, descricao
            )
            print(f"Item adicionado com sucesso! ID: {item_id}")
            print(f"Quantidade calculada: {quantidade:.2f} unidades")

        elif opcao == "3":
            print("\n--- LISTA DE ITENS ---")
            itens = sistema.listar_itens()
            if itens:
                for item_id, item in itens.items():
                    # Verifica se o item foi adicionado por peso
                    if "adicionado_por_peso" in item and item["adicionado_por_peso"]:
                        print(f"ID: {item_id} | Nome: {item['nome']} | Categoria: {item['categoria']} | "
                              f"Quantidade: {item['quantidade']:.2f} | Preço: R$ {item['preco']:.2f} | "
                              f"Peso unitário: {item['peso_unitario_g']}g")
                    else:
                        print(f"ID: {item_id} | Nome: {item['nome']} | Categoria: {item['categoria']} | "
                              f"Quantidade: {item['quantidade']} | Preço: R$ {item['preco']:.2f}")
            else:
                print("Nenhum item cadastrado.")

        elif opcao == "4":
            print("\n--- BUSCAR ITEM POR ID ---")
            item_id = int(input("ID do item: "))
            item = sistema.buscar_item(item_id)
            if item:
                print(f"ID: {item['id']}")
                print(f"Nome: {item['nome']}")
                print(f"Categoria: {item['categoria']}")
                print(f"Quantidade: {item['quantidade']}" + (
                    " unidades" if 'adicionado_por_peso' not in item else f" unidades (calculada a partir do peso)"))
                print(f"Preço: R$ {item['preco']:.2f}")
                print(f"Descrição: {item['descricao']}")
                # Mostrar informações de peso se disponíveis
                if 'peso_unitario_g' in item:
                    print(f"Peso unitário: {item['peso_unitario_g']}g")
                if 'peso_total_g' in item:
                    print(f"Peso total: {item['peso_total_g']}g")
                print(f"Data de cadastro: {item['data_cadastro']}")
                if 'data_atualizacao' in item:
                    print(f"Última atualização: {item['data_atualizacao']}")
            else:
                print("Item não encontrado!")

        elif opcao == "5":
            print("\n--- ATUALIZAR ITEM ---")
            item_id = int(input("ID do item a ser atualizado: "))
            item = sistema.buscar_item(item_id)
            if item:
                print("Deixe em branco para manter o valor atual.")
                nome = input(f"Nome [{item['nome']}]: ") or item['nome']
                print("Categorias disponíveis:")
                for i, cat in enumerate(sistema.categorias, 1):
                    print(f"{i}. {cat}")
                categoria_input = input(f"Categoria [atual: {item['categoria']}]: ")
                if categoria_input:
                    categoria_idx = int(categoria_input) - 1
                    if 0 <= categoria_idx < len(sistema.categorias):
                        categoria = sistema.categorias[categoria_idx]
                    else:
                        print("Categoria inválida!")
                        continue
                else:
                    categoria = item['categoria']

                # Se foi adicionado por peso, permitir atualizar pesos
                if 'adicionado_por_peso' in item and item['adicionado_por_peso']:
                    print("\nAtualizar pesos (deixe em branco para manter):")
                    peso_unitario_input = input(f"Peso unitário [{item['peso_unitario_g']}g]: ")
                    peso_total_input = input(f"Peso total [{item['peso_total_g']}g]: ")

                    if peso_unitario_input or peso_total_input:
                        peso_unitario = float(peso_unitario_input) if peso_unitario_input else item['peso_unitario_g']
                        peso_total = float(peso_total_input) if peso_total_input else item['peso_total_g']

                        # Recalcular quantidade
                        quantidade = peso_total / peso_unitario
                        sistema.atualizar_item(
                            item_id,
                            nome=nome,
                            categoria=categoria,
                            quantidade=quantidade,
                            peso_unitario_g=peso_unitario,
                            peso_total_g=peso_total
                        )
                        print(f"Item atualizado com sucesso! Nova quantidade: {quantidade:.2f}")
                    else:
                        # Apenas atualizar nome e categoria
                        sistema.atualizar_item(item_id, nome=nome, categoria=categoria)
                        print("Item atualizado com sucesso!")
                else:
                    # Item normal, atualizar quantidade diretamente
                    quantidade_input = input(f"Quantidade [{item['quantidade']}]: ")
                    quantidade = int(quantidade_input) if quantidade_input else item['quantidade']

                    preco_input = input(f"Preço [R$ {item['preco']:.2f}]: ")
                    preco = float(preco_input) if preco_input else item['preco']

                    descricao = input(f"Descrição [{item['descricao']}]: ") or item['descricao']

                    sistema.atualizar_item(
                        item_id,
                        nome=nome,
                        categoria=categoria,
                        quantidade=quantidade,
                        preco=preco,
                        descricao=descricao
                    )
                    print("Item atualizado com sucesso!")
            else:
                print("Item não encontrado!")

        elif opcao == "6":
            print("\n--- REMOVER ITEM ---")
            item_id = int(input("ID do item a ser removido: "))
            if sistema.remover_item(item_id):
                print("Item removido com sucesso!")
            else:
                print("Item não encontrado!")

        elif opcao == "7":
            print("\n--- BUSCAR POR NOME OU DESCRIÇÃO ---")
            termo_busca = input("Digite o termo de busca: ")

            resultados = sistema.buscar_por_nome_ou_descricao(termo_busca)

            if resultados:
                print(f"\n{len(resultados)} item(s) encontrado(s):")
                for item in resultados:
                    if "adicionado_por_peso" in item and item["adicionado_por_peso"]:
                        print(f"ID: {item['id']} | Nome: {item['nome']} | Categoria: {item['categoria']} | "
                              f"Quantidade: {item['quantidade']:.2f} | Preço: R$ {item['preco']:.2f} | "
                              f"Peso unitário: {item['peso_unitario_g']}g")
                    else:
                        print(f"ID: {item['id']} | Nome: {item['nome']} | Categoria: {item['categoria']} | "
                              f"Quantidade: {item['quantidade']} | Preço: R$ {item['preco']:.2f}")
                    if item['descricao']:
                        print(f"   Descrição: {item['descricao']}")
                    print("-" * 50)
            else:
                print("Nenhum item encontrado com o termo especificado.")

        elif opcao == "8":
            print("Saindo do sistema...")
            break

        else:
            print("Opção inválida! Tente novamente.")


if __name__ == "__main__":
    main()