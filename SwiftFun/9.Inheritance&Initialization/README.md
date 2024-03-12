# 클래스의 상속(Inheritance)과 초기화(Initialization)

## 클래스의 상속과 재정의


- 클래스의 상속

```swift
class Person { // Base 클래스
	var id = 0
	var name = "이름"
	var email = "abc@gmail.com"
}

class Student: Person {
	// id, name, email 변수 존재
	var studentId = 0
}

class Undergraduate: Person {
  // id, name, email 변수 존재
	var major = "전공"
}
```

스위프트에서 다중상속은 불가능하다.
`final` 키워드를 사용하여 상속을 금지 할 수 있다.

<br>

- 재정의(Overriding): 클래스의 상속에서 상위 클래스의 속성/메서드를 재정의 하는것

```swift
class Aclass {
	func doSomething() {
		print("Do something")
	}
}

class Bclass: Aclass {
	override func doSomething() {
		print("Do Something. Do another job")
	}
}
```

상위 클래스에서 존재하는 멤버를 변형하는 것을 재정의라고 하며 `override` 키워드를 통해 하위 클래스에서 상위 클래스의 메서드를 재정의 할 수 있다. 

<br>

- 저장속성(데이터)는 재정의가 불가
(하지만 아래 코드처럼 예외적으로 저장속성에서 계산 속성으로의 재정의는 가능하다.)

```swift
class Aclass {
	var aValue = 0 // 저장 속성

	func doSomething() {
		print("Do something")
	}
}

class Bclass: Aclass {
	override var aValue: Int { // 계산속성으로 재정의
		get {
			return 1
		}
		set { // self가 아닌 super임을 주의하자
			super.aValue = newValue
		}
	}
```

<br>

- 계산 속성의 재정의(계산 속성 → 계산속성으로의 재정의)

```swift
class Vehicle {
	var currentSpeed = 0.0

	var halfSpeed: Double {
		get {
			return currentSpeed /2
		} 
		set {
			currentSpeed = newValue * 2
		}
	}
}

class Bicycle: Vehicle {
	var hasBasket = false

	override var currentSpeed: Double {
		get {
			return super.currentSpeed
		} 
		set {
			currentSpeed = newValue
		}
	}
}
```

계산속성(상위 클래스) → 계산속성(하위 클래스)의 재정의도 가능한데, 기능의 축소로의 재정의는 불가능하다.
(`읽기 O`, `쓰기 X`를 `읽기 X`, `쓰기 O`이런식으로의 재정의는 불가능함)

<br>

## 초기화와 생성자


- 생성자(초기화 메서드) → 구조체, 클래스 모두 가능

```swift
class Color {
	let red, green, blue: Double

	init() {
		red = 0.0
		blue = 0.0
		green = 0.0
	}

	init(red: Double, green: Double, blue: Double) {
		self.red = red
		self.blue = blue
		self.green = green
	}
}

var color1 = Color()
var color2 = Color(red: 0.9, blue: 0.2, green: 0.1)
```

생성자도 오버로딩(overloading)을 지원하기 때문에 여러가지 방법으로 정의할 수 있다.

<br>

- 멤버 와이즈 이니셜라이저: 구조체에서 자동으로 생성해주는 특별한 생성자이다.

```swift
struct Color {
	var red: Double
	var green: Double
	var blue: Double
}

var color = Color(red: 0.9, blue: 0.2, green: 0.1)
```

위 코드 처럼 구조체에서는 Memberwise 이니셜라이저를 자동으로 제공한다.

<br>

- 클래스의 편의 생성자(Convenience) + 상속
→ 개발자가 인스턴스를 생성할때 더 편하게 생성할 수 있도록 도와주는 생성자(구조체에는 없음)이다.

```swift
class Aclass {
	var x: Int
	var y: Int

	init(x: Int, y: Int) { // 지정 생성자
		self.x = x
		self.y = y
	}

	convenience init() { // 편의 생성자
		self.init(x: 0, y: 0)
	}
}

// 상속이 일어나는 경우
class Bclass: Aclass {
	var z: Int

	init(x: Int, y: Int, z: Int) {
		self.z = z // 필수
		super.init(x: x, y: y) // 필수
	}
	
	convenience init(z: Int) { // 편의 생성자
		self.init(x: 0, y: 0, z: z)
	}

	convenience init() { // 편의 생성자
		self.init(z: 0)
	}
}
```

우리가 그동안 사용한 생성자는 지정(Designated)생성자이며 편의(Convenience) 생성자는 지정 생성자보다 적은 갯수의 파라미터로 보다 편리하게 생성하기 위한 서브개념의 생성자라고 이해하면 된다.

보다 바람직한 구현은 실질적으로 가능한 지정생성자의 갯수를 줄이고, 편의 생성자에서 지정생성자를 호출하도록 하는것이 바람직하다.

<br>

- 생성자의 상속과 재정의

