+++
title = "LC 147：对链表进行插入排序"
date = "2025-12-19T19:30:00+08:00"
tags = ["链表", "排序", "插入排序"]
categories = ["算法"]
author = "Heng-Mei"

draft = false
weight = 147
+++

## 题目描述

给定一个单链表的头结点 `head`，请使用 **插入排序** 对链表进行排序，并返回排序后的链表头。

插入排序的基本思想是：

- 维护一个 **已排序的链表前缀**
- 每次从未排序部分取出一个节点
- 将其插入到已排序链表中的正确位置
- 重复直到所有节点处理完成

由于链表 **插入和删除节点是 O(1)**，插入排序在链表结构下非常自然。

---

## 示例

### 示例 1

```markdown
输入:  4 → 2 → 1 → 3
输出:  1 → 2 → 3 → 4
```

### 示例 2

```markdown
输入:  -1 → 5 → 3 → 4 → 0
输出:  -1 → 0 → 3 → 4 → 5
````

---

## 解题思路

### 1. 引入哨兵节点（Dummy Node）

为了统一插入逻辑（尤其是插入到头部的情况），引入一个哨兵节点：

```cpp
ListNode dummy(min_value, head);
````

这样可以避免对 `head` 的特殊判断，使插入操作始终发生在 `dummy` 之后。

---

### 2. 指针含义

在遍历过程中维护两个指针：

- `prev`：指向 **当前已排序区间的最后一个节点**
- `curr`：当前需要处理的节点

结构示意：

```text
dummy → [已排序] → prev → curr → 未排序
```

---

### 3. 已有序的快速判断（关键优化）

如果满足：

```cpp
prev->val <= curr->val
```

说明 `curr` 本身就在正确位置，无需插入，只需要向后推进指针。

这一判断在链表本身接近有序时，可以显著减少扫描次数。

---

### 4. 插入操作流程

当 `curr` 需要插入到已排序区间中时：

1. 将 `curr` 从原位置摘除
2. 从 `dummy` 开始扫描已排序链表
3. 找到第一个 `val >= curr->val` 的节点
4. 将 `curr` 插入到该位置之前

---

## 代码实现（C++）

```cpp
#include <numeric>
#include <utility>

/**
 * Definition for singly-linked list.
 */
struct ListNode {
  int val;
  ListNode* next;
  ListNode() : val(0), next(nullptr) {}
  ListNode(int x) : val(x), next(nullptr) {}
  ListNode(int x, ListNode* next) : val(x), next(next) {}
};

class Solution {
 public:
  ListNode* insertionSortList(ListNode* head) {
    ListNode dummy(std::numeric_limits<int>::min(), head);

    auto prev = &dummy;
    auto curr = head;

    while (curr) {
      if (prev->val <= curr->val) {
        prev = std::exchange(curr, curr->next);
        continue;
      }

      prev->next = curr->next;

      auto scan = &dummy;
      while (scan->next && scan->next->val < curr->val) {
        scan = scan->next;
      }

      curr->next = std::exchange(scan->next, curr);
      curr = prev->next;
    }

    return dummy.next;
  }
};
```

---

## 复杂度分析

- **时间复杂度**

  - 最坏情况：$O(n^2)$（链表完全逆序）
  - 最好情况：$O(n)$（链表本身有序）

- **空间复杂度**

  - $O(1)$，原地排序，仅使用常数额外空间

---

## 总结

- 哨兵节点可以极大简化边界处理
- 合理的有序判断可以显著减少无效操作
