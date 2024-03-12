# 열거형(Enumeration)


> 💡 열거형은 타입 자체를 **한정된 사례 안에서 정의할 수 있는** 타입니다.


- 열거형을 사용하면 코드의 가독성과 안정성이 높아진다!
→ 명확한 분기처리가 가능하다.

<br>

- 기본적인 열거형 사용법

```swift
enum Weekday {
	case monday
	case tuseday
	case wednesday
	case thursday
	case friday
	// ...
}

var today: Weekday = Weekday.monday
```

<br>

- 열거형은 `switch`문으로 분기처리가 가능하다.(거의.. 항상 `switch`문과 사용한다)

```swift
switch today {
case .monday:
	print("오늘은 월요일입니다.")
case .tuseday
	print("오늘은 화요일입니다.")
case .wednesday
	print("오늘은 수요일입니다.")
case .thursday
	print("오늘은 목요일입니다.")
case .friday
	print("오늘은 금요일입니다.")
```

<br>

## 열거형의 원시값과 연관값

- 열거형의 원시(raw value)값

열거형 옆에 자료형을 정의함으로서 원시값을 정의 가능하다.

```swift
enum Alignment: Int {
	case left
	case center
	case right
}

enum Alignment: String {
	case left
	case center = "C"
	case right
}
```

<br>

원시값을 사용하면 열거형을 좀더 쉽게 사용 할 수 있다.

- 원시값 활용해보기

```swift
// 행성 열거형 만들기
enum Planet: Int {
	case mercury = 1, venus, earth, mars, jupiter, saturn
}

let planet = Planet(rawValue: 1)!  // .mercury
```

<br>

- 열거형의 연관값(Associated Values)

열거형의 연관값은 구체적인 추가정보를 저장하기 위해 사용한다.

```swift
enum Computer {
	case cpu(core: Int, ghz: Double)
	case ram(Int, String)
	case hardDisk(gb: Int)
}

Computer.cpu(core: 1, ghz: 2.0)
```

원시값과 다르게 연관값은 변경이 가능하다.

<br>

- 연관값 활용해보기

```swift
enum Computer {
	case cpu(core: Int, ghz: Double)
	case ram(Int, String)
	case hardDisk(gb: Int)
}

var chip = Computer.cpu(core: 8, ghz: 3.1)

switch chip {
case .cpu(core: 8, ghz: 3.1):
	print("CPU 8코어 3.1Ghz입니다")
case .cpu(core: 8, ghz: 2.6):
	print("CPU 8코어 2.6Ghz입니다")
default:
	print("그 이외의 칩에는 관심이 없습니다.")
}
```

<br>

> 원시값과 연관값의 차이: 서로 배타적이므로 열거형에서 원시값과 연관값을 함께 사용하는 것은 불가능함

<br>

- 옵셔널 열거형의 이해

```swift
enum SomeEnum {
	case left
	case right
}

let x: SomeEnum? = .left

// 원칙! 두번 벗겨줘야함
switch x {
case .some(let value):
	switch value {
	case .left:
		print("왼쪽으로 돌기")
	case .right:
		print("오른쪽으로 돌기")
	}
case .none:
	print("계속 전진")
}

// 편의적인 기능 제공
switch x {
	case .some(.left):
		print("왼쪽으로 돌기")
	case .some(.right):
		print("오른쪽으로 돌기")
	case .none:
		print("계속 전진")
}
```

<br>

## 연관값이 있는 경우의 조건문과 반복문


- `if` 문

```swift
if case Computer.hardDisk(gb: let gB) = chip {
	print("\(gb)기가 바이트 하드디스크임")
}
```

값 하나를 사용하려면 스위치문을 전체 다 써야하는 불편함 때문에 `if` 문을 쓰면 이를 해결할 수 있다.

<br>

- `for-in`반복문

```swift
let chiplists: [Computer] = [
	.cpu(core: 4, ghz: 3.0),
	.cpu(core: 8, ghz: 3.5),
	.ram(16, "SRAM"),
	.cpu(core: 8, ghz: 2.5,
]

// cpu인 경우에만 매칭
for case let .cpu(core: c, ghz: h) in chiplists {
	print("CPU: \(c), \(h)헤르츠")
}
```

<br>

## `@unknown`키워드


```swift
enum LoginProvider: String {
	case email
	case facebook
	case google
	case kakotalk // 기존에 카카오톡 로그인이 없었다가 서비스하게 된 사례
}

let userLogin = LoginProvider.email

switch userLogin {
case .email:
	print("이메일 로그인")
case .facebook:
	print("페이스북 로그인")
@unknown default:
	print("구글 로그인")
}
```

`default` 블럭에 `@unknown`키워드를 추가했을 경우 `switch`문에서 열거형에 대한 모든 `case`를 다뤄야한다고 경고창을 띄워준다!