```swift
class Aclass {
 
	var x = 0
	
	// init() {}
}

// 상위의 지정 생성자 -> init()
class Bclass: Aclass {

	var y: Int

	// 선택 1: override 재정의
	override init() { // 하위의 지정생성자는 상위의 지정생성자를 호출해주어야 함
		self.y = 0
		super.init()
	}
}

// 상위의 지정 생성자 -> init()
class Cclass: Aclass {

	var y: Int

	// 선택 2: override convenience 재정의 + 하위 클라스 지정생성자 정의
	override convenience init() {
		self.init(y: 0)
	}

	init(y: Int) {
		self.y = y
		super.init()
	}
}

class Dclass: Aclass {

	var y: Int

	// 선택 3: 아예 재정의 안하기
	init(y: Int) {
		self.y = y
		super.init()
	}
}
```

상위의 지정생성자와 현재 단계의 저장속성을 고려해서 구현한다.

<br>

- 지정 생성자 자동 상속의 예외 상황 → 저장속성의 기본값 설정

```swift
class Food {
	var name: String

	init(name: String) {
		self.name = name
	}

	convenience init() {
		self.init(name: "[Unnamed]"
	}
}

class RecipeIngredient: Food {
	var quantity: Int

	init(name: String, quantity: Int) {
		self.quantity = quantity
		super.init(name: name)
	}

	// 상위 지정 생성자를 편의 생성자로 재정의 할 경우
	override convenience init(name: String) { 
		self.init(name: name, quantity)
	}

	// 상위 클라스의 convenience init() { } 자동 상속됨
}
```

<br>

- 편의 생성자 자동상속의 예외 상황 → 상위 지정 생성자 모두 상속

```swift
class ShoppingListItem: RecipeIngredient {
	var purchased = true

	var description: String {
		var output = "\(quantity) x \(name)"
		output += purchased ? "O" : "X"
		return output
	  }

	// init(name: String, quantity: Int) 지정생성자 모두 자동 상속

	// override convenience init(name: String) 자동상속

	// Food 클라스의 convenience init() { } 자동 상속

}
```

<br>

- 필수 생성자(Required)

```swift
class Aclass {
	var x: Int
	
	required init(x: Int) {
		self.x = x
	}
}

class Bclass: Aclass {
	// 자동 상속
}

class Cclass: Aclass {
	// 다른 지정 생성자 구현 했기 때문에 반드시 해당 필수 생성자를 구현해야한다.
	init() { 
		super.init(x: 0)
	}

	required init(x: Int) {
		super.init(x: x)
	}
}
```

클래스 생성자 앞에 `required` 키워드 사용시 하위 생성자는 반드시 해당 필수 생성자를 구현해야한다. 하지만 예외 적으로 다른 지정 생성자를 구현 안하면 자동상속된다.

애플이 만들어놓은 프레임워크때문에 `required` 키워드를 알아놔야한다.(UIKit 등등..)

<br>

- 실패가능 생성자(Failable): 인스턴스 생성에 실패할 수도 있는 가능성을 가진 생성자

```swift
struct Animal {
	let species: String
	
	init?(species: String) {
		if species.Empty {
			return nil // 생성자 내에서 실패가능 부분에 nil을 리턴하면 됨
		}
		self.species = species
	}
}

let a = Animal(species: "Giraffe")
let b = Animal(species: "") // nil
```

실패가 불가능하게 만들어서, 아예 에러가 나고 앱이 완전히 꺼져버리는 상황이 올 수 있기 때문에 실패 가능 생성자를 정의 하여 그에 맞는 예외 처리를 하여 이 상황을 방지 할 수 있다.

또한 범위로 따졌을때 실패 가능 생성자의 범위가 더 크기 때문에 하위에서 실패 불가능 생성자로의 정의가 가능 하며 그 반대는 불가능하다.(실패 불가능 → 실패 가능으로 재정의는 X)

<br>

- 소멸자(Deinitialers): 인스턴스가 메모리에서 해제되기 직전 정리가 필요한 내용을 구현하는 메서드이다.

```swift
class Aclass {
	var x = 0
	var y = 0

	deinit {
		print("인스턴스의 소멸 시점")
	}
}

var: a Aclass? = Aclass()

a = nil // 메모리에 있던 a인스턴스가 제거됨
```

소멸자는 인스턴스가 메모리에서 제거되기 직전에 자동으로 호출된다. 또한 소멸자는 클래스당 최대 1개만 정의 가능하다. (구조체에서는 불가능함)

<br>

- 전체 정리

| 구분 | 구조체(Struct) | 클래스(Class) |
| --- | --- | --- |
| 1. 지정 생성자
(Designated) | init() { } or init(parameters) { }
→ 생성자 구현 안할시, 멤버와이즈 생성자 제공 | init() { } or init(parameters) { }
→ 생성자 구현 안할 시 기본생성자 제공 |
| 2. 편의 생성자
(Convenience) | 지원 x | convenience init(parameters) { } |
| 3. 필수 생성자
(Required) | 지원 x | required init(parameters) { } |
| 4. 실패가능 생성자
(Failable) | init?(parameters) { } 
init!(parameters) { } | init?(parameters) { } 
init!(parameters) { } |
| 5. 소멸자
(Deinitializers) | 지원 x | deinit(){ } |