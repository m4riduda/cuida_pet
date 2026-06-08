import 'dart:io';

class Item {
  int codigo;
  String nome;
  double preco;

  Item(this.codigo, this.nome, this.preco);
}

class Carrinho {
  List<Item> itens = [];

  void adicionarItem(Item item) {
    if (itens.length >= 3) {
      print("Seu carrinho já está cheio!");
      return;
    }

    itens.add(item);
    print("${item.nome} adicionado ao carrinho!");
  }

  void listarItens() {
    if (itens.isEmpty) {
      print("Carrinho vazio!");
      return;
    }

    print("\n===== CARRINHO =====");

    for (var item in itens) {
      print("${item.nome} - R\$ ${item.preco.toStringAsFixed(2)}");
    }

    print("Total: R\$ ${calcularTotal().toStringAsFixed(2)}");
  }

  double calcularTotal() {
    double total = 0;

    for (var item in itens) {
      total += item.preco;
    }

    return total;
  }

  void limpar() {
    itens.clear();
  }

  bool estaVazio() {
    return itens.isEmpty;
  }
}

class ControleVendas {
  int quantidadeVendas = 0;
  double valorTotalVendas = 0;

  void registrarVenda(double valor) {
    quantidadeVendas++;
    valorTotalVendas += valor;
  }

  void exibirRelatorio() {
    print("\n===== RELATÓRIO =====");
    print("Quantidade de vendas: $quantidadeVendas");
    print(
        "Valor total das vendas: R\$ ${valorTotalVendas.toStringAsFixed(2)}");
  }
}

class SistemaCuidapet {
  List<Item> produtos = [];
  List<Item> servicos = [];
  Carrinho carrinho = Carrinho();
  ControleVendas controleVendas = ControleVendas();

  SistemaCuidapet() {
    produtos.add(
      Item(
        101,
        "Ração Royal Canin Indoor Para Cães Adultos De Porte Mini",
        290.00,
      ),
    );

    produtos.add(
      Item(
        102,
        "Ração Royal Canin Sterilised para Gatos Adultos Castrados",
        492.00,
      ),
    );

    produtos.add(
      Item(
        103,
        "Bifinho Keldog para Cães Porte Pequeno Sabor Carne e Cereais",
        23.92,
      ),
    );

    produtos.add(
      Item(
        104,
        "Fraldas Descartáveis Super Secão para Cães Machos",
        38.61,
      ),
    );

    servicos.add(Item(201, "Banho e tosa", 55.99));
    servicos.add(Item(202, "Tosa higiênica", 12.99));
    servicos.add(Item(203, "Hidratação dos pelos", 20.99));
  }

  void iniciar() {
    print("Bem-vindo ao autoatendimento do Cuidapet");

    stdout.write("Digite o nome do cliente: ");
    String? nomeCliente = stdin.readLineSync();

    if (nomeCliente == "cuidapetrestrito") {
      areaRestrita();
      return;
    }

    int opcao = -1;

    while (opcao != 0) {
      print("\n===== MENU =====");
      print("1 - Ver promoções");
      print("2 - Solicitar serviço");
      print("3 - Listar carrinho");
      print("4 - Finalizar compra");
      print("0 - Sair");

      stdout.write("Digite sua opção: ");
      opcao = int.tryParse(stdin.readLineSync() ?? "") ?? -1;

      switch (opcao) {
        case 1:
          menuProdutos();
          break;

        case 2:
          menuServicos();
          break;

        case 3:
          carrinho.listarItens();
          break;

        case 4:
          finalizarCompra();
          break;

        case 0:
          print("\nSistema encerrado.");
          controleVendas.exibirRelatorio();
          break;

        default:
          print("Opção inválida!");
      }
    }
  }

  void menuProdutos() {
    print("\n===== PROMOÇÕES =====");

    for (var produto in produtos) {
      print(
        "Código ${produto.codigo} - ${produto.nome} - "
        "R\$ ${produto.preco.toStringAsFixed(2)}",
      );
    }

    adicionarItem(produtos);
  }

  void menuServicos() {
    print("\n===== SERVIÇOS =====");

    for (var servico in servicos) {
      print(
        "Código ${servico.codigo} - ${servico.nome} - "
        "R\$ ${servico.preco.toStringAsFixed(2)}",
      );
    }

    adicionarItem(servicos);
  }

  void adicionarItem(List<Item> lista) {
    stdout.write("Digite o código do item: ");
    int codigo = int.tryParse(stdin.readLineSync() ?? "") ?? -1;

    for (var item in lista) {
      if (item.codigo == codigo) {
        carrinho.adicionarItem(item);
        return;
      }
    }

    print("Código inválido!");
  }

  void finalizarCompra() {
    if (carrinho.estaVazio()) {
      print("Carrinho vazio!");
      return;
    }

    double total = carrinho.calcularTotal();

    stdout.write("Forma de pagamento (D - Dinheiro / C - Cartão): ");
    String pagamento =
        (stdin.readLineSync() ?? "").toUpperCase();

    if (pagamento == "D") {
      total *= 0.9;
      print("Desconto de 10% aplicado!");
    } else if (pagamento != "C") {
      print("Forma de pagamento inválida!");
      return;
    }

    print("Valor final: R\$ ${total.toStringAsFixed(2)}");
    print("Compra finalizada com sucesso!");

    controleVendas.registrarVenda(total);

    carrinho.limpar();
  }

  void areaRestrita() {
    print("\n===== ÁREA RESTRITA =====");

    stdout.write("Nome do cliente: ");
    String nome = stdin.readLineSync() ?? "";

    stdout.write("Valor gasto na loja: ");
    double valor =
        double.tryParse(stdin.readLineSync() ?? "") ?? 0;

    stdout.write("Forma de pagamento (D/C): ");
    String pagamento =
        (stdin.readLineSync() ?? "").toUpperCase();

    if (pagamento == "D") {
      valor *= 0.9;
      print("Desconto de 10% aplicado.");
    } else if (pagamento != "C") {
      print("Forma de pagamento inválida!");
      return;
    }

    controleVendas.registrarVenda(valor);

    print("\nCliente: $nome");
    print("Valor final: R\$ ${valor.toStringAsFixed(2)}");

    controleVendas.exibirRelatorio();
  }
}

void main() {
  SistemaCuidapet sistema = SistemaCuidapet();
  sistema.iniciar();
}
