import 'package:flutter_test/flutter_test.dart';
import 'package:geapp/app/models/query_result.dart';
import 'package:geapp/modules/sale/repositories/sale_repository.dart';
import 'package:geapp/app/services/db_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sale_list_repository_test.mocks.dart';

// Gera o mock do DBService
@GenerateMocks([DBService])
void main() {
  late SaleRepository repository;
  late MockDBService mockDBService;

  setUp(() {
    mockDBService = MockDBService();
    repository = SaleRepository(mockDBService);
  });

  test('Deve retornar uma lista vazia se não houver vendas', () async {
    when(
      mockDBService.getData(
        tableName: "VENDAS",
        page: 1,
        limit: 9999,
        orderBy: "id",
      ),
    ).thenAnswer(
      (_) async => QueryResult(data: [], totalItems: 0, totalPages: 0),
    );

    final sales = await repository.search(null, null, 1, 9999, "id");

    expect(sales.data, isEmpty);
    expect(sales.totalItems, 0);
    expect(sales.totalPages, 0);
  });

  test('Deve chamar o DBService para buscar dados', () async {
    when(
      mockDBService.getData(
        tableName: "VENDAS",
        page: 1,
        limit: 9999,
        orderBy: "id",
      ),
    ).thenAnswer(
      (_) async => QueryResult(data: [], totalItems: 0, totalPages: 0),
    );

    await repository.search(null, null, 1, 9999, "id");

    verify(
      mockDBService
        ..getData(tableName: "VENDAS", page: 1, limit: 9999, orderBy: "id"),
    ).called(1);
  });
}
