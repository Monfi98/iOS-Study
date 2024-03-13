# 타입 캐스팅(Type Casting)과 확장(Extension)

> 💡 타입 캐스팅은 인스턴스 사용시에 메모리의 값을 수정하는 것이 아니라 어떤 타입으로 사용할지 메모리 구조에 대한 힌트를 변경하는 것이라고 할 수 있다.

<br>

## is 연산자와 as 연산자

- `is` 연산자: 인스턴스 타입을 검사를 수행해주는 연산자이다.

```swift
// Person() -상속-> Student() -상속-> Undergraduate()라고 할때

var person1 = Person()
var student1 = Student()

person1 is Person  // true
person1 is Student // false

student1 is Person  // true
student1 is Student // true
student1 is Undergraduate() // false
```

`is` 연산자는 위 코드 처럼 타입에 대한 검사를 수행하여 참이면 `true` 거짓이면 `false`를 반환한다.
(너무 당연한가?ㅋㅋ)

<br>

- `as` 연산자: 인스턴스 타입의 힌트를 변경해주는 연산자이다.

```swift
var person: Person = Undergraduate()
person.id
person.name
person.email
person.studentId // 접근 불가
person.major // 접근 불가

// 메모리에 studentId와 major의 공간이 있지만 Person 타입이라고 인식하기 때문에 오류가 난다.

// person을 Undergraduate로 다운 캐스팅, 보통 if let 바인딩과 함께 사용한다.
if let newPerson: Undergraduate? = person as? Undergraduate {
	newPerson.id
	newPerson.name
	newPerson.email
	newPerson.studentId
	newPerson.major
}

// 강제 다운캐스팅, 실패할 경우 런타임 오류
let ppb = person as! Undergraduate
```

업캐스팅시에는 항상 성공하기 때문에 `as`만 쓰면 되지만 위 코드 처럼 다운캐스팅시에는 실패 가능성을 가지고 있기 때문에 `as?` 나 `as!`를 쓴다.

<br>

## 타입과 다형성(Polymorphism)


> 💡 다형성은 하나의 객체(인스턴스)가 여러가지 타입의 형태로 표현될 수 있음을 의미한다. 다형성이 구현되는 것은 클래스의 상속과 깊은 연관이 있다.

아직은 어렵다.. 추후에 이해 더하고 내용추가 예정

<br>

## Any와 AnyObject


- Any타입: 기본타입을 포함한 모든 타입의 인스턴스도 표현할 수 있는 타입이다.

```swift
var some: Any = "Swift"

some = 2
some = 3.2

(some as! String).count
// 문자열이 들어있지만 count를 사용할 수 없기때문에 String임을 알려준다.

// Any를 사용하면 옵셔널타입을 포함한 모든 타입을 담을 수 있는 배열이 생성 가능하다.
let array: [Any] = [5, "안녕", Person(), {(name: String) in return name}]
```

Any타입을 사용하면 어떠한 타입도 넣을 수 있지만, 저장된 타입의 메모리 구조를 알 수 없기 때문에, 항상 타입캐스팅을 해서 사용해야 한다.

<br>

- AnyObject 타입: 어떤 클래스 타입의 인스턴스도 표현할 수 있는 타입이다.

```swift
let objArray: [AnyObject] = [Person(), Superman(), NSString()]

(objArray[0] as! Person).name
```

Any타입과 마찬가지로 타입캐스팅을 해서 사용해야한다.

<br>

## 타입의 확장(Extension)


- 수직 확장(상속을 이용)
→ 비슷한 타입을 새로 만들어 데이터(저장속성)을 추가하거나 메서드를 변형시켜 사용하는 것이다.
- 수평 확장 → (extension 이용)현재 존재하는 타입에 기능을 추가하여 사용하는 것이다.
- 재정의는 상속에서만 일어나는 것을 주의 하자

```swift
class SomeType {

}

extension SomeType {
	// 새로운 기능을 추가 가능(메서드 형태만 가능)
	func dosomething() {
		print("do something")
	}
}
```

타입의 확장은 열거형, 클래스, 구조체 모두 가능하다. 또한 스위프트에서는 확장에서 구현한 메서드에 대한 재정의는 불가능하다. (앞에 `@objc`를 붙이면 가능함)

<br>

- 소급-모델링: 확장을 사용하면 애플에서 만들어둔 기본타입을 확장시켜 쓸 수 있다.

```swift
extension Int {
	var squared: Int {
		return self * self
	}
}

5.squared // 25
3.squared // 9
```

<br>

- 타입/인스턴스 계산 속성의 확장

```swift
// 타입 계산 속성의 확장
extension Double {
	static var zero: Double {
		return 0.0
	}
}

Double.zero // 0

// 인스턴스 계산 속성의 확장
extension Double {
	var km: Double {
		return self * 1_000.0
	}
	var cm: Double {
		return self / 100.0
	}
}

10.0.km // 10000
```

<br>

- 타입/인스턴스 메서드의 확장

```swift
Int.random(in: 1...100)

extension Int {
	static func printNumbersFrom1to5() {
		for i in 1...5 {
			print(i)
		}
	}
}

Int.printNumbersFrom1to5()

extension String {
	func printHello(of times: Int) {
		for _ in 0..<times {
			print("Hello \(self)")
		}
	}
}

"Steve".printHello(of: 5)
```

구조체나 열거형에서는 `mutating`키워드를 붙여야 한다.

<br>

- 확장에서의 클래스 생성자 → 편의 생성자만 가능하다!

```swift
extension UIColor {
	convenience init(color: CGFloat) {
		self.init(red: color/255, green: color/255, blue: color/255, alpha: 1)
	}
}
UIColor.init(color: 1)
```

위 코드처럼 아주 쉽게 객체를 생성하는 방법을 제공 할 수 있다.

<br>

- 확장에서의 구조체 생성자 → 구조체의 경우 편의생성자든 지정생성자든 상관이 없다.

```swift
struct Point {
	var x = 0.0, y = 0.0
	// 멤버와이즈 이니셜라이져
}

extension Point {
	init(num: Double) {
		self.init(x: num, y: num)
	}
}
```

<br>

- 서브 스크립트 확장

```swift
extension Int {
	subscript(num: Int) -> Int {
		var decimalBase = 1
		for _ in 0..<num {
			decimalBase *= 10
		}
		return (self/decimalBase) % 10
	}
}
123456789[0] // 9
123456789[1] // 8
```

<br>

- 중첩 타입: 클래스, 구조체 및 열거형에 새 중첩 유형을 추가 가능하다.

```swift
// 중첩 타입
class Day {
	enum Weekday {
		case mon
		case tue
		case wed
	}
	var day: Weekday = .mon
}
var ddd: Day.Weekday = Day.weekday.mon

// 중첩타입의 확장
extension Int {
	enum Kind {
		case negative, zero, positive
	}

	var kind: Kind {
		switch self {
		case 0:
			return Kind.zero
		case let x where x > 0:
			return Kind.positive
		default:
			return Kind.negative
		}
	}
}

let a = 1
a.kind // positive
```