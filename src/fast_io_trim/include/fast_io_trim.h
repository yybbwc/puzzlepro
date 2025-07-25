#include <fast_io_dsal/string.h>
#include <fast_io.h>
#include <fast_io_device.h>

namespace fast_io {
  template <typename Str>
  concept BasicStringLike = requires(Str str) {
    typename Str::value_type;
    {
      str.size()
    } -> std::same_as<typename Str::size_type>;
    {
      str.data()
    } -> std::convertible_to<const typename Str::value_type *>;
    // 只检查 erase() 是否可调用
    {
      str.erase(str.begin(), str.end())
    };
    requires std::integral<typename Str::value_type>;
  };

  template <BasicStringLike Str> inline constexpr Str &trim_right(Str &str) noexcept {
    if (str.empty()) {
      return str;
    }

    using CharT = typename Str::value_type;
    const CharT *first = str.data();
    const CharT *last = first + str.size();

    // Find the position after the last non-whitespace character
    const CharT *trim_pos = last;
    const CharT *current = first;

    while (current < last) {
      // Find next whitespace character
      auto next_space = details::find_space_common_impl<false, false>(current, last);
      if (next_space == last) {
        // No more whitespace found
        trim_pos = last;
        break;
      }

      // Find next non-whitespace after the whitespace
      auto next_non_space = details::find_space_common_impl<false, true>(next_space, last);
      if (next_non_space == last) {
        // From next_space to end are all whitespace
        trim_pos = next_space;
        break;
      }

      current = next_non_space;
    }

    // Convert pointer back to iterator for erase
    auto trim_iterator = str.begin() + (trim_pos - first);
    str.erase(trim_iterator, str.end());
    return str;
  }

  template <BasicStringLike Str> inline constexpr Str &trim_left(Str &str) noexcept {
    if (str.empty()) {
      return str;
    }

    using CharT = typename Str::value_type;
    auto first = str.data();
    auto last = str.data() + str.size();

    // Find the first non-whitespace character
    CharT const *trim_pos = last;
    CharT const *current = first;

    while (current < last) {
      // Find next whitespace character
      auto next_space = ::fast_io::details::find_space_common_impl<false, false>(current, last);
      if (next_space != current) {
        // Current position is not whitespace
        trim_pos = current;
        break;
      }

      // Find next non-whitespace character
      auto next_non_space = ::fast_io::details::find_space_common_impl<false, true>(current, last);
      if (next_non_space != current) {
        // Found non-whitespace character
        trim_pos = next_non_space;
        break;
      }

      current = next_non_space;
    }

    // Convert const pointer back to iterator for erase
    auto trim_iterator = str.begin() + (trim_pos - first);
    str.erase(str.begin(), trim_iterator);
    return str;
  }

  template <BasicStringLike Str> inline constexpr Str &trim(Str &str) noexcept {
    trim_left(str);
    trim_right(str);
    return str;
  }

  template <BasicStringLike Str> inline constexpr Str trim_right_copy(Str &str) noexcept {
    Str result(str);
    trim_right(result);
    return result;
  }
  
  template <BasicStringLike Str> inline constexpr Str trim_left_copy(Str &str) noexcept {
    Str result(str);
    trim_left(result);
    return result;
  }
  
  template <BasicStringLike Str> inline constexpr Str trim_copy(Str &str) noexcept {
    Str result(str);
    trim_left(result);
    trim_right(result);
    return result;
  }
} // namespace fast_io
