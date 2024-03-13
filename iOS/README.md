# iOS

## **단축키**

- `control` + `I`:  자동으로 줄맞추기
- `command` + `shift` + `y`: 콘솔 업다운

<br>

## **import Foundation?**

- Objective-C 언어와 관련된 기능을 제공한다.
- 컬렉션 `NSArray`, `NSMutableArray`, `NSDictionary`, `NSSet` 등을 제공한다.
- 데이터나 날짜 관련 `NSData`, `NSDate` 등을 제공한다.
- 외울 필요는 없음!

<br>

## **상속관계에서 생성자 위임 규칙**

1. **델리게이트 업(Delegate Up)**
    
    서브 클래스의 지정 생성자는 슈퍼 클래스의 지정생성자를 반드시  호출해야한다.

<br>

2. **델리게이트 어크로스(Delegate across)**
    
    편의 생성자는 동일한 클래스에서 다른 편의 생성자 또는 지정 생성자를 호출해야하고 궁극적으로는 지정 생성자를 호출해야한다.
    

<br>

## **프로토콜 지향 프로그래밍**

애플이 최초로 프로토콜 지향 프로그래밍 패러다임을 제시했다.

<br>

**클래스와 상속의 단점**

- 하나의 클래스만 상속이 가능하다.
- 하위클래스는 상위클래스의 메모리 구조를 따라갈 수 밖에 없다.
- 클래스에서만 가능하다.

<br>

**하지만 프로토콜 지향 프로그래밍일 경우?**

- 여러개의 프로토콜 채택이 가능하다. → 조합의 장점을 살려서 구성/재사용성을 높일 수 있다.
- 메모리 구조에 대한 특정 요구사항이 없다. → 필요한 속성/메서드만 채택해서 사용할 수 있다.
- 모든 타입에서 채택이 가능하다. → 활용성이 늘어난다.

<br>

## **Method Dispatch**

스위프트가 함수를 실행시키는 방법은 다음 세 가지가 있다.

1. **Direct Dispatch**
    
    컴파일 시점에 코드 자체에 함수의 메모리 주소 삽입 또는 함수의 명령 코드를 해당 위치에 코드를 심는방식이다. 세 방식중에 가장 빠르지만 value type인 구조체와 열거형에서 사용하기 때문에 상속과 다형성의 장점을 누릴 수 없다.

<br>

2. **Table Dispatch**
    
    함수의 포인터를 배열에 보관 후 실행하는 방식이다. 세 방식중에 두번째로 빠르며 클래스와 프로토콜에서 사용한다. 클래스는 Virtual Table, 프로토콜은 Witenss Table을 사용한다.

<br>

3. **Message Dispatch**
    
    상속구조를 모두 훑은 후에 실행할 메서드를 경정하는 방식이다. 세 방식중에 가장 느리며 주로 Objective-C 클래스에서 사용한다.
    

<br>

## **ARC: Automatic Reference Counting**

ARC는 스위프트의 메모리 관리 모델이다. Automatic Reference Counting의 줄임말로, 자동으로 메모리 참조의 숫자를 센다. 만약 수동으로 메모리를 관리해야 한다면, 우리는 다음과 같이 코드를 짜야한다.

```swift
class Point {
	var refCount: Int           // 참조 숫자를 세주는 변수
	var x, y: Double
	func draw() { ... }
}

let point1 = Point(x: 0, y: 0) // +1, refCount = 1
let point2 = point1 
retain(point2)                 // +1, refCount = 2

point2.x = 5

release(point1)                // -1, refCount = 1
release(point2)                // -1, refCount = 0 -> 메모리 할당 해제
```

`retain()` → Reference Counting의 숫자를 하나 올린다.

`release()` →  Reference Counting의 숫자를 하나 내린다.

따라서, Referece Counting이 0이 되는 순간 메모리할당을 해제 한다. 
스위프트에 ARC가 있기 때문에 우리는 `retain`, `release`를 신경 안써도 컴파일할 때 자동으로 수행한다.

<br>

## **강한 참조 사이클**

강한 참조 사이클은 객체 두 개가 서로를 참조하고 있어, 메모리 누수가 발생하는 경우 메모리 해제가 안되고 해제 시킬 방법도 없는 현상이다.

