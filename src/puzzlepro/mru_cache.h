template <typename Key, typename Value> struct mru_cache_item {
  Key key;
  Value value;
  mru_cache_item(const Key &k, const Value &v) : key(k), value(v) {
  }
};

template <typename Key, typename Value> using mru_cache_define = boost::multi_index::multi_index_container<mru_cache_item<Key, Value>, boost::multi_index::indexed_by<boost::multi_index::hashed_unique<boost::multi_index::member<mru_cache_item<Key, Value>, Key, &mru_cache_item<Key, Value>::key>>, boost::multi_index::sequenced<>>>;

template <typename Key, typename Value> class mru_cache {
private:
  mru_cache_define<Key, Value> cache_;
  std::size_t capacity_;

public:
  mru_cache(std::size_t capacity) : capacity_(capacity) {
  }

  void put(const Key &key, const Value &value) {
    auto &key_index = cache_.template get<0>();
    auto &seq_index = cache_.template get<1>();
    auto it = key_index.find(key);
    if (it != key_index.end()) {
      auto seq_it = cache_.template project<1>(it);
      seq_index.splice(seq_index.begin(), seq_index, seq_it);
      key_index.modify(it, [&value](mru_cache_item<Key, Value> &item) {
        item.value = value;
      });
    }
    else {
      if (seq_index.size() >= capacity_) {
        seq_index.pop_back();
      }
      seq_index.emplace_front(key, value);
    }
  }

  Value get(const Key &key) {
    auto &key_index = cache_.template get<0>();
    auto &seq_index = cache_.template get<1>();
    auto it = key_index.find(key);

    if (it != key_index.end()) {
      auto seq_it = cache_.template project<1>(it);
      seq_index.splice(seq_index.begin(), seq_index, seq_it);
      return it->value;
    }
    return Value{};
  }

  bool contains(const Key &key) const {
    const auto &key_index = cache_.template get<0>();
    return key_index.find(key) != key_index.end();
  }
  
  bool remove(const Key &key) {
    auto &key_index = cache_.template get<0>();
    auto it = key_index.find(key);
    if (it != key_index.end()) {
      key_index.erase(it);
      return true;
    }
    return false;
  }

  std::size_t size() const {
    return cache_.size();
  }

  void clear() {
    cache_.clear();
  }
  
  typename mru_cache_define<Key, Value>::template nth_index<1>::type::const_iterator begin() const {
    return cache_.template get<1>().begin();
  }

  typename mru_cache_define<Key, Value>::template nth_index<1>::type::const_iterator end() const {
    return cache_.template get<1>().end();
  }
};
