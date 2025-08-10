package storage

type Storage[K comparable, T any] interface {
	Has(key K) bool
	Set(key K, data T)
	Get(key K) (T, bool)
}
