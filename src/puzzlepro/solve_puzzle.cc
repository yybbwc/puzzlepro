

namespace ygo {
  template <typename Container, typename Iterator> void parse_msg_number(Iterator first, Iterator last, Container &v) {
    using boost::spirit::x3::int_;
    using boost::spirit::x3::omit;
    using boost::spirit::x3::parse;
    using boost::spirit::x3::ascii::alpha;
    using boost::spirit::x3::ascii::punct;

    parse(first, last, omit[+(alpha | punct)] >> " " >> int_ % " ", v);
  }

  std::vector<std::vector<int64_t>> Game::get_combo(int64_t o1, int64_t o2) {
    std::vector<std::vector<int64_t>> result;

    std::vector<int64_t> k1;
    for (int64_t i = 0, n = o1; i < n; ++i) {
      k1.push_back(i);
    }

    std::vector<bool> selector(o1);
    std::fill(selector.begin(), selector.begin() + o2, true);

    do {
      std::vector<int64_t> combination;
      for (int64_t i = 0; i < o1; ++i) {
        if (selector[i]) {
          combination.push_back(k1[i]);
        }
      }
      std::vector<int64_t> k2;
      for (int64_t i = 0; i < combination.size(); ++i) {
        k2.push_back(combination[i]);
      }
      result.push_back(k2);
    } while (std::prev_permutation(selector.begin(), selector.end()));

    return result;
  }

  bool Game::create_solve_puzzle_behavior(int64_t o1) {
    auto usable_solve_puzzle_behavior = this->create_usable_solve_puzzle_behavior(o1);
    usable_solve_puzzle_behavior = this->remove_unusable_solve_puzzle_behavior(usable_solve_puzzle_behavior);
    if (!usable_solve_puzzle_behavior.empty()) {
      this->solve_puzzle_string.append(usable_solve_puzzle_behavior[0]);
      this->solve_puzzle_last_msg = usable_solve_puzzle_behavior[0];
      this->send_solve_puzzle_behavior(o1, usable_solve_puzzle_behavior[0]);
      return true;
    }
    else {
      this->solve_puzzle_string_s1.push_back(this->solve_puzzle_string);
      return false;
    }
  }

  using usable_solve_puzzle_behavior_function = std::vector<std::string> (Game::*)();
  inline std::unordered_map<int64_t, usable_solve_puzzle_behavior_function> usable_solve_puzzle_behavior_function_unordered_map = {
    {MSG_SELECT_IDLECMD,   &Game::create_usable_solve_puzzle_behavior_MSG_SELECT_IDLECMD  },
    {MSG_SELECT_BATTLECMD, &Game::create_usable_solve_puzzle_behavior_MSG_SELECT_BATTLECMD},
    {MSG_SELECT_CARD,      &Game::create_usable_solve_puzzle_behavior_MSG_SELECT_CARD     },
    {MSG_SELECT_PLACE,     &Game::create_usable_solve_puzzle_behavior_MSG_SELECT_PLACE    },
    {MSG_SELECT_EFFECTYN,  &Game::create_usable_solve_puzzle_behavior_MSG_SELECT_EFFECTYN },
    {MSG_SELECT_CHAIN,     &Game::create_usable_solve_puzzle_behavior_MSG_SELECT_CHAIN    }
  };

  std::vector<std::string> Game::create_usable_solve_puzzle_behavior(int64_t o1) {
    auto it = usable_solve_puzzle_behavior_function_unordered_map.find(o1);
    if (it != usable_solve_puzzle_behavior_function_unordered_map.end()) {
      return (this->*(it->second))();
    }
    return {}; // 或抛出异常
  }

  std::vector<std::string> Game::create_usable_solve_puzzle_behavior_MSG_SELECT_EFFECTYN() {
    std::vector<std::string> str_s1;
    for (int64_t i = 0, n = 2; i < n; ++i) {
      str_s1.push_back(fast_io::concat_std("MSG_SELECT_EFFECTYN ", i, "\n"));
    }
    return str_s1;
  }

