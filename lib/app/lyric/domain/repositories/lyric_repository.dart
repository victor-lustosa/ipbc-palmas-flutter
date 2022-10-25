import '../../../core/domain/repositories/repository.dart';

abstract class ILyricRepository<T>
    implements
        IGetRepository<T>,
        IAddRepository<T>,
        IUpdateRepository<T>,
        IDeleteRepository<T> {}
