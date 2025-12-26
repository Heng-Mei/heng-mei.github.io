+++
title = "14-函数不抛出异常请使用 noexcept"
date = "2025-12-23T15:30:00+08:00"
lastmod = "2025-12-26T12:00:00+08:00"

tags = ["cpp", "effective-modern-cpp", "exception", "noexcept"]
categories = ["cpp"]
collections = "Effective Modern C++"

draft = false
weight = 14
+++

> [!abstract]+
> 在 C++98 中，异常说明（exception specifications）因其脆弱、繁琐且缺乏一致性保障，几乎被整个社区所厌弃。
> C++11 彻底推翻了这一设计，引入了 **`noexcept`** ——一种只关心“会不会抛异常”的二值异常说明。
>
> `noexcept` 不仅是**接口契约的一部分**，还直接影响**代码生成质量、异常安全等级以及标准库能否启用移动语义优化**。
> 尤其在 **移动构造 / 移动赋值 / swap / 析构函数** 等关键路径上，`noexcept` 的存在与否，可能决定代码是 *线性时间* 还是 *灾难性回退*。
>
> 本文系统梳理 `noexcept` 的语义演进、优化价值、适用边界与工程实践原则，避免“为了 noexcept 而 noexcept”的错误设计。

---

## 从 C++98 到 C++11：异常说明为何失败

在 C++98 中，函数可以声明**可能抛出的异常类型**：

```cpp
int f(int x) throw(std::runtime_error, std::logic_error);
```

这一设计的问题几乎是结构性的：

* 实现一旦改变，异常说明就可能需要同步修改
* 修改异常说明会影响客户端代码
* 编译器 **无法保证** 实现、声明、调用方三者一致
* 运行时语义复杂且反直觉

最终，大多数工程实践都选择**完全忽略异常说明**。

---

## C++11 的核心转变：只关心「会不会抛」

C++11 统一了异常说明的目标：

> **一个函数，要么可能抛异常，要么绝不抛异常**

于是产生了 `noexcept`：

```cpp
int f(int x) noexcept;
```

* 表示：**函数保证不会抛出任何异常**
* C++98 风格的 `throw()` 被标记为 *deprecated*

---

## `noexcept` 是接口的一部分

是否声明 `noexcept`，并不是实现细节，而是**接口设计决策**。

就像：

* 是否 `const`
* 是否返回引用
* 是否接受右值引用

调用者可能会依赖这些信息：

* 构建异常安全边界
* 决定是否启用移动语义
* 影响模板实例化路径

> [!note]
>
> **知道函数不会抛异常却不标注 `noexcept`，本质上是接口信息缺失。**

---

## 为什么 `noexcept` 能带来更好的优化

比较三种写法：

```cpp
RetType f() noexcept;   // C++11
RetType f() throw();    // C++98
RetType f();            // 无异常说明
```

当异常试图离开函数时：

* **`throw()`**：必须展开调用栈 → 再终止程序
* **`noexcept`**：**允许直接终止，不要求栈可展开**

### 对代码生成的影响

在 `noexcept` 函数中，编译器：

* 不需要保持栈的可展开性
* 不需要保证局部对象逆序析构
* 可以生成更紧凑、更激进的代码

> [!note] 总结
`noexcept`   >  `throw()`  ≈  无异常说明

这已经是**性能层面的硬理由**。

---

## `noexcept` 与移动语义：决定性关系

### 问题背景：`std::vector::push_back`

C++98 中，扩容时通过 **拷贝** 保证强异常安全：

* 若拷贝失败 → 原 vector 不变

C++11 引入 **移动语义** 后，事情变得微妙：

* 若第 n 个元素已移动
* 第 n+1 个移动抛异常
* 原 vector **已被部分破坏**

这是不可接受的。

---

### 标准库的解决方案

标准库采用策略：

> **能安全移动就移动，否则退回拷贝**

判断依据只有一个：

**T 的移动构造函数是否 `noexcept`**

这就是：