```swift
class Dog {
	var name: String
	var owner: Person?

	init(name: String) {
		self.name = name
	}

	deinit { // 소멸자
		print("\(name) 메모리 해제")
	}
}

class Person {
	var name: String
	var pet: Dog?
	
	init(name: String) {
		self.name = name
	}

	deinit {
		print("\(name) 메모리 해제")
	}
}

var bori: Dog? = Dog(name: "보리")
var gildong: Person? = Person(name: "홍길동")

bori?.owner = gildong
gildon?.pet = bori
// --> 강한 참조 사이클 발생

bori = nil    // 메모리 해제 불가
gildong = nil // 메모리 해제 불가
```

위 코드를 보면 “보리”의 주인은 “길동”이고 “길동”의 애완동물은 “보리”이기 때문에, 두 객체가 서로를 참조하고 있어 메모리 누수가 발생한다.

<br>

**메모리 누수의 해결방안 2가지**

메모리 누수의 해결방안 2가지를 사용하면 공통적으로 Referece Counting 올라가지 않는다.

1. **약한 참조(Weak Reference)**
    
    단순히 앞에 `weak` 키워드를 사용하면 된다.
    
    ```swift
    class Dog {
    	var name: String
    	weak var owner: Person?
    
    	init(name: String) {
    		self.name = name
    	}
    
    	deinit { // 소멸자
    		print("\(name) 메모리 해제")
    	}
    }
    
    class Person {
    	var name: String
    	weak var pet: Dog?
    	
    	init(name: String) {
    		self.name = name
    	}
    
    	deinit {
    		print("\(name) 메모리 해제")
    	}
    }
    
    var bori: Dog? = Dog(name: "보리")
    var gildong: Person? = Person(name: "홍길동")
    
    // 강한 참조 사이클 발생하지 않음
    bori?.owner = gildong
    gildon?.pet = bori
    
    bori = nil    // print("보리 메모리 해제")
    gildong = nil // print("홍길동 메모리 해제")
    ```
    
    약한 참조의 경우, 참조하고 있던 인스턴스가 사라지면, `nil`로 초기화가 되어있다. `nil`을 할당할 수 있어야 하기 때문에 `weak let`이나 Non-Optional 선언이 불가능하다. 따라서 소유자에 비해 짧은 생명주기를 가진 인스턴스를 참조할때 주로 사용한다.

<br>

2. **비소유 참조(Unowned Referece)**
    
    약한 참조와 똑같이 앞에 `unowned` 키워드를 붙인다.
    
    ```swift
    class Dog {
    	var name: String
    	unowned var owner: Person?
    
    	init(name: String) {
    		self.name = name
    	}
    
    	deinit { // 소멸자
    		print("\(name) 메모리 해제")
    	}
    }
    
    class Person {
    	var name: String
    	unowned var pet: Dog?
    	
    	init(name: String) {
    		self.name = name
    	}
    
    	deinit {
    		print("\(name) 메모리 해제")
    	}
    }
    
    var bori: Dog? = Dog(name: "보리")
    var gildong: Person? = Person(name: "홍길동")
    
    // 강한 참조 사이클 발생하지 않음
    bori?.owner = gildong
    gildon?.pet = bori
    
    bori = nil    // print("보리 메모리 해제")
    gildong = nil // print("홍길동 메모리 해제")
    ```
    
    약한 참조와 다르게 비소유 참조는 참조하고 있던 인스턴스가 사라지면, `nil`로 초기화 되지 않는다. 따라서 소유자 보다 인스턴스의 생명주기가 더 길거나, 같은 경우에 사용한다.
    
    위 예제들을 봤듯이, `unowned` 사용시에는 한번 더 고려할 것이 있기 때문에, 실제로는 `weak` 키워드를 사용하는 약한 참조를 프로젝트에서 더 많이 사용한다.


<br>


## **생명주기(Life Cycle)**

- `viewDidLoad` - 스토리보드상의 뷰들과의 연결이 끝난 시점
- `viewWillAppear` - 실제 스크린에 뷰가 나타나기 전에 호출
- `viewDidAppear` - 실제 스크린에 뷰가 나타난 후에 호출
- `viewWillDisappear` - 실제 스크린에 뷰가 사라지기 전에 호출
- `viewDidDisappear` - 실제 스크린에 뷰가 사라진 후에 호출