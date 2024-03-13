# 프로토콜(Protocol)

## 프로토콜

> 💡 **프로토콜이란?**
> 프로토콜은 규약이라는 의미를 가지고 있으며, 스위프트 내에서는 클래스, 구조체, 열거형이 특정 기능을 할 수 있도록 가이드를 제시하는 역할을 한다. 아래 코드를 보면서 이해하자.

<br>

- 프로토콜의 기본 사용법

```swift
protocol CanFly {
	func fly() // 구체적인 구현은 하지 않는다.
}

class Bird: CanFly {
	var isFemale = true

	func layEgg() {
		if isFemale {
			print("새가 알을 낳는다.")
		}
	}

	func fly() { // fly 메서드를 정의하지 않으면 경고문이 뜬다.
		print("새가 난다")
	}
}

// 상속을 할경우 클래스, 프로토콜 순으로 명시한다.
class Eagle: Bird, CanFly {
	func soar() {
		print("공중으로 활공한다")
	}
} 
```

위 처럼 프로토콜은 정의만 제시할 뿐이지 안에 있는 코드는 작성하지 않는다.

<br>

## 속성


- 속성의 요구사항을 정의하는 방법

```swift
protocol RemoteMouse {
	var id: String { get } // 최소한의 요구사항 - 읽기

	var name: String { get set } // 최소한의 요구사항 - 읽기, 쓰기

	static var type: String { get set } // 최소한의 요구사항 - static(타입속성), 읽기, 쓰기
}

class TV: RemoteMouse {
	var id: String {
		get {
			return "안녕하세요"
		}
	}
	var name: String = "삼성 티비"
	
	static var type: String = "리모콘"
}

class Ipad: RemoteMouse {
	var id: String = "777"

	var name: String = "아이패드"

	class var type: String { // class를 사용해서 재정의는 가능하다.
		get { "리모콘" }
		set { }
	}
}
```

<br>

## 메서드


- 메서드의 요구사항을 정의하는 방법: 채택을 하고 구현만하면됨!

```swift
protocol RandomNumber {
	static func reset()
	func random() -> Int
}

class Number: RandomNumber {

	static func reset() {
		print("다시 셋팅")
	}
	
	func random() -> Int {
		return Int.random(in: 1...100)
	}
}

protocol Togglable {
	mutating func toggle() // mutating키워드는 메서드 내에서 속성 변경의 의미일뿐임
}

enum OnOffSwitch: Togglable {
	switch self {
	case .off:
		self = .on
	case .on:
		self = .off
	}	
}
```

열거형이나 구조체에서 속성 변경을 하려면 `mutating`키워드를 사용하면된다.

<br>

## 생성자


- 생성자의 요구사항을 정의하는 방법

```swift
// 1. 클래스는 생성자 앞에 required를 붙여야함
// 2. final을 붙여서 상속을 막으면 required 생략 가능
// 3. 클래스에서는 방드시 지정 생성자로 구현할 필요없음

protocol SomeProtocol {
	init(num: Int)
}

class SomeClass: SomeProtocol {
	// required init(num: Int) 아무것도 안하면 자동 상속
}
```

구조체는 상속이 없기때문에 `required` 키워드는 필요없다. (모든것을 다 외울필요는 없음. xcode에서 알려주기때문)

<br>

- 실패가능 생성자

```swift
protocol AProto {
	init?(num: Int)
}

struct AStruct: AProto {
	init?(num: Int) {}

	init(num: Int) {}

	init!(num: Int) {} // 잘 사용은 안함
}
```

프로토콜은 최소요구사항을 지정해주기 때문에 범위를 생각해서 구현해야한다.
예를 들어, 프로토콜에서 `init?()` 선언 → `init()`, `init?()`, `init!()`로 구현할 수 있지만 프로토콜에서 `init()`로 선언할 경우 `init?()`은 불가능하다.

<br>

## 서브스크립트


- 서브 스크립트의 요구사항

```swift
protocol DataList {
	subscript(idx: Int) -> Int { get } // 서브스크립트에서 get필수!
}

struct DataStructure: DataList {
	subscript(idx: Int) -> Int {
		get { return 0 }
		set { // 해도되고 안해도 됨! }
	}
}
```

<br>

## 프로토콜 심화


- 관습적으로 확장(Extension)에서 구현을 한다.

```swift
protocol Certificate {
	func doSomething()
}

class Person {

}

// 관습적으로 확장에서 구현을 함
extension Person: Certificate {
	func doSomething() {
		print("Do something")
	}
}
```

확장에서 구현을 하는 이유는 코드를 깔끔하게 정리할 수 있기 때문이다!

<br>

- 프로토콜은 타입이다. 스위프트에서 프로토콜은 일급객체로 취급한다.
    - 변수에 할당할 수 있다.
    - 함수를 호출할때, 파라미터로 전달할 수 있다.
    - 함수에서 반환할 수 있다.

