+++
title = "LC 493：翻转对"
date = "2026-01-03T15:00:00+08:00"
tags = ["分治", "归并排序", "双指针", "数组"]
categories = ["算法"]
collections = ["算法"]

draft = false
weight = 493
+++

## 题目描述

给定一个整数数组 `nums`，如果存在一对下标 $(i, j)$ 满足：

- $i < j$
- $nums[i] > 2 \times nums[j]$

则称 $(i, j)$ 为一个 **重要翻转对（Reverse Pair）**。

请你返回数组中 **重要翻转对的数量**。

---

## 示例

### 示例一

输入：

> [!example]
> 输入：
> [1, 3, 2, 3, 1]
>
> 输出：
> 2

满足条件的翻转对为：

- $(1, 4)$，即 $3 > 2 \times 1$
- $(3, 4)$，即 $3 > 2 \times 1$

---

### 示例二

> [!example]
> 输入：[2, 4, 3, 5, 1]
>
> 输出：3

---

> [!tip]
>
> - $1 \le n \le 50000$
> - 数组元素在 **32 位整数** 范围内
> - 需要注意整数溢出问题（$2 \times nums[j]$）

---

## 解题思路

### 初步分析

这是一个典型的 **在排序过程中统计满足条件数对** 的问题。

如果采用暴力解法，需要枚举所有 $(i, j)$ 组合，其时间复杂度为：$ O(n^2) $

当 $ n = 50000 $ 时显然不可接受，因此需要借助 **分治 + 归并排序** 的思想，将整体复杂度降低为：$ O(n \log n) $

---

### 核心思想：分治与归并排序

在归并排序的递归过程中，数组会被不断拆分为左右两部分：

$$
[left\ half] + [right\ half]
$$

在合并之前，左右子数组已经分别有序。

这为本题提供了关键条件：
> [!important]
> 在左右子数组均有序的前提下，可以通过 **双指针** 在线性时间内统计跨区间的翻转对。

---

### 关键观察

在合并阶段，设：

- 左区间为 $[L, mid)$
- 右区间为 $[mid, R)$

我们需要统计满足条件的数对：

$$
nums[i] > 2 \times nums[j], \quad i \in [L, mid),\ j \in [mid, R)
$$

由于左右区间各自有序：

> [!important]
>
> - 对于固定的 $j$，满足条件的 $i$ 在左区间中必然构成一个 **连续区间**
> - 可以通过单调移动指针一次性完成统计

---

### 双指针统计方法

设：

- `left_ptr` 指向左区间起始
- `right_ptr` 指向右区间起始

对于每一个 `right_ptr`：

1. 不断右移 `left_ptr`，直到满足：`nums[left_ptr] > 2 nums[right_ptr]`
2. 此时左区间中满足条件的元素个数为：`mid - left_ptr`

由于两个指针都只向前移动，整体统计过程为线性时间。

---

### 递归结构说明

整个算法可以表示为：

$$
\text{solve(nums)} =
\text{solve(left)} +
\text{solve(right)} +
\text{cross_pairs}
$$

在递归回溯阶段，通过 `inplace_merge` 保证当前区间重新变为有序，为上一层递归提供前提条件。

---

## 代码实现（C++）

```cpp
#include <algorithm>
#include <ranges>
#include <span>
#include <vector>

class Solution {
  int sub_reverse_pairs(std::span<int> nums) {
    if (nums.size() <= 1) {
      return 0;
    }

    auto mid = nums.size() / 2;

    int ans = sub_reverse_pairs(nums.first(mid)) +
              sub_reverse_pairs(nums.subspan(mid));

    auto left_ptr = nums.begin();
    auto mid_ptr = std::next(nums.begin(), mid);
    auto right_ptr = mid_ptr;

    while (left_ptr != mid_ptr && right_ptr != nums.end()) {
      while (left_ptr != mid_ptr &&
             static_cast<long long>(*left_ptr) <=
                 2LL * static_cast<long long>(*right_ptr)) {
        ++left_ptr;
      }
      ans += std::distance(left_ptr, mid_ptr);
      ++right_ptr;
    }

    std::ranges::inplace_merge(nums, mid_ptr);
    return ans;
  }

 public:
  int reversePairs(std::vector<int>& nums) {
    return sub_reverse_pairs(std::span<int>(nums));
  }
};
```

---

## 复杂度分析

### 时间复杂度

- 递归深度为 $O(\log n)$
- 每一层合并与统计操作为 $O(n)$

因此总体时间复杂度为：

$$
O(n \log n)
$$

---

### 空间复杂度

- 递归调用栈占用 $O(\log n)$
- 使用原地归并，不额外分配辅助数组

总体空间复杂度为：

$$
O(\log n)
$$

---

## 易错点与实现细节

### 整数溢出问题

条件判断：

$$
nums[i] > 2 \times nums[j]
$$

在实现时必须使用 `long long`，否则在极端输入下可能产生溢出。

---

### 统计顺序要求

- 翻转对的统计必须发生在 **合并之前**
- 一旦完成 merge，将无法区分左右区间边界

---

### 使用 `inplace_merge` 的原因

- 保证当前区间在递归返回前保持有序
- 为上一层递归的统计过程提供正确前提

---

## 总结

- 本题是 **归并排序在条件数对统计问题中的经典应用**
- 核心在于：
  - 利用分治思想缩小问题规模
  - 利用排序后的区间结构进行线性统计
- 对理解“在排序过程中计算答案”这一类问题具有很强的代表性

> [!note]
> 本题也可使用树状数组/线段树解决
