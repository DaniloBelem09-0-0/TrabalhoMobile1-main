// lib/services/tarefa_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/tarefa.dart';

class TarefaService {
  // Cliente HTTP pré-configurado que aponta para o servidor na nuvem
  final _client = Supabase.instance.client;

  // Busca todas as tarefas da tabela remota
  Future<List<Tarefa>> obterTarefas() async {
    final response = await _client
        .from('tarefas')
        .select()
        .order('id', ascending: true); // Ordena de forma crescente

    return response.map((item) => Tarefa.fromMap(item)).toList();
  }

  // Insere uma nova tarefa mapeando o objeto para JSON/Map
  Future<void> adicionarTarefa(String titulo, String descricao) async {
    final novaTarefa = Tarefa(titulo: titulo, descricao: descricao);
    await _client.from('tarefas').insert(novaTarefa.toMap());
  }

  // Altera o status booleano e envia a atualização filtrando pelo ID
  Future<void> alternarStatusTarefa(Tarefa tarefa) async {
    tarefa.concluida = !tarefa.concluida;
    await _client
        .from('tarefas')
        .update(tarefa.toMap())
        .eq('id', tarefa.id!); // Garante a atualização no registro correto
  }

  // Remove o registro da tabela em nuvem através do ID correspondente
  Future<void> deletarTarefa(int id) async {
    await _client.from('tarefas').delete().eq('id', id);
  }
}