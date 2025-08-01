#pragma once

#include <random>
#include <vector>
#include <utility>

class mt19937 {
public:
  const uint32_t rand_max;
  std::mt19937 rng;

  mt19937() : rng(), rand_max(rng.max()) {
  }

  explicit mt19937(uint_fast32_t seed) : rng(seed), rand_max(rng.max()) {
  }

  // mersenne_twister_engine
  void reset(uint_fast32_t seed) {
    rng.seed(seed);
  }

  uint_fast32_t rand() {
    return rng();
  }

  // uniform_int_distribution
  int32_t get_random_integer(int32_t l, int32_t h) {
    auto range = (uint_fast32_t)(h - l + 1);
    uint_fast32_t secureMax = rng.max() - rng.max() % range;
    uint_fast32_t x = 0;
    do {
      x = rng();
    } while (x >= secureMax);
    return l + (int32_t)(x % range);
  }

  // Fisher-Yates shuffle v[a]~v[b]
  template <typename T> void shuffle_vector(std::vector<T> &v, int32_t a = -1, int32_t b = -1) {
    if (a < 0) {
      a = 0;
    }
    if (b < 0) {
      b = (int32_t)v.size() - 1;
    }
    for (int32_t i = a; i < b; ++i) {
      int32_t r = get_random_integer(i, b);
      std::swap(v[i], v[r]);
    }
  }
};

