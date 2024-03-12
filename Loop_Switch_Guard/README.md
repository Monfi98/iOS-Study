# 제어문

## 반복문

---

- `for` 문

```swift
for a in 1...10 {
	print(a) // 1, 2, ..., 8, 9, 10
}

for b in (1...10).reversed() {
	print(b) // 10, 9, ..., 3, 2, 1
}

for number in stride(from: 1, to: 15, by: 2) {
	print(number) // 1, 3, 5, 7, 9, 11, 13, 15
}
```

`stride`는 *‘성큼 성큼 걷다’* 라는 의미를 가지고 있다

- `while` 문

```swift
var sum = 0

while num <= 50 {
	num += 1 // 0 ~ 50
}
```

- `repeat-while` 문

```swift
var i = 1

repeat {
	i += 1
} while <= 9 
```

`while` 문과 다르게 일단 한번 실행하고 나서, 조건을 판단해서 실행함

- 레이블이 매겨진 문장과 `continue`, `break`의 사용

```swift
OUTER: for i in 0...3 {
	print("OUTER \(i)")
	INNER: for j in 0...3 {
		if i > 1 {
			print(" j :", j)
			break OUTER
		}
	}
	print("  INNER \(j)")
}
```

labeled를 이용하면 인접 이외의 범위도 제어가 가능하다

## 스위치문

---

```swift
switch a {
case 1:
	print(a)
case 2:
	fallthrough // 안녕하세요 실행
case 3:
	print("안녕하세요")
default:
	break
}
```

## guard문

---

<aside>
💡 `if`문은 여러개의 조건이 있을때 코드의 가독성이 문제되는데, `guard`문으로 사용함으로써 가독성이 안좋은 단점을 극복 할 수 있다.

</aside>

```swift
func checkNumbersOf2(password: String) -> Bool {
	guard password.count >= 6 else { return false }

	// 로그인을 처리하는 code

	return true
}
```

함수에서 `guard`문을 쓰면 early exit(조기 종료)을 할 수 있다.