```swift
protocol Remote {
	func turnOn()
	func turnOff()
}

struct SetTopBox: Remote {
	func turnOn {
		print("셋톱박스를 켰습니다.")
	}
	func turnOff {
		print("셋톱박스를 껐습니다.")
	}
	func doNetflix() {
		print("넷플릭스를 켰습니다.")
	}
}

let sbox: Remote = SetTopBox() // 프로토콜타입으로 선언
sbox.turnOn()
sbox.turnOff()
// doNetflix()는 안됨
```

프로토콜 타입으로 선언할 경우, 위 코드처럼 프로토콜에서 명시해놓은 함수만 쓸 수 있다.

<br>

- 프로토콜 타입취급의 장점

```swift
// 배열에 넣을 수 있음
let electronic: [Remote] = [tv, sbox]

for item in electronic {
	item.turnOn()
}

// 매개변수로 넣을 수 있음
func turnOnSomeElectronics(item: Remote) {
	item.turnOn()
}

turnOnSomeElectronics(item: tv)

// 업캐스팅, 다운캐스팅 가능
let newBox = sbox as Remote
newBox.turnOn()
newBox.turnOff()

let sbox2 = sbox as? SetTopBox
sbox2?.doNetflix
```

<br>

## 프로토콜의 상속


- 프로토콜은 다중 상속이 가능하다.
ex) `C protocol`은 `A protocol`, `B protocol` 둘다 상속받을 수 있다.

```swift
protocol Remote {
	func turnOn()
	func turnOff()
}

protocol AirConRemote {
	func Up()
	func Down()
}

protocol SuperRemoteProtocol: Remote, AirConRemote {
	// func turnOn()
	// func turnOff()
	// func Up()
	// func Down()
}
```

프로토콜의 상속은 그저 여러가지 요구사항의 나열일뿐이다. 

<br>

- 프로토콜의 합성 문법

```swift
protocol Named {
	var name: String { get }
}

protocol Aged {
	var age: Int { get }
}

struct Person: Named, Aged {
	var name: Stirng
	var age: Int
}

func wishHappyBirthday(to celebrator: Named & Aged) {
	print(celebrator.name, celebrator.age
}
```

위 코드처럼 `&`로 두 프로토콜을 병합해서 타입으로 사용할 수 있다.(합성된 타입으로 인식)

<br>

## 프로토콜의 선택적 요구사항의 구현


- 요구사항을 선택적(구현을 해도되고 안해도 되는)으로 구현할 수 있다.

```swift
@objc protocol Remote {
	@objc optional var isOn: Bool { get set } // 선택적 구현가능
	func turnOff()
	func turnOn()
}
```

선택적으로 구현을 할 수 있게 하려면 `@objc` 어트리뷰트를 써줘야 한다.

<br>

## 프로토콜의 확장(Protocol Extension)


- 프로토콜 기본 구현 제공

```swift
protocol Remote {
	func turnOn()
	func turnOff()
}

extension Remote {
	func turnOn() { print("리모콘 켜기") } // 확장에서 구체적으로 구현을 하면 기본제공을 해줌
	func turnOff() { print("리모콘 끄기") }

	func doAnotherAction() { // 타입에 따라 달라짐
		print("리모콘 또 다른 동작")
	}
}

class TV1: Remote {
	func turnOn() { print("TV켜기") }

	func doAnotherAction() {
		print("TV 또 다른 동작")
	}
}

var tv1: Remote = TV1()
tv1.doAnotherAction() // 리모콘 또 다른 동작

var tv2: TV1 = TV1()
tv2.doAnotherAction() // TV 또 다른 동작
```

프로토콜을 쓰다보면 프로토콜을 채택한 클래스들이 반복적으로 요구사항을 구현해야한다. 따라서 확장을 통해서 구체적인 구현을 하면 프로토콜을 채택한 클래스들에게 기본 구현을 제공한다. 또한 실제 클래스에서 기본 구현이 아닌 직접적으로 구현을 했을 경우, 직접적으로 구현한 메서드가 우선순위로 작용한다.

<br>

- 프로토콜 확장의 적용 제한

```swift
protocol Remote {
	func turnOn()
	func turnOff()
}

protocol Bluetooth {
	func blueOn()
	func blueOff()
}
// Remote 프로토콜을 채택한 경우에만 Bluetooth확장이 적용된다.
extension Bluetooth where Self: Remote {
	func blueOn() { print("블루투스 켜기") }
	func blueOff() { print("블루투스 끄기") }
}

class SmartPhone: Remote, Bluetooth {
	// blueOn()
	// blueOff()
}
```

`where Self: 특정 프로토콜` 을 사용하면 특정 프로토콜을 채택한 타입에만 프로토콜 확장이 적용되도록 제한한다.