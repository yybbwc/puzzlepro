#pragma once

//~ #ifndef SIGNAL_H
//~ #define SIGNAL_H

class Signal {
public:
  Signal() : _state(false), _nowait(false) {
  }

  ~Signal() = default;

  void Set() {
    std::unique_lock<std::mutex> lock(_mutex);
    _state = true;
    _cond.notify_all();
  }

  void Reset() {
    std::unique_lock<std::mutex> lock(_mutex);
    _state = false;
  }

  void Wait() {
    //~ fast_io::io::print(fast_io::win32_box_t(), __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
    if (_nowait) {
      return;
    }
    //~ fast_io::io::print(fast_io::win32_box_t(), __FILE__, "\n", __LINE__, "\n", __PRETTY_FUNCTION__);
    std::unique_lock<std::mutex> lock(_mutex);
    _cond.wait(lock, [this]() {
      return _state;
    });
    _state = false;
  }

  bool Wait(long milliseconds) {
    if (_nowait) {
      return false;
    }
    std::unique_lock<std::mutex> lock(_mutex);
    bool res = _cond.wait_for(lock, std::chrono::milliseconds(milliseconds), [this]() {
      return _state;
    });
    _state = false;
    return res;
  }

  void SetNoWait(bool nowait) {
    _nowait = nowait;
  }

private:
  std::mutex _mutex;
  std::condition_variable _cond;
  bool _state;
  bool _nowait;
};

//~ #endif // SIGNAL_H
