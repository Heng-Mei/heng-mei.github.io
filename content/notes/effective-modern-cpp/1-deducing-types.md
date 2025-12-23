+++
title = "01-类型推导 (Deducing Types)"
date = "2025-12-20T19:30:00+08:00"
tags = ["cpp", "effective-modern-cpp"]
categories = ["cpp"]
collections = "Effective Modern C++"

draft = false
weight = 1
+++

> [!abstract]+
在 C++98 中，类型推导主要服务于**函数模板**；到了 C++11，语言在此基础上新增并强化了两套规则，分别用于 `auto` 和 `decltype`；C++14 又进一步扩展了它们的适用场景。类型推导的广泛应用，极大减少了冗长、重复的类型书写，使代码更具可维护性与适应性——修改一处类型，影响可自动传播到全局。
>
> 但代价是：**类型推导并不总是“直觉正确”**。如果对其规则缺乏系统理解，写出真正“现代风格”的 C++ 几乎是不可能的。
>
> 本文聚焦最基础、也是最重要的一点：**模板类型推导**。这是 `auto`、`decltype(auto)` 等特性的理论根基。

## 模板类型推导的基本模型

考虑如下函数模板：

```cpp
template<typename T>
void f(ParamType param);

f(expr);
```

编译器会基于 `expr` 同时推导出两个类型：

* `T`
* `ParamType`

二者并不一定相同，`ParamType` 可能包含 `const`、引用等修饰。类型推导的行为，**完全取决于 `ParamType` 的形式**。

可以将规则归纳为三种情景。

---

## 情景一：`ParamType` 是引用或指针（但不是通用引用）

这是最直观、也最符合直觉的一类。

### 推导规则

1. 若 `expr` 是引用，**忽略引用本身**
2. 用处理后的类型与 `ParamType` 匹配，推导 `T`

### 示例

```cpp
template<typename T>
void f(T& param);

int x = 27;
const int cx = x;
const int& rx = x;

f(x);   // T = int          param = int&
f(cx);  // T = const int    param = const int&
f(rx);  // T = const int    param = const int&
```

> [!important]
>
> * **引用性在推导中会被忽略**
>
> * **const 会成为 T 的一部分（当 ParamType 不是 const T& 时）**

### `const T&` 的变化

```cpp
template<typename T>
void f(const T& param);

f(x);   // T = int
f(cx);  // T = int
f(rx);  // T = int
```

此时 `const` 已由 `ParamType` 承担，不再属于 `T`。

### 指针同理

```cpp
template<typename T>
void f(T* param);

const int* px = &x;

f(&x);  // T = int
f(px);  // T = const int
```

---

## 情景二：`ParamType` 是通用引用（`T&&`）

这是模板类型推导中**最反直觉、也最重要**的一种情况。

### 推导规则

* **左值实参**：`T` 和 `ParamType` 都被推导为**左值引用**
* **右值实参**：按“情景一”的常规规则推导

### 示例

```cpp
template<typename T>
void f(T&& param);

int x = 27;
const int cx = x;
const int& rx = cx;

f(x);   // T = int&          param = int&
f(cx);  // T = const int&    param = const int&
f(rx);  // T = const int&    param = const int&
f(27);  // T = int           param = int&&
```

> [!important]
>
> * **这是唯一一种 T 会被推导为引用的情况**
>
> * **通用引用会区分左值与右值，而普通引用不会**

---

## 情景三：`ParamType` 既不是指针也不是引用（传值）

```cpp
template<typename T>
void f(T param);
```

此时 `param` 是一个**全新的对象拷贝**。

### 推导规则

1. 忽略 `expr` 的引用
2. 再忽略顶层的 `const` / `volatile`

### 示例

```cpp
int x = 27;
const int cx = x;
const int& rx = cx;

f(x);   // T = int
f(cx);  // T = int
f(rx);  // T = int
```

原因很简单：
**原对象是否 const，与它的拷贝是否可修改无关**。

### 一个易错点：const 指针

```cpp
const char* const ptr = "hello";

f(ptr); // T = const char*
```

* 指针指向的数据的 `const` 被保留
* **指针自身的 `const` 被丢弃**

---

## 数组实参：退化与不退化

数组在 C++ 中常被“伪装”成指针，但这并非总是如此。

### 传值：数组退化为指针

```cpp
const char name[] = "J. P. Briggs";

template<typename T>
void f(T param);

f(name); // T = const char*
```

因为**数组形参在语法层面等价于指针形参**。

### 传引用：数组不会退化

```cpp
template<typename T>
void f(T& param);

f(name); // T = const char[13]
```

此时：

* `T` 包含数组大小
* `param` 类型为 `const char (&)[13]`

### 一个实用技巧：推导数组大小

```cpp
template<typename T, std::size_t N>
constexpr std::size_t arraySize(T (&)[N]) noexcept {
    return N;
}
```

用法：

```cpp
int a[] = {1,2,3,4};
std::array<int, arraySize(a)> b; // 大小为 4
```

---

## 函数实参：与数组完全一致

函数类型同样会退化为指针，除非以引用形式接收。

```cpp
void someFunc(int, double);

template<typename T>
void f1(T param);

template<typename T>
void f2(T& param);

f1(someFunc); // T = void(*)(int, double)
f2(someFunc); // T = void(&)(int, double)
```

---

## 总结：你必须记住的规则
>
> [!important]
>
> * 引用实参在推导时会**被视为非引用**
> * **通用引用**对左值实参有特殊处理
> * 传值推导会忽略 `const` / `volatile`
> * **数组名与函数名会退化为指针**，除非用于初始化引用

理解这些规则，你才能真正掌控 `auto`、`decltype(auto)`、完美转发，以及现代 C++ 的类型系统。
