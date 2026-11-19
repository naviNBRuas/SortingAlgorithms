# C++ sorts

Header-only C++17: `#include "sorting/all.hpp"`, then e.g. `sorting::quick_sort(std::vector<int>&)`. Generated from `kernels/`.

```sh
cd cpp && make test      # builds tests/tests.cpp with -Wall -Wextra and checks every sort against std::sort
```

`bogo_sort(v, max_shuffles)` and `bozo_sort(v, max_swaps)` take an attempt budget.
