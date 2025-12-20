+++
title = "LC 932：漂亮数组"
date = "2025-12-21T00:00:00+08:00"
tags = ["分治", "构造", "数学归纳"]
categories = ["算法"]

draft = false
weight = 932
+++

## 题目描述

如果长度为 $n$ 的数组 `nums` 满足以下条件，则称其为一个 **漂亮数组**：

1. `nums` 是由范围 $[1, n]$ 的整数组成的一个排列  
2. 对于任意 $0 \le i < j < n$，**不存在** 下标 $k$（$i < k < j$）使得  

```text
2 * nums[k] == nums[i] + nums[j]
```

给定整数 $n$，返回长度为 $n$ 的任意一个漂亮数组。

题目保证：对于任意合法的 $n$，至少存在一个有效答案。

---

## 示例

### 示例 1

```markdown
输入：n = 4
输出：[2, 1, 4, 3]
```

### 示例 2

```markdown
输入：n = 5
输出：[3, 1, 2, 5, 4]
```

---

## 解题思路

这是一道**典型的构造 + 数学归纳**问题，核心在于理解「漂亮数组」的结构性。

---

### 1. 核心性质：奇偶拆分

将数组拆分为两部分：

* 所有 **奇数**
* 所有 **偶数**

有一个非常关键的观察：

* 奇数内部仍然是奇数
* 偶数内部仍然是偶数
* **奇数 + 偶数 = 奇数，不可能等于 $2 \times 某个整数$**

因此：

> 只要 **奇数子数组** 和 **偶数子数组** 本身都是漂亮数组，
> 那么它们拼接后的整体一定仍是漂亮数组。

---

### 2. 数学归纳结构

设存在一个漂亮数组 `A`，长度为 $k$，元素范围为 $[1, k]$，则：

* $2 \times A[i] - 1$ 构成一个长度为 $k$ 的 **奇数漂亮数组**
* $2 \times A[i]$ 构成一个长度为 $k$ 的 **偶数漂亮数组**

于是对于 $n$：

* 奇数部分来源于：$\lceil (n + 1) / 2 \rceil$
* 偶数部分来源于：$\lfloor n / 2 \rfloor$

这直接给出了递归结构：

```text
beautiful(n)
= map(beautiful((n + 1) / 2), x → 2x - 1)
+ map(beautiful(n / 2), x → 2x)
```

---

## 解法一：递归 + 记忆化

### 思路说明

* 利用上述分治结构递归构造
* 使用 `unordered_map` 缓存中间结果，避免重复计算
* $n = 1$ 作为递归基

---

### 代码实现（C++）

```cpp
#include <ranges>
#include <unordered_map>
#include <vector>

class Solution {
 public:
  std::vector<int> beautifulArray(int n) {
    static std::unordered_map<int, std::vector<int>> record{{1, {1}}};

    if (record.contains(n)) {
      return record[n];
    }

    auto&& left = beautifulArray((n + 1) / 2);
    auto&& right = beautifulArray(n / 2);

    std::vector<int> result;
    result.reserve(n);

    std::ranges::transform(left, std::back_inserter(result),
                           [](int x) { return x * 2 - 1; });

    std::ranges::transform(right, std::back_inserter(result),
                           [](int x) { return x * 2; });

    record.try_emplace(n, std::move(result));
    return record[n];
  }
};
```

---

### 复杂度分析

关键点：该递归只会访问到一小撮子规模（大致形如 $2^k$ 与 $2^k - 1$），因此**真正需要构造并缓存的不同 $n$ 的数量是 $O(\log n)$**。例如 $n = 1000$ 时，可能出现的规模大致为：
$1000, 500, 250, 125, 63, 62, 32, 31, 16, 15, 8, 7, 4, 3, 2, 1$。

* **时间复杂度**

  对于每个被真正计算的规模 $m$，需要线性时间把 `left/right` 映射并拼接成长度为 $m$ 的结果，即 $O(m)$。

  所有被真正计算的 $m$ 的总和满足几何级数：

  ```text
  n + n/2 + n/4 + ... < 2n
  ```

  因此构造总成本为 $O(n)$。

  另外，本实现里缓存命中时 `return record[n];` 会**按值返回**产生一次拷贝（$O(m)$），但命中次数同样是 $O(\log n)$，且拷贝的规模之和也被上面的几何级数界住，所以不改变量级。

  * **总时间复杂度：$O(n)$**

* **空间复杂度**

  * 哈希表缓存：存储若干个不同规模 $m$ 的数组，总元素数同样满足

    ```text
    n + n/2 + n/4 + ... < 2n
    ```

    因此为 $O(n)$。

  * 递归调用栈深度：$O(\log n)$。

  * **总空间复杂度：$O(n)$**

---

## 解法二：迭代构造（无递归）

### 思路说明

进一步观察可以发现：

> 一个长度为 $m$ 的漂亮数组，其 **任意前 $k \le m$ 的子序列** 仍然是漂亮数组

因此可以：

1. 从 `{1}` 开始
2. 每一轮将当前数组翻倍：

   * 奇数映射：$2x - 1$
   * 偶数映射：$2x$
3. 过滤掉所有 $> n$ 的元素
4. 重复直到数组长度达到 $n$

该方法本质上是对递归构造的 **自底向上展开**。

---

### 代码实现（C++）

```cpp
#include <ranges>
#include <vector>

class Solution {
 public:
  std::vector<int> beautifulArray(int n) {
    std::vector<int> res{1};
    res.reserve(n);

    while (res.size() < static_cast<std::size_t>(n)) {
      std::vector<int> next;
      next.reserve(n);

      std::ranges::copy(res | std::views::transform([](int x) {
                          return x * 2 - 1;
                        }) | std::views::filter([&](int x) { return x <= n; }),
                        std::back_inserter(next));

      std::ranges::copy(res | std::views::transform([](int x) {
                          return x * 2;
                        }) | std::views::filter([&](int x) { return x <= n; }),
                        std::back_inserter(next));

      res = std::move(next);
    }

    return res;
  }
};
```

---

### 复杂度分析

* **时间复杂度**

  每一轮都会对当前 `res` 扫描两次（生成奇数序列与偶数序列），同时做一次过滤。
  虽然轮数约为 $O(\log n)$，但 `res` 的长度也在增长，且总处理的元素数量被线性界住：每个最终保留下来的元素在构造过程中只会被处理常数次。

  * **总时间复杂度：$O(n)$**

* **空间复杂度**

  仅使用 `res/next` 两个数组，长度均不超过 $n$：

  * **空间复杂度：$O(n)$**

---

## 总结

* 漂亮数组的关键在于 **奇偶拆分 + 数学归纳**
* 解法一：

  * 递归结构清晰，严格对应构造定义
  * 依赖哈希缓存与递归栈，$O(n)$ 时间、$O(n)$ 空间
* 解法二：

  * 自底向上迭代，更工程化
  * 去除了递归与哈希表，仍保持 $O(n)$ 时间、$O(n)$ 空间
