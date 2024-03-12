# 클래스(Class)와 구조체(Struct)

> **클래스와 구조체는 언제쓸까?**
> 
> - 변수와 상수, 기본 자료형만으로 쓰기 어렵고 데이터들이 연관되었을때
> - 사실 프로젝트의 사례 적합성에 따라 선택

<br>

## 클래스(Class)란?

> 💡 클래스는 붕어빵을 찍어낼 수 있는 틀(frame)에 해당하며, 찍어낸 붕어빵은 객체라고 비유 할 수 있다.

```swift
class Dog {
	var name = "강아지 이름"
	var weight = 0.0

	func sit() {
		print("\(self.name)가 앉았습니다."
	}
}

var bori = Dog()

bori.name = "보리"
bori.weight = 3.2

var danji = Dog()

danji.name = "단지"
danji.weight = 2.2
```

클래스를 이용하여 순식간에 강아지(인스턴스)를 두 마리나 생성해버려따!

- `name`, `weight` → 속성(property)
- `sit()` → 메서드(method)

<br>

- 클래스의 생성자를 사용하면 클래스 내의 속성들을 초기화 해줄 수 있다.

```swift
class Dog {
	var name: String
	var weight: Double

	init(name: String, weight: Double) {
		self.name = name
		self.weight = weight
	}
}

var bori = Dog(name: "보리", weight: 15.0)
var danji = Dog(name: "단지", weight: 2.2)
```

위 코드를 보면 데이터를 넣어서 생성자를 통해 바로 인스턴스를 생성하는 것을 볼 수 있다.

<br>

- 속성이 옵셔널 타입인 경우

```swift
class Dog {
	var name: String?
	var weight: Double

	init(weight: Double) {
		self.weight = weight
	}
}

var bori = Dog(weight: 15.0)
print(bori.name) // nil
```

값을 주면 `Optional`, 값을 안주면 `nil`을 출력한다.

<br>

## 구조체(Struct)란?

> 💡 구조체도 클래스와 비슷하지만 메모리 저장방식의 차이가 있다.
> 구조체는 값형식(value type)이며 클래스는 참조형식(reference type)이다. 따라서 구조체의 인스턴스 데이터는 스택에 저장되고 클래스의 인스턴스 데이터는 힙에 저장된다.

<br>

- 클래스와 구조체의 메모리

```swift
class Person {
	var name = "사람"
}

struct Animal {
	var name = "동물"
}

var p = Person()
var p1 = p // p1과 p는 같은 메모리 주소를 가리킴
p.name = "승재"
print(p1.name) // 승재

var a = Animal()
var a1 = a // 복사
a1.name = "강아지"
print(a.name) // 동물
print(a1.name) // 강아지
```

구조체가 클래스보다 가볍기 때문에 보통 더 많이 사용한다.

<br>

## 속성(property)

속성은 구조체와 클래스에서 거의 차이가 없다.
<br>

- 저장속성: 값이 저장되는 일반적인 속성이다.(메모리 공간을 가지는 속성)

```swift
struct Bird {
	var name: String
	var weight: Double

	init(name: String, weight: Double) {
		self.name = name
		self.weight = weight
	}
}

var birdA = Bird(name: "참새", weight: 2.2) // 저장속성 이용!
var birdB = Bird(name: "뱁새", weight: 3.2) // 저장속성 이용!
```

생성시 각 인스턴스는 고유의 데이터 저장공간을 가지기 때문에 데이터를 저장할 수 있다.

<br>

- 지연저장 속성(Lazy Stored Properties)

```swift
struct Bird {
	var name: String
	lazy var weight: Double = 0.0 // 선언시 기본값을 반드시 저장해야함

	init(name: String) {
		self.name = name
	}
}

var birdA = Bird(name: "참새")
birdA.weight = 2.2 // 이때 메모리 공간 확보

```

지연저장 속성은 처음에는 데이터 저장공간을 가지지 않지만 `lazy`키워드를 가진 속성에 접근을 하면 그때 생성된다. 따라서 `lazy let`은 불가능하다.

<br>

- 계산 속성 → 값을 얻기 위한다면 `get` 블록, 저장하려고 한다면 `set` 블록을 실행한다.

```swift
struct Person {
	var birth: Int = 0
	var age: Int {
		get { // getter
			return 2021 - birth
		}
		set { // setter
			self.birth = 2021 - newValue
		}
	}
}

p1.birth = 2000
p1.age // get 블록 실행
p1.age = 10 // set 블록 실행
```

계산 속성을 사용하면 클래스 내에 따로 `get`, `set`메서드를 구현해서 쓰는 것보다 가독성도 좋고 코드길이도 짧다. 또한, `set` 블록에서 매개변수를 명시해도 되지만 위 코드처럼 생략하고 `newValue`를 쓸 수도 있다.

<br>

- 타입 속성 → 인스턴스에 속하지않고 타입자체에 속하는 속성이다.

```swift
class Circle {
	// 저장 타입 속성
	static let pi: Double = 3.14 // pi는 어떤 인스턴스에서도 불변이다.
	static var count: Int = 0 // 인스턴스를 몇개를 찍어냈는지 세는 용도로 사용할 수 있다.

	// 저장 속성
	var radius: Double // 인스턴스마다 다르기 때문에 그냥 저장속성으로 사용한다.

	// 계산 타입 속성
	static var multiPi: Double { // multi pi의 계산법은 모든 인스턴스가 동일하다.
		return Circle.pi * 2
	}

	// 계산 속성
	var diameter: Double {
		get {
			return radius * 2
		}
		set {
			radius = newValue / 2
		}
	}

	init(radius: Double) {
		self.radius = radius
		Circle.count += 1
	}

	func getArea() -> Double {
		let area = Circle.pi * radius * radius
		return area
	}
}
```

