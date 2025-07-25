#include <fast_io_dsal/string.h>
#include <fast_io.h>
#include <fast_io_device.h>
#include <fast_io_driver/timer.h>
#include "fast_io_trim.h"
#include <cassert>
using namespace fast_io::io;

int main() {
  {
    constexpr std::size_t N(40000000);
    {
      fast_io::timer t(u8"trim_right_string");
      std::string str("    ok    someone like trim    ok    ");
      for (std::size_t i{}; i != N; ++i) {
        str.push_back(' ');
        str.push_back('\t');
        str.push_back('\r');
        str.push_back('\f');
        str.push_back('\v');
        str.push_back('\n');
      }
      fast_io::trim_right(str);
      assert(str == std::string("    ok    someone like trim    ok"));
    }
  }
  {
    constexpr std::size_t N(40000000);
    {
      fast_io::timer t(u8"trim_right_u16string");
      std::u16string str(u"    ok    someone like trim    ok    ");
      for (std::size_t i{}; i != N; ++i) {
        str.push_back(u' ');
        str.push_back(u'\t');
        str.push_back(u'\r');
        str.push_back(u'\f');
        str.push_back(u'\v');
        str.push_back(u'\n');
      }
      fast_io::trim_right(str);
      assert(str == std::u16string(u"    ok    someone like trim    ok"));
    }
  }
}
