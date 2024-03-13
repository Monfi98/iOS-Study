# Defer문

- `defer`은 ‘할일을 미루다’라는 뜻을 가지고 있으며, 코드의 실행을 스코프가 종료되는 시점으로 연기 시키는 문법이다. → 해당 스코프 내에서 작업의 실행을 가장 마지막으로 미룸

```swift
func deferStatement() {
	if true {
		print("먼저 실행하기")
	}
	defer {
		print("나중에 실행하기")
	}
}

deferStatement() // 먼저 실행하기
```

보통 어떤 동작의 마무리 동작을 특정하기 위해서 사용한다.(정리의 개념)
또한 `defer` 키워드를 사용하면 등록한 역순으로 실행되며, 일반적으로 하나의 `defer`문만 사용하는 것이 좋다. 

<br>

- `for`문에서의 `defer`

```swift
for i in 1...3 {
	defer { print("Defer된 숫자: \(i)") }
	print("for문의 숫자: \(i)")
}
// for문의 숫자: i
// Defer된 숫자: i
```