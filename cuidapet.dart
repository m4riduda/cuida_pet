import 'dart:io';

void main() {
  int quantidadeVendas = 0;
  double valorTotalVendas = 0.0;

  print("Bem vindo ao autoatendimento do Cuidapet");

  stdout.write("Digite o nome do cliente: ");
  String? nomeCliente = stdin.readLineSync();

  // Área restrita
  if (nomeCliente == "cuidapetrestrito") {
    areaRestrita(quantidadeVendas, valorTotalVendas);
    return;
  }

  List<Map<String, dynamic>> carrinho = [];

  // Produtos
  Map<int, Map<String, dynamic>> produtos = {
    101: {
      "nome":
          "Ração Royal Canin Indoor Para Cães Adultos De Porte Mini",
      "preco": 290.00
    },
    102: {
      "nome":
          "Ração Royal Canin Sterilised para Gatos Adultos Castrados",
      "preco": 492.00
    },
    103: {
      "nome":
          "Bifinho Keldog para Cães Porte Pequeno Sabor Carne e Cereais",
      "preco": 23.92
    },
    104: {
      "nome":
          "Fraldas Descartáveis Super Secão para Cães Machos",
      "preco": 38.61
    },
  };

  Map<int, Map<String, dynamic>> servicos = {
    201: {
      "nome": "Banho e tosa",
      "preco": 55.99
    },
    202: {
      "nome": "Tosa higienica",
      "preco": 12.99
    },
    203: {
      "nome": "Hidratação dos pelos",
      "preco": 20.99
    },
  };

  int opcao = -1;

  while (opcao != 0) {
    print("\nMENU");
    print("1 - Ver promoções");
    print("2 - Solicitar serviço");
    print("3 - Listar carrinho");
    print("4 - Finalizar carrinho");
    print("0 - Sair");

    stdout.write("Digite sua opção desejada: ");
    opcao = int.tryParse(stdin.readLineSync() ?? "") ?? -1;

    switch (opcao) {
      case 1:
        menuPromocoes(produtos, carrinho);
        break;

      case 2:
        menuServicos(servicos, carrinho);
        break;

      case 3:
        listarCarrinho(carrinho);
        break;

      case 4:
        double total = finalizarCompra(carrinho);

        if (total > 0) {
          quantidadeVendas++;
          valorTotalVendas += total;
          carrinho.clear();
        }
        break;

      case 0:
        print("\nSistema encerrado.");
        print("Quantidade de vendas: $quantidadeVendas");
        print(
            "Valor total das vendas: R\$ ${valorTotalVendas.toStringAsFixed(2)}");
        break;

      default:
        print("Opção inválida!");
    }
  }
}


void menuPromocoes(
    Map<int, Map<String, dynamic>> produtos,
    List<Map<String, dynamic>> carrinho) {
  int opcao = -1;

  while (opcao != 0) {
    print("\n====== PROMOÇÕES ======");
    produtos.forEach((codigo, item) {
      print(
          "Código $codigo - ${item['nome']} - R\$ ${item['preco'].toStringAsFixed(2)}");
    });

    print("8 - Adicionar ao carrinho");
    print("0 - Voltar");

    stdout.write("Escolha uma opção: ");
    opcao = int.tryParse(stdin.readLineSync() ?? "") ?? -1;

    if (opcao == 8) {
      adicionarCarrinho(produtos, carrinho);
    } else if (opcao != 0) {
      print("Opção inválida!");
    }
  }
}


void menuServicos(
    Map<int, Map<String, dynamic>> servicos,
    List<Map<String, dynamic>> carrinho) {
  int opcao = -1;

  while (opcao != 0) {
    print("\nSERVIÇOS");
    servicos.forEach((codigo, item) {
      print(
          "Código $codigo - ${item['nome']} - R\$ ${item['preco'].toStringAsFixed(2)}");
    });

    print("8 - Adicionar ao carrinho");
    print("0 - Voltar");

    stdout.write("Escolha uma opção: ");
    opcao = int.tryParse(stdin.readLineSync() ?? "") ?? -1;

    if (opcao == 8) {
      adicionarCarrinho(servicos, carrinho);
    } else if (opcao != 0) {
      print("Opção inválida!");
    }
  }
}


void adicionarCarrinho(
    Map<int, Map<String, dynamic>> itens,
    List<Map<String, dynamic>> carrinho) {
  if (carrinho.length >= 3) {
    print("Seu carrinho já está cheio!");
    return;
  }

  stdout.write("Digite o código do produto/serviço: ");
  int codigo = int.tryParse(stdin.readLineSync() ?? "") ?? -1;

  if (itens.containsKey(codigo)) {
    carrinho.add(itens[codigo]!);

    print("${itens[codigo]!['nome']} adicionado ao carrinho!");
  } else {
    print("Código inválido!");
  }
}


void listarCarrinho(List<Map<String, dynamic>> carrinho) {
  if (carrinho.isEmpty) {
    print("Carrinho vazio!");
    return;
  }

  print("\nCARRINHO");

  double total = 0;

  for (var item in carrinho) {
    print(
        "${item['nome']} - R\$ ${item['preco'].toStringAsFixed(2)}");
    total += item['preco'];
  }

  print("Total: R\$ ${total.toStringAsFixed(2)}");
}


double finalizarCompra(List<Map<String, dynamic>> carrinho) {
  if (carrinho.isEmpty) {
    print("Carrinho vazio!");
    return 0;
  }

  double total = 0;

  for (var item in carrinho) {
    total += item['preco'];
  }

  stdout.write("Forma de pagamento (D - Dinheiro / C - Cartão): ");
  String pagamento =
      (stdin.readLineSync() ?? "").toUpperCase();

  if (pagamento == "D") {
    total = total * 0.9;
    print("Desconto de 10% aplicado!");
  } else if (pagamento != "C") {
    print("Forma de pagamento inválida!");
    return 0;
  }

  print("Valor final: R\$ ${total.toStringAsFixed(2)}");
  print("Compra finalizada com sucesso!");

  return total;
}


void areaRestrita(
    int quantidadeVendas,
    double valorTotalVendas) {
  print("\nÁREA RESTRITA");

  stdout.write("Nome do cliente: ");
  String? nome = stdin.readLineSync();

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

  quantidadeVendas++;
  valorTotalVendas += valor;

  print("\nCliente: $nome");
  print("Valor final: R\$ ${valor.toStringAsFixed(2)}");

  print("\nQuantidade de vendas: $quantidadeVendas");
  print(
      "Valor total das vendas: R\$ ${valorTotalVendas.toStringAsFixed(2)}");
}