  std::vector<std::string> Game::create_usable_solve_puzzle_behavior_MSG_SELECT_PLACE() {
    std::vector<std::string> str_s1;

    if (this->solve_puzzle_select_cancelable_last_MSG_SELECT_PLACE) {
      this->solve_puzzle_select_cancelable = false;
      this->solve_puzzle_select_cancelable_last_MSG_SELECT_PLACE = false;
    }
    else if (this->solve_puzzle_select_cancelable) {
      this->solve_puzzle_select_cancelable_last_MSG_SELECT_PLACE = true;
    }

    std::tuple<std::string, int64_t> options_1[] = {
      {"MSG_SELECT_PLACE 0", this->solve_puzzle_select_cancelable}
    };
    for (const auto &[prefix, bool_value] : options_1) {
      if (bool_value) {
        str_s1.push_back(fast_io::concat_std(prefix, " 0 0\n"));
      }
    }

    std::vector<std::string> k1;

    // 定义元组表：(player, location, bit_shift, max_index)
    constexpr std::tuple<uint8_t, uint8_t, int, int> field_checks[] = {
      {0, LOCATION_MZONE, 0,  7}, // 检查 0-6 位 (MZONE, player 0)
      {0, LOCATION_SZONE, 8,  8}, // 检查 8-15 位 (SZONE, player 0)
      {1, LOCATION_MZONE, 16, 7}, // 检查 16-22 位 (MZONE, player 1)
      {1, LOCATION_SZONE, 24, 8}, // 检查 24-31 位 (SZONE, player 1)
    };

    for (const auto &[player, location, shift, max_i] : field_checks) {
      for (int i = 0; i < max_i; ++i) {
        if ((this->solve_puzzle_selectable_field >> shift) & (1 << i)) {
          k1.push_back(fast_io::concat_std(" ", player, " ", location, " ", i));
        }
      }
    }

    auto k2 = this->get_combo(k1.size(), this->solve_puzzle_select_count);

    for (auto &k2_1 : k2) {
      auto k3 = fast_io::concat_std("MSG_SELECT_PLACE");
      for (auto &k2_1_1 : k2_1) {
        k3.append(k1[k2_1_1]);
      }
      k3.append("\n");
      str_s1.push_back(k3);
    }

    return str_s1;
  }

  std::vector<std::string> Game::create_usable_solve_puzzle_behavior_MSG_SELECT_CHAIN() {
    std::vector<std::string> str_s1;
    for (int64_t i = (this->solve_puzzle_select_chains_forced ? 0 : -1), n = this->solve_puzzle_select_chains_size; i < n; ++i) {
      str_s1.push_back(fast_io::concat_std("MSG_SELECT_CHAIN ", i, "\n"));
    }
    return str_s1;
  }

  std::vector<std::string> Game::create_usable_solve_puzzle_behavior_MSG_SELECT_CARD() {
    std::vector<std::string> str_s1;

    if (this->solve_puzzle_select_cancelable_last_MSG_SELECT_CARD) {
      this->solve_puzzle_select_cancelable = false;
      this->solve_puzzle_select_cancelable_last_MSG_SELECT_CARD = false;
    }
    else if (this->solve_puzzle_select_cancelable) {
      this->solve_puzzle_select_cancelable_last_MSG_SELECT_CARD = true;
    }

    std::tuple<std::string, int64_t> options_1[] = {
      {"MSG_SELECT_CARD -1", this->solve_puzzle_select_cancelable}
    };
    for (const auto &[prefix, bool_value] : options_1) {
      if (bool_value) {
        str_s1.push_back(fast_io::concat_std(prefix, "\n"));
      }
    }

    for (int64_t i = this->solve_puzzle_select_min, n = this->solve_puzzle_select_max; i <= n; ++i) {
      auto k1 = this->get_combo(this->solve_puzzle_selectable_cards_size, i);
      for (auto &k1_1 : k1) {
        std::string k2;
        for (auto &k1_1_1 : k1_1) {
          k2.append(fast_io::concat_std(" ", k1_1_1));
        }
        str_s1.push_back(fast_io::concat_std("MSG_SELECT_CARD ", i, k2, "\n"));
      }
    }

    return str_s1;
  }

  std::vector<std::string> Game::create_usable_solve_puzzle_behavior_MSG_SELECT_BATTLECMD() {
    std::vector<std::string> str_s1;

    std::tuple<std::string, int64_t> options[] = {
      {"MSG_SELECT_BATTLECMD 0", this->solve_puzzle_select_chains_size   },
      {"MSG_SELECT_BATTLECMD 1", this->solve_puzzle_attackable_cards_size}
    };
    for (const auto &[prefix, size] : options) {
      for (int64_t i = 0, n = size; i < n; ++i) {
        str_s1.push_back(fast_io::concat_std(prefix, " ", i, "\n"));
      }
    }

    std::tuple<std::string, int64_t> options_1[] = {
      {"MSG_SELECT_BATTLECMD 2", this->solve_puzzle_can_enter_mp2},
      {"MSG_SELECT_BATTLECMD 3", this->solve_puzzle_can_enter_ep }
    };
    for (const auto &[prefix, bool_value] : options_1) {
      if (bool_value) {
        str_s1.push_back(fast_io::concat_std(prefix, "\n"));
      }
    }

    return str_s1;
  }

