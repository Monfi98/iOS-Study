# 고차함수(Higer-order Function)

> 💡 **고차 함수란?**
> 함수를 파라미터로 사용하거나, 함수 실행의 결과를 함수로 리턴하는 함수

<br>

- map 함수 → 각 아이템을 매핑해서, 변형하여 새로운 배열을 리턴해준다.

```swift
let numbers = [1, 2, 3, 4, 5]

numbers.map { num in
	return "숫자: \(num)"
}

// numbers = ["숫자: 1", "숫자: 2", ... , "숫자: 5"]
```

<br>

- filter 함수

→ 기존 배열 등의 각 아이템을 조건을 통해 확인 후, true인 아이템을 걸러내서 새로운 배열을 리턴해준다.

```swift
let names = ["Apple", "Black", "Circle", "Dream", "Blue"]

var array = names.filter {
	return str.contains("B")
}

print(array) // ["Black", "Blue"]
```

<br>

- reduce 함수

 → 기존 배열 등의 각 아이템을 클로저가 제공하는 방식으로 결합해서 마지막 결과값을 리턴한다.

```swift
var numbersArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

var array = numbersArray.reduce(0) { result, item in
	return result + item
}

print(array) // 55
```

<br>

- map / filter / reduce 활용

```swift
var numbersArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
// 위의 배열 중에, 홀수만 제곱해서, 그 숫자를 다 더한 값은?

var newResult = numbersArray.filter { $0 % 2 != 0 }
												.map { $0 * $0 }
												.reduce(0) { $0 + $1 }

print(newResult) // 1, 9, 25, 49, 81 ===> 165
```

<br>

- forEach 함수 → 각 아이템별로 특정 작업을 실행한다.

```swift
let immutableArray = [1, 2, 3, 4, 5]

immutableArray.forEach { num in
	print(num)
}

// 1, 2, 3, 4, 5
```

<br>

- compactMap 함수 → 자동으로 옵셔널 요소를 제거하고 새로운 배열을 리턴해준다.

```swift
let stringArray: [String?] = ["A", nil, "B", nil, "C"]

var newStringArray = stringArray.compactMap { $0 }
print(newStringArray) // ["A", "B", "C"]
```

<br>

- flatMap 함수 → 중첩된 배열의 각 배열을 새롭게 매핑해서 내부 중첩된 배열을 제거하고 리턴해준다.

```swift
var nestedArray = [[1, 2, 3], [4, 5, 6], [10, 11, 12], [13, 14, 15]]

var numbersArray = nestedArray.flatMap { $0 }
// 1, 2, 3, 4, 5, ... , 13, 14, 15
```