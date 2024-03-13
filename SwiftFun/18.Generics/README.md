# 제네릭(Generics)

> 💡 **제네릭이란?**
> 함수를 하나만 구현을 하면 내부에 있는 타입을 바꿔서 사용할 수 있는 문법이다.
> 제네릭이 없으면 함수의 타입마다 모든 경우를 다 정의해야하기 때문에 코드의 재사용성이나 유지보수면에서 떨어진다.

<br>

- 제네릭이 필요한 이유

```swift
// 제네릭이 없다면, 내부적인 구현은 똑같지만 타입이 모두 다르기 때문에 일일이 구현해줘야한다.

func printIntArray(array: [Int]) {
	for number in array {
		print(number)
	}
}
func printDoubleArray(array: [Double]) {
	for number in array {
		print(number)
	}
}
func printStringArray(array: [String]) {
	for number in array {
		print(number)
	}
}

// 위 코드들을 제네릭으로 바꾸면 이렇게 함수 하나만 정의하면 된다.

func printArray<T>(array: [T]) {
	for number in array {
		print(number)
	}
}
```

위 코드처럼 제네릭이 없는 상태에서 코드를 수정해야한다면 타입마다 정의된 함수를 모두 수정해줘야하기 때문에 재사용성이 떨어진다.

<br>

- 제네릭 예시: 두 값을 바꾸는 함수

```swift
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
	let tempA = a
	a = b
	b = tempA
}

var string1 = "hello"
var string2 = "string1"

swapTwoValues(&num1, &num2)
```

<br>

`<T>` 에서 T는 *‘플레이스 홀더’*라고 한다.

## 제네릭 구조체 /  클래스 / 열거형


클래스, 구조체를 정의하는데 안의 멤버 변수들이 여러가지 타입을 가질 수 있는 가능성이 있을때 제네릭 문법을 쓴다.

<br>

- 제네릭 구조체

```swift
struct GenericMember<T> {
	var members: [T] = []
}

var member1 = GenericMember(members: [1, 2, 3]) // 멤버와이즈 이니셜라이저
var member2 = GenericMember(members: ["Jobs", "Cook", "Musk"])
```

<br>

- 제네릭 클래스

```swift
class GridPoint<A> {
	var x: A
	var y: A

	init(x: A, y: A) {
		self.x = x
		self.y = y
	}
}

let aPoint = GridPoint(x: 10, y: 20)
let bPoint = GridPoint(x: 10.2, y: 20.4)
```

<br>

- 제네릭 열거형

```swift
enum Pet<T> {
	case dog
	case cat
	case etc(T)
}

let animal1 = Pet.etc("고슴도치")
let animal2 = Pet.etc(30)
```

열거형에서는 연관값을 가질때만 제네릭으로 정의가 가능하다.

<br>

- 제네릭 구조체의 확장

```swift
struct Coordinates<T> {
	var x: T
	var y: T
}

extension Coordinates {
	func getPlace() -> (T, T) {
		return (x, y)
	}
}

// 정수형일때만 확장 적용
extension Coordinates where T == Int {
	func getIntArray() -> [T] {
		return [x, y]
	}
}
```

`where`로 타입에 대한 조건을 걸어 선택적으로 확장을 제약할 수 있다.

<br>

## 타입 제약(Type constraint)


- 프로토콜 제약 `<T: Equatable>`

```swift
func findIndex<T: Equatable>(item: T, array: [T]) -> Int? {
	for (index, value) in array.enumerated() {
		if item == value {
			return index
		}
	}
	return nil
}
```

`Equatable` 프로토콜을 채택한 타입만 해당 함수에서 사용 가능하다는 제약이다. `Equatable` 프로토콜에는 `==` 함수가 정의 되어있다.

<br>

- 클래스 제약 `<T: SomeClass>`

```swift
class Person {}
class Student: Person {}

let person = Person()
let student = Student()

func personClassOnly<T: Person>(array: [T]) {
	// code
}

personClassOnly(array: [person, person])
personClassOnly(array: [student, student])
```

특정 클래스와 상속관계 내에 있는 클래스만 타입으로 사용할 수 있다는 제약이다.

<br>

## 프로토콜에서 제네릭 문법

- `associatedtype` T

```swift
protocol RemoteControl {
	associatedtype T
	func changeChannel(to: T)
	func alert() -> T?
}

struct TV: RemoteControl {

	typealias T = Int // 생략 가능

	func changeChannel(to: Int) {
		print("TV 채널 바꿈: \(to)")
	}
	func alert() -> Int? {
		return 1
	}
}

class Aircon: RemoteControl {
	func changeChannel(to: String) {
		print("Aircon 온도 바꿈: \(to)")
	}
	func alert() -> String? {
		return "1"
	}
}
```

프로토콜에서 제네릭을 사용할때는 `asoociatedtype`으로 선언을 해줘야 한다. 또한 해당 프로토콜을 채용한 타입은 `typealias`로 실제 형식을 표시해야 한다. 