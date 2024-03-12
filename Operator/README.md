# Swift 정리

[https://github.com/slaveshin/iOS-Study](https://github.com/slaveshin/iOS-Study)

## Common

---

- **프레임워크 vs 라이브러리**
    
    ---
    
    - **프레임워크** → 각각의 목적을 가지고 있는 레고세트
        - 개발자는 이미 짜여진 룰(프레임워크)에 따라 작업을 한다.
        - xcode로 어플리케이션을 만드는 것은 애플이 만들어놓은 프레임워크에 따라 어플을 만든다고 할 수 있다.
    - **라이브러리** → 미리 남들이 만들어 놓은 필요부분을 사용하는 것
        - 어플을 만들때 남이 만든 이쁜 커스텀 버튼을 쓰는 느낌이다.
- **객체 지향 프로그래밍**
    
    ---
    
    **객체 지향 프로그래밍**은 왜 필요할까?
    
    도서 관리 프로그램이나 회원 관리 프로그램 등을 생각해보자. 각각의 프로그램에서 사용해야하는 데이터가 있을 것이다.
    
    > **Member Data**
    
    이름:
    성별:
    나이:
    주소:
    > 
    
    > **Book Data**
    
    제목:
    가격:
    출판사:
    저자:
    > 
    
    클래스나 구조체를 사용하여 이러한 멤버나 책의 모델들을 잘 설계한다면 하나하나 따로 만들필요없이 공장에서 빵찍어내듯이 사용하면된다. 이렇게 하면 데이터를 만들기에도 좋지만 데이터를 처리하기에도 유용하다.
    
    ### 객체지향의 4대 특징
    
    ---
    
    1. **추상화(Abstraction)**
        
        모델링이라는 말과 비슷하다. 실생활에서의 추상화란 관찰자가 관심있는 부분만 가지고 재조합하는 것이다. 객체지향적 관점에서, 실체들의 공통적 특성을 뽑아내서 클래스로 정의하는 것 자체가 추상화의 개념이다. (도서관리 프로그램 → 제목, 저자, 출판사, 가격 등..)
        
    2. **캡슐화(Encapsulagtion)**
        
        캡슐화는 연관이 있는 상태(속성)이나 기능(메서드)를 하나의 클래스로 묶어서  활용한다는 개념이다. 캡슐화에서는 은닉화라는 개념이 있는데 이를 사용하면 접근제어자를 이용해 객체 외부에서 내부데이터의 접근 통제가 가능해진다.
        
    3. **상속성(Ingeritance)**
        
        부모 클래스의 속성과 메서드를 자식 클래스에서 그대로 물려받는 개념이다. 상속을 통해, 코드가 재활용될 수 있기 때문에 생산성이 높아진다.
        
    4. **다형성(Polymorphism)**
        
        다형성은 하나의 객체가 여러가지 타입의 형태로 저장 될 수 있고, 다양한 메서드의 현태로 동작이 가능함을 의미한다. 따라서 하나의객체는 다양한 방식으로 동작이 가능하다.
        
- **코데힙스**
    
    ---
    
    1. 코드(프로그램) → 프로그램의 모든 코드
    2. 데이터 → 전역 변수 및 타입 변수, 공통으로 공유하기 위한 데이터
    3. 힙 → 동적할당, 크기가 크고 관리할 필요가 있는 데이터
    4. 스택 → 함수 실행을 위한 임시적 공간
- **동시성 프로그래밍의 문제점**
    
    ---
    
    1. **경쟁상황/경쟁조건(Race Condition)**
    
    멀티 쓰레드의 환경에서, 같은 시점에 여러개의 쓰레드에서 하나의 메모리에 동시접근하는 문제이다. 다른 표현으로는 Thread-Safe하지 않다고도 하는데, 이러한 문제점을 해결하려면 메모리를 다른 쓰레드가 쓰고있는 동안에는 다른 여러 쓰레드에서 접근하지 못하도록 Thread-Safe 처리를 하면된다.
    
    1. **교착상태(Dead Lock)**
    
    멀티 쓰레드의 환경에서, 베타적인 메모리 사용으로 일이 진행이 안되는 문제이다. 교착상태가 발생하는 상황은 Thread-Safe를 처리했지만 잘못된 설계로 서로 접근못하게 하거나 점유하려고 하면서 메서드가 종료를 못시키는 상황이다.
    

## iOS

---

- **단축키**
    
    ---
    
    - `control` + `I`:  자동으로 줄맞추기
    - `command` + `shift` + `y`: 콘솔 업다운
    
- **import Foundation?**
    
    ---
    
    - Objective-C 언어와 관련된 기능을 제공한다.
    - 컬렉션 `NSArray`, `NSMutableArray`, `NSDictionary`, `NSSet` 등을 제공한다.
    - 데이터나 날짜 관련 `NSData`, `NSDate` 등을 제공한다.
    - 외울 필요는 없음!
- **상속관계에서 생성자 위임 규칙**
    
    ---
    
    1. **델리게이트 업(Delegate Up)**
        
        서브 클래스의 지정 생성자는 슈퍼 클래스의 지정생성자를 반드시  호출해야한다.
        
    2. **델리게이트 어크로스(Delegate across)**
        
        편의 생성자는 동일한 클래스에서 다른 편의 생성자 또는 지정 생성자를 호출해야하고 궁극적으로는 지정 생성자를 호출해야한다.
        
- **프로토콜 지향 프로그래밍**
    
    ---
    
    애플이 최초로 프로토콜 지향 프로그래밍 패러다임을 제시했다.
    
    **클래스와 상속의 단점**
    
    - 하나의 클래스만 상속이 가능하다.
    - 하위클래스는 상위클래스의 메모리 구조를 따라갈 수 밖에 없다.
    - 클래스에서만 가능하다.
    
    **하지만 프로토콜 지향 프로그래밍일 경우?**
    
    - 여러개의 프로토콜 채택이 가능하다. → 조합의 장점을 살려서 구성/재사용성을 높일 수 있다.
    - 메모리 구조에 대한 특정 요구사항이 없다. → 필요한 속성/메서드만 채택해서 사용할 수 있다.
    - 모든 타입에서 채택이 가능하다. → 활용성이 늘어난다.
- **Method Dispatch**
    
    ---
    
    스위프트가 함수를 실행시키는 방법은 다음 세 가지가 있다.
    
    1. **Direct Dispatch**
        
        컴파일 시점에 코드 자체에 함수의 메모리 주소 삽입 또는 함수의 명령 코드를 해당 위치에 코드를 심는방식이다. 세 방식중에 가장 빠르지만 value type인 구조체와 열거형에서 사용하기 때문에 상속과 다형성의 장점을 누릴 수 없다.
        
    2. **Table Dispatch**
        
        함수의 포인터를 배열에 보관 후 실행하는 방식이다. 세 방식중에 두번째로 빠르며 클래스와 프로토콜에서 사용한다. 클래스는 Virtual Table, 프로토콜은 Witenss Table을 사용한다.
        
    3. **Message Dispatch**
        
        상속구조를 모두 훑은 후에 실행할 메서드를 경정하는 방식이다. 세 방식중에 가장 느리며 주로 Objective-C 클래스에서 사용한다.
        
- **ARC: Automatic Reference Counting**
    
    ---
    
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
    
- **강한 참조 사이클**
    
    ---
    
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
    
    **메모리 누수의 해결방안 2가지**
    
    ---
    
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
        
- **생명주기(Life Cycle)**
    
    ---
    
    - `viewDidLoad` - 스토리보드상의 뷰들과의 연결이 끝난 시점
    - `viewWillAppear` - 실제 스크린에 뷰가 나타나기 전에 호출
    - `viewDidAppear` - 실제 스크린에 뷰가 나타난 후에 호출
    - `viewWillDisappear` - 실제 스크린에 뷰가 사라지기 전에 호출
    - `viewDidDisappear` - 실제 스크린에 뷰가 사라진 후에 호출

## 문법

---

[연산자](https://www.notion.so/4f9170c8349540e685fdcacca3607bd5?pvs=21)

[제어문](https://www.notion.so/ac5972fd9ae143c788019d12d7153763?pvs=21)

[튜플(Tuple)](https://www.notion.so/Tuple-17fd28c61e974c8596ce74751ad7a05e?pvs=21)

[함수(Function)](https://www.notion.so/Function-55e64bcd971844fda61a0bd6d5bd1529?pvs=21)

[옵셔널(Optional)](https://www.notion.so/Optional-a620ddd79b504e038e71e4890196f018?pvs=21)

[컬렉션(Collection)](https://www.notion.so/Collection-f11d91d128c14009b45c469f24bcb9b8?pvs=21)

[열거형(Enumeration)](https://www.notion.so/Enumeration-7818e77bfa744ef8ae7a91a8475cb122?pvs=21)

[클래스(Class)와 구조체(Struct)](https://www.notion.so/Class-Struct-6712ee1743f747b599d1ef84065ff313?pvs=21)

[클래스의 상속(Inheritance)과 초기화(Initialization)](https://www.notion.so/Inheritance-Initialization-ca9a7dc1eb8440199c6b4fdf7d7f8408?pvs=21)

[접근제어(Access Control)](https://www.notion.so/Access-Control-811cc0dec50c419d816b7c19c6d120f5?pvs=21)

[타입 캐스팅(Type Casting)과 확장(Extension)](https://www.notion.so/Type-Casting-Extension-edec954c23a149f486f4b3e616cd705a?pvs=21)

[프로토콜(Protocol)](https://www.notion.so/Protocol-056a29a979384978b7cdb10330c72d97?pvs=21)

[중첩 타입(Nested Types)](https://www.notion.so/Nested-Types-4782f6a34fc648258567936ed2f833d2?pvs=21)

[클로저(Closure)](https://www.notion.so/Closure-f980eb2894fb4556821f344dde9ba9c4?pvs=21)

[고차함수(Higer-order Function)](https://www.notion.so/Higer-order-Function-cd511e570ba24419a0399f6d71764eaf?pvs=21)

[에러 처리(Error Handling)](https://www.notion.so/Error-Handling-455cb24c2b7e4af58797e3d76d5d948b?pvs=21)

[Defer문](https://www.notion.so/Defer-17ee5b18c04e4ecdada9a4525081d2a9?pvs=21)

[제네릭(Generics)](https://www.notion.so/Generics-7ff693d1c5ad4fe19a074ead8e3010e1?pvs=21)

[Result 타입](https://www.notion.so/Result-5e51ce22a89d47259a25d4e06492eb54?pvs=21)

[접근 제어(Access Control)](https://www.notion.so/Access-Control-503e69022d8442bfa97d8e1f188169e4?pvs=21)

[문자열과 문자](https://www.notion.so/2fa8ddbae3af4af18aac9723d2bec9fd?pvs=21)

[고급 연산자](https://www.notion.so/f575ff88518b4a2abfea1bbe3d81bf46?pvs=21)

[심화 내용(Advanced Swift)](https://www.notion.so/Advanced-Swift-51d5ea16a8e04497a032301138fd613b?pvs=21)

## 네트워킹

---

[네트워크 기초](https://www.notion.so/3445a3ed6e164dd992e3c5888082603d?pvs=21)

[iOS 네트워킹](https://www.notion.so/iOS-fcaa5d35619441dd88d1f8e02b8bd32e?pvs=21)

[동시성(Concurrent) 프로그래밍](https://www.notion.so/Concurrent-a5b72d1c28434ed3be6a750af998deea?pvs=21)

[디스패치 큐(GCD)](https://www.notion.so/GCD-540fcb05eb1d48959352c35260c32e71?pvs=21)