위 코드와 같이 `pi`, `count`(저장 속성), `multiPi`(계산 속성) 모두 타입속성이 될 수 있다.

또한 저장 속성은 기본적으로 `lazy`의 성격을 가진다.

<br>

- 속성 감시자(Property Observer)
→ 변수가 변할때 변경 내용을 다른곳에 반영하고 싶을때 필요함(업데이트 처럼…)

```swift
class Profile {
	var name: String = "이름"

	var statusMessage: String = "기본상태 메시지" {
		willSet(message) { // 바뀔 값이 파라미터로 전달됨
			print("메시지가 \(statusMessage)에서 \(message)로 변경될 예정입니다.")
		}
	//	willSet {
	//		print("메시지가 \(statusMessage)에서 \(newValue)로 변경될 예정입니다.")
	//	}
		didSet(message) { // 바뀌기 전의 과거값이 파라미터로 전달됨
			print("메시지가 \(message)에서 \(statusMessage)로 변경되었습니다.")
		}
	//  didSet {
	//		print("메시지가 \(oldValue)에서 \(statusMessage)로 변경되었습니다.")
	//	}
	}
}

let p = Profile()

p.statusMessage // 기본상태 메시지
p.statusMessage = "행복해" //메시지가 기본 상태메시지에서 행복해로 변경될 예정입니다.
```

성격은 메서드 형태를 띄며 저장 속성을 감시한다. `willSet()`은 새 값이 저장되기 이전에 호출되며, `didSet()`은 새 값이 저장된 직 후에 호출된다. 위 코드를 보고 각각의 파라미터를 유의하면서 보자.

(기본적으로 매개변수 대신에 `oldValue`, `newValue`로도 사용할 수 있음 )

<br>

## 메서드(method)

- 인스턴스 메서드 → 가장 기본적인 메서드

```swift
class Dog {
	var name = "강아지 이름"
	var weight = 0.0

	func sit() {
		print("\(self.name)가 앉았습니다."
	}
	func layDown() {
		print("\(self.name)가 엎드렸습니다."
	}
	func trainning() {
		self.sit()
		self.layDown()
	}
	func changeName(newName name: String) {
		self.name = name
	}
}

var bori = Dog()

bori.sit() // 보리가 앉았습니다.
```

위 코드 처럼 self 키워드를 사용하여(생략도 가능) 메서드 안에서 다른 메서드를 호출 할 수 있다.

<br>

- 구조체에서 인스턴스 메서드

```swift
struct Dog {
	var name = "강아지 이름"
	var weight = 0.0

	func sit() {
		print("\(self.name)가 앉았습니다."
	}
	func layDown() {
		print("\(self.name)가 엎드렸습니다."
	}
	func trainning() {
		self.sit()
		self.layDown()
	}
	mutating func changeName(newName name: String) {
		self.name = name
	}
}

var bori = Dog()

bori.sit() // 보리가 앉았습니다.
```

구조체의 인스턴스 메서드 내에서 자신의 속성값 수정은 원칙적으로 불가하기 때문에(값타입이기 때문에) `mutating`키워드를 사용하여 속성값을 수정 할 수 있다.

<br>

- 메서드 오버로딩(Overloading)

```swift
class Dog {
	var name = "강아지 이름"
	var weight = 0.0

	func sit() {
		print("\(self.name)가 앉았습니다."
	}
	func sit(a: String) {
			print("\(a)가 반만 앉았습니다."
	}
}

var bori = Dog()

bori.sit() // 보리가 앉았습니다.
bori.sit(a: "보리") // a가 반만 앉았습니다.
```

일반 함수와 같이 인스턴스의 메서드도 오버로딩을 지원한다.

<br>

- 타입 메서드(type method)

```swift
class Dog {
	static var species = "Dog"

	var name = "강아지 이름"
	var weight = 0.0

	init(name: String, weight: Double) {
		self.name = name
		self.weight = weight
	}

	func sit() {
		print("\(self.name)가 앉았습니다."
	}

	static func letmeKnow() { // 타입 메서드
		print("종은 항상 \(species)입니다.")
	}
}

var bori = Dog()

bori.sit() // 보리가 앉았습니다.
Dog.letmeKnow() // 종은 항상 Dog입니다.
```

`static`키워드로 선언시 상속할때 재정의는 불가하다.

<br>

- 서브스크립트(subscripts) → 대괄호를 사용하는 문법이다. ex) `array[2]`

```swift
class someData {
	var datas = ["Apple", "Swift", "iOS", "Hello"]
	
	subscript(index: Int) -> String {
		get {
			return datas[index]
		}
		set {
			datas[index] = newValue
		}
	}
	
}

var data = someData()
data[0] = "AAA"
```

<br>

- 타입 서브스크립트(Type subscripts)

```swift
enum Planet: Int {
	case mercuray = 1, venus, earth, mars

	static subscript(n: Int) -> Planet {
		return Planet(rawValue: n)!
	}
}

let mars = Planet[4] //Planet.mars
```