```cpp
std::move_if_noexcept
std::is_nothrow_move_constructible
```

的存在意义。

> [!important]
>
> **没有 `noexcept` 的移动构造，等价于不存在移动构造。**

---

## `swap`：noexcept 的放大器

`swap` 是 STL 算法、容器、赋值运算符的基础构件。

标准库中的 `swap` 通常是**条件 noexcept**：

```cpp { title = "swap T[N]", hl_lines=[3]}
template<class T, size_t N>
void swap(T (&a)[N], T (&b)[N])
    noexcept(noexcept(swap(*a, *b)));
```

```cpp { title = "swap pair&ltT1, T2&gt", hl_lines=["4-5"] }
template<class T1, class T2>
struct pair {
    void swap(pair& p)
        noexcept(noexcept(swap(first, p.first)) &&
                 noexcept(swap(second, p.second)));
};
```

结论非常明确：

* **底层类型的 swap 是否 noexcept**
* 决定了所有高层结构是否 noexcept

这形成了一条**向上传导的契约链**。

---

## 不要轻易承诺 `noexcept`

`noexcept` 是**不可轻易反悔的承诺**。

如果你：

* 声明了 `noexcept`
* 后来发现需要抛异常

你只有三种糟糕选择：

1. 修改接口（破坏 ABI / API）
2. 吞掉异常 → 程序终止
3. 重写实现 → 扭曲设计

---

## 大多数函数都是「异常中立」的

异常中立函数：

* 自己不抛异常
* 但允许内部异常向上传播

这种函数 **不应声明为 `noexcept`**。

```cpp
void process()
{
    step1();   // 可能抛
    step2();   // 可能抛
}
```

它的职责不是终止异常，而是**不干涉异常传播**。

---

## 为了 `noexcept` 而扭曲实现是错误的

> [!example]+ 反例
>
> ```cpp
> bool f() noexcept {
>     try {
>         may_throw();
>         return true;
>     } catch (...) {
>         return false;
>     }
> }
> ```

问题：

* 实现复杂化
* 调用点增加分支
* 性能未必更好
* 语义更模糊

> [!warning]
>
> **`noexcept` 是设计结果，不是设计目标。**

---

## 哪些函数应当“天然 noexcept”

### 析构函数

* C++11 起，析构函数 **默认隐式 noexcept**
* 若析构抛异常且被标准库使用 → **未定义行为**

### 内存释放函数

```cpp
operator delete
operator delete[]
```

* 默认 `noexcept`
* 不应抛异常

### 移动构造 / 移动赋值 / swap

* **只要可能，就应 noexcept**
* 这是性能与正确性的交汇点

---

## 宽泛契约 vs 严格契约

### 宽泛契约（wild contract）

* 无前置条件
* 任意状态可调用
* 不产生未定义行为

 **适合 `noexcept`**

---

### 严格契约（narrow contract）

* 存在前置条件
* 违反条件 → 未定义行为

```cpp
void f(const std::string& s) noexcept;
// 前置条件：s.length() <= 32
```

若在 debug 中想检查前置条件：

* 抛异常 ❌（noexcept）
* 只能断言 / 终止

因此，**严格契约函数通常不声明 noexcept**。

---

## 编译器不会替你保证一致性

以下代码是完全合法的：

```cpp
void setup();
void cleanup();

void doWork() noexcept
{
    setup();
    // ...
    cleanup();
}
```

即便 `setup / cleanup` 没有 `noexcept`。

原因很现实：

* 可能来自 C 库
* 可能是 C++98 遗留接口
* 标准库本身也并不完整标注（如 `std::strlen`）

---

## 要点总结

> [!important]
>
> * `noexcept` 是函数接口的一部分
> * `noexcept` 函数更易被优化
> * 移动语义、swap、析构、释放函数高度依赖 `noexcept`
> * **大多数函数是异常中立的，而不是 noexcept**
> * 不要为了 noexcept 扭曲设计
> * 一旦承诺 noexcept，就要长期兑现
