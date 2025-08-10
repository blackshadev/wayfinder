package storage

type internalMemoryStorage[K comparable, T any] struct {
	records map[K]T
}

func CreateInternalStorage[K comparable, T any]() Storage[K, T] {
	return &internalMemoryStorage[K, T]{
		records: map[K]T{},
	}
}

func (s *internalMemoryStorage[K, T]) Set(key K, data T) {
	s.records[key] = data
}

func (s *internalMemoryStorage[K, T]) Has(key K) bool {
	_, ok := s.records[key]

	return ok
}

func (s *internalMemoryStorage[K, T]) Get(key K) (T, bool) {
	if record, ok := s.records[key]; ok {
		return record, true
	}

	var empty T
	return empty, false
}
