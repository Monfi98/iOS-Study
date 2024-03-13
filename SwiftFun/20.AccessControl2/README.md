# 접근 제어(Access Control)

## 접근 제어가 필요한 이유


- 본인이 감추고 싶은 코드를 감출 수 있다.
- 코드의 영역을 분리시켜서, 효율적 관리가 가능하다.
- 컴파일 시간이 줄어든다. → (컴파일러가 해당 변수의 어느범위에서만 쓰이는지 인지가 가능하기 때문에)

<br>

## 스위프트의 5가지 접근 수준

1. `open` : 다른 모듈에서도 접근 가능 / 상속 및 재정의도 가능
2. `public` : 다른 모듈에서도 접근 가능 / 상속 및 재정의 불가
3. `internal` : 같은 모듈 내에서만 접근 가능(default)
4. `fileprivate` : 같은 파일 내에서만 접근 가능
5. `private` : 같은 scope내에서만 접근 가능

<br>

## 기본 원칙


- 타입은 타입을 사용하는 변수나, 함수보다 높은 수준으로 접근제어가 선언되어야 한다.

```swift
 // String 타입은 public 이므로 open var some 불가
internal var some: String = "접근가능" 

internal func sFunc(a: Int) -> Bool {
	print(a)
	print("hello")
	return true
}
```

<br>

- 타입의 접근 수준이 높다고 내부 멤버의 접근 수준이 무조건 높아지는건아니다.

```swift
open class SomeClass {
	var some = "internal"
}
```

위 처럼 내부 멤버가 명시적인 선언을 하지 않는다면, `internal`로 유지한다.

<br>

## 관습적인 패턴과 set, get


- `_`가 붙어있는 패턴

```swift
class SomeOtherClass {
	private var _name = "이름" // 쓰기 - private

	var name: String {
		return _name // 읽기 -internal
	}

	func changeName(name: String) {
		self._name = name
	}
}

// Swift에서 제공하는 문법
class SomeAnotherClass {
	private(set) var name = "이름" // 읽기 - internal / 쓰기 - private
}
```

<br>

## 상속, 확장의 접근제어


- 상속해서 만든 서브클래스는 상위클래스보다 더 높은 접근 수준을 가질 수 없다.

```swift
public class A {
	fileprivate func someMethod() {}
}

internal calss B: A {
	override internal func somemethod() {
		super.someMethod()
	}
}
```

<br>

- 확장에서는 본체와 동일한 접근 수준을 유지하고, 본체의 멤버에는 기본적인 접근이 가능하다.

```swift
public class SomeClass {
	private var somPrivateProperty = "somePrivate"
}

extension SomeClass {
	func somePrivateControlFunction() {
		somePrivateProperty = "접근가능"
	}
}
```