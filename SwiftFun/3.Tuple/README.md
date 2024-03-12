# 튜플(Tuple)

> ☝ 원하는 연관된 데이터의 조합으로 어떤 형태든 만들 수 있는 타입!

<br>

- 변수를 선언과 동시에 해당 멤버는 결정되므로 추가/삭제는 불가하다.

```swift
let twoNumbers: (Int, Int) = (1, 2)
type(of: twoNumbers)

var threeValues = ("홍길동", 20, "서울")
threeValues = ("신승재", 24, "화성") // 반드시 같은 형태로!
```
<br>

- 튜플의 데이터 접근은 `.`으로 할 수 있다.

```swift
threeValues.0 // 홍길동
threeValues.2 // 서울
```

<br>

- Named Tuple!(이름 있는 튜플)

```swift
var threeValues = (Name: "홍길동", Age: 20, Region: "서울")

threeValues.Name // 홍길동
```

Named Tuple은 코드의 가독성을 높혀주고 접근시 용이하다.

<br>

- 튜플의 분해

```swift
let (first, second, third) = (1, 2, 3)
```

튜플의 분해를 사용하면 각 요소를 각각 바인딩이 가능하다.

<br>

- 튜플 활용 - `if`, `switch`

```swift
let iOS = (language: "Swift", version: "5")

if iOS == ("Swift", "5") {
	print("스위프트 버전 5 입니다")
}

switch iOS {
	case ("Swift", "5"):
		print("스위프트 버전 5 입니다")
	default:
		break
}
```

<br>

- 튜플 활용 - 바인딩

```swift
var coorinate = (9, 0)

switch coorinate {
	// 형태가 (let distance, 0)와 같기 때문에
	case (let distance, 0), (0, let distance):
		print("X축 또는 Y축 위에 위치하며, \(distance)만큼의 거리가 떨어져있음")
	default:
		print("축 위에 있지 않음")
}

// X축 또는 Y축 위에 위치하며, 9만큼의 거리가 떨어져있음
```

> 함수에서 `Tuple`을 사용하는 이유 → 함수는 원칙적으로 리턴값이 한 개만 존재함 (꼭 튜플만 가능한것은 아님!)