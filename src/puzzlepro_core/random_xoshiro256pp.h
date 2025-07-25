
class random_xoshiro256pp {
public:
  boost::random::xoshiro256pp engine;
  int64_t seed;
  
  random_xoshiro256pp() = default;
  
  //~ random_xoshiro256pp(int64_t seed_) : seed(seed_), engine(seed_) {}
  
  void reset(int64_t seed_) {
    seed = seed_;
    engine.seed(seed);
  }
  
  int64_t get_random_integer(int64_t l, int64_t h) {
    boost::random::uniform_int_distribution<int64_t> dist(l, h);
    return dist(engine);
  }
  
  template <typename Container> void shuffle_vector(Container &v) {
    for (int64_t i = 0; i < v.size(); ++i) {
      int64_t r = this->get_random_integer(i, v.size() - 1);
      boost::core::invoke_swap(v[i], v[r]);
    }
  }
  
};
