import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_pop/features/movies/home/data/models/my_lists_model.dart';
import 'package:movies_pop/features/movies/home/data/models/my_lists_movies_model.dart';
import 'package:movies_pop/features/movies/home/domain/repositories/home/home_repository.dart';
import 'package:movies_pop/features/movies/home/domain/usecase/usecase_list_user/get_my_lists_usecase.dart';

import '../mocks/mocks_my_lists.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late MockHomeRepository repository;
  late GetMyListsUsecase usecase;
  setUp(() {
    repository = MockHomeRepository();
    usecase = GetMyListsUsecase(homeRepository: repository);
  });
  var myLists = MyListsMoviesModel(
    page: 1,
    myLists: [
      MyListsModel.fronJson(json: mockMylist1),
      MyListsModel.fronJson(json: mockMylist2),
    ],
    totalPages: 1,
    totalResults: 2,
  );
  test('get my lists ...', () async {
    when(
      () => repository.getMyLists(),
    ).thenAnswer((_) async => Right(MyListsMoviesModel.fromJson(mockMylists)));
    final result = await usecase.call();

    expect(result.fold((l) => null, (r) => r), myLists);
    verify(() => repository.getMyLists()).called(1);
  });
}