  std::vector<std::string> Game::create_usable_solve_puzzle_behavior_MSG_SELECT_IDLECMD() {
    std::vector<std::string> str_s1;

    std::tuple<std::string, int64_t> options[] = {
      {"MSG_SELECT_IDLECMD 0", this->solve_puzzle_summonable_cards_size  },
      {"MSG_SELECT_IDLECMD 1", this->solve_puzzle_spsummonable_cards_size},
      {"MSG_SELECT_IDLECMD 2", this->solve_puzzle_reposable_cards_size   },
      {"MSG_SELECT_IDLECMD 3", this->solve_puzzle_msetable_cards_size    },
      {"MSG_SELECT_IDLECMD 4", this->solve_puzzle_ssetable_cards_size    },
      {"MSG_SELECT_IDLECMD 5", this->solve_puzzle_select_chains_size     }
    };
    for (const auto &[prefix, size] : options) {
      for (int64_t i = 0, n = size; i < n; ++i) {
        str_s1.push_back(fast_io::concat_std(prefix, " ", i, "\n"));
      }
    }

    std::tuple<std::string, int64_t> options_1[] = {
      {"MSG_SELECT_IDLECMD 6", this->solve_puzzle_can_enter_bp},
      {"MSG_SELECT_IDLECMD 7", this->solve_puzzle_can_enter_ep}
    };
    for (const auto &[prefix, bool_value] : options_1) {
      if (bool_value) {
        str_s1.push_back(fast_io::concat_std(prefix, "\n"));
      }
    }

    return str_s1;
  }

  std::vector<std::string> Game::remove_unusable_solve_puzzle_behavior(std::vector<std::string> o1) {
    auto number_s1 = get_unusable_solve_puzzle_behavior_index(o1);
    for (int64_t i = number_s1.size() - 1; i >= 0; --i) {
      o1.erase(o1.begin() + number_s1[i]);
    }
    return o1;
  }

  std::vector<int64_t> Game::get_unusable_solve_puzzle_behavior_index(std::vector<std::string> o1) {
    std::vector<int64_t> number_s1;
    for (int64_t i = 0, n = o1.size(); i < n; ++i) {
      auto str = fast_io::concat_std(this->solve_puzzle_string, o1[i]);
      for (int64_t i1 = 0, n = this->solve_puzzle_string_s1.size(); i1 != n; ++i1) {
        if (this->solve_puzzle_string_s1[i1] == str) {
          number_s1.push_back(i);
        }
      }
    }
    return number_s1;
  }

  using send_solve_puzzle_behavior_function = void (Game::*)(std::string);
  inline std::unordered_map<int64_t, send_solve_puzzle_behavior_function> send_solve_puzzle_behavior_function_unordered_map = {
    {MSG_SELECT_IDLECMD,   &Game::send_solve_puzzle_behavior_MSG_SELECT_IDLECMD},
    {MSG_SELECT_CHAIN,     &Game::send_solve_puzzle_behavior_MSG_SELECT_CHAIN  },
    {MSG_SELECT_CARD,      &Game::send_solve_puzzle_behavior_MSG_SELECT_CARD   },
    {MSG_SELECT_PLACE,     &Game::send_solve_puzzle_behavior_MSG_SELECT_CARD   },
    {MSG_SELECT_EFFECTYN,  &Game::send_solve_puzzle_behavior_MSG_SELECT_CARD   },
    {MSG_SELECT_BATTLECMD, &Game::send_solve_puzzle_behavior_MSG_SELECT_IDLECMD}
  };

  void Game::send_solve_puzzle_behavior(int64_t o1, std::string o2) {
    auto it = send_solve_puzzle_behavior_function_unordered_map.find(o1);
    if (it != send_solve_puzzle_behavior_function_unordered_map.end()) {
      return (this->*(it->second))(o2);
    }
  }

  void Game::send_solve_puzzle_behavior_MSG_SELECT_CARD(std::string o1) {
    std::vector<uint8_t> k1;
    uint8_t resp[SIZE_RETURN_VALUE];
    parse_msg_number(o1.begin(), o1.end(), k1);
    if (k1[0] == 255) {
      int32_t value = -1;
      std::memcpy(resp, &value, sizeof(int32_t));
    }
    else {
      memcpy(resp, k1.data(), k1.size());
    }
    set_responseb(ReplayMode::pduel, resp);
  }

  void Game::send_solve_puzzle_behavior_MSG_SELECT_CHAIN(std::string o1) {
    std::vector<int32_t> k1;
    uint8_t resp[SIZE_RETURN_VALUE];
    parse_msg_number(o1.begin(), o1.end(), k1);
    memcpy(resp, k1.data(), k1.size() * sizeof(int32_t));
    set_responseb(ReplayMode::pduel, resp);
  }

  void Game::send_solve_puzzle_behavior_MSG_SELECT_IDLECMD(std::string o1) {
    std::vector<int16_t> k1;
    uint8_t resp[SIZE_RETURN_VALUE];
    parse_msg_number(o1.begin(), o1.end(), k1);
    memcpy(resp, k1.data(), k1.size());
    set_responseb(ReplayMode::pduel, resp);
  }
} // namespace ygo
