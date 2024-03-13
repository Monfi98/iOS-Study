# 클로저(Closure)

> 💡 **클로저란?**
> 이름없는 함수라고 생각하면된다! 함수와 완전히 기능이 동일하며, 형태만 다르다.

<br>

## 클로저 기본

- 스위프트는 함수를 일급객체로 취급→ 함수도 타입이라는 뜻이다.

```swift
// 함수의 타입 표기법
let functionA: (String) -> (String)
let functionB: (Int) -> ()
```

<br>

- 클로저의 기본형태

```swift
// 함수
func aFunction(str: String) -> String {
	return "Hello, \(str)"
}

// 같은 기능으로, 클로저일때
let _ = {(str: String) -> String in 
	return "Hello, \(str)"
}

// 함수처럼 안보이지만 클로저이다.
let aClosureType = { print("안녕") }

aClosureType() // 안녕
```

*중괄호는 클로저(함수)이다* 라는 생각의 전환이 필요하다.

<br>

- 변수에 함수(클로저) 담기

```swift
func aFunction1(_ param: String) -> String {
	return param + "!"
}

var a: (String) -> String = aFunction1

a("안녕") // 안녕!
```

함수는 일급객체이기 때문에 변수에 할당이 가능하다.

<br>

- 가장 많이 사용하는 형태

```swift
let aClosure1 = { (str: String) in
	return "Hello, \(str)"
}

let aClosure2 = { param in
	return param + "!"
}
```

위 코드를 보면 리턴형에 대한 표기, 파라미터 타입 생략이 가능하다.

<br>

- 클로저를 파라미터로 받을 경우 → 클로저의 사용이유

```swift
func closureParamFunction(closure: () -> ()) {
	print("프린트 시작")
	closure()
}

// 일반적으로 클로저를 사용하는 방법
closureParamFunction(closure: {
	print("프린트 종료")
})
```

이렇게 따로 변수에 담지 않아도 매개변수에 바로 클로저를 정의하여 전달할 수 있다. 이때, 함수를 실행할때 파라미터로 전달하는 함수를 `Callback`함수라고 한다.

<br>

## 클로저 문법 최적화

---

- 후행 클로저 문법(trailing closure)

```swift
func closureParamFunction(closure: () -> ()) {
	print("프린트 시작")
	closure()
}

closureParamFunction {
	print("프린트 종료")
}
```

소괄호를 아예 생략해버릴 수 있다.

<br>

- 후행 클로저에서 함수 이외에 매개변수도 받는 경우

```swift
func closureCaseFunction(a: Int, b: Int, closure: (Int) -> Void) {
	let c = a + b
	closure(c)
}

closureCaseFunction(a: 5, b: 2) { number in
	print("출력할까요? \(number)")
}
```

<br>

- 아규먼트 이름 축약

```swift
func performClosure(param: (String) -> Int) {
	pram("Swift")
}

performClosure { $0.count }
```

<br>

## 클로저 실제 활용 예시


- Timer의 scheduledTimer를 사용하면 반복적으로 특정 클로저를 반복할 수 있다.

```swift
// repeats를 true로 하면 1초마다 반복함
Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { t in
	print("1초뒤 출력하기")
}
```

<br>

- 멀티플 트레일링 클로저

```swift
func multipleclosure(first: () -> (), second: () -> (), third: () -> ()) {
	first()
	second()
	third()
}

multipleClosure {
	// code
} second: {
	// code
} third: {
	// code
}
```

<br>

- 프로젝트에서 많이 사용하는 방식

```swift
let emailTextField: UITextField = {
	let tf = UITextField()
	tf.placeholder = "Email"
	tf.backgroundColor = UIColor(...)
	tf.font = UIFont.systemFont(ofSize: 14)
	return tf
}()
```

<br>

## `@escaping` / `@autoclosure` 키워드

- `@escaping` 키워드 → 클로저를 제거하지 않고 함수에서 탈출 시키게해주는 키워드

```swift
var aSavedFunction: () -> () = { print("출력") }

func perfomrEscaping(closure: @escaping: () -> ()) {
	aSavedFunction = closure
}

performEscaping2(closure: { print("다르게 출력") })

aSavedFunction() // print("다르게 출력")
```

`@escaping`키워드를 사용함으로써 힙 영역에 저장해서 더 오래 유지할 수 있다.

<br>

- `@autoclosure` 키워드 → 자동으로 클로저를 만들어주는 키워드

```swift
func someFunction(closure: @autoclosure () -> Bool) {
	if closure() {
		print("참입니다.")
	} else {
		print("거짓입니다.")
	}
}

var num = 1

// 자동 완성시 someFunction(closure: Bool)로 뜸
someFunction(closure: { true })
```

일반적으로 클로저 형태로 써도 되지만, 너무 번거로울 때 사용한다. 번거로움을 해결할 수 있지만 실제 코드가 명확해 보이지 않을 수 있으므로 사용을 지양해야 한다.

<br>

## 클로저와 메모리


> 💡 **캡처현상**
> 클로저는 힙의 영역에 존재해야하고, 클로저 내부에서 외부에 존재하는 변수를 계속 사용해야하기 때문에 자신이 참조하는 외부 변수를 캡처하는 현상이다.

<br>

- 캡처 현상

```swift
func calculate() -> ((Int) -> Int) {
	var sum = 0

	func square(num: Int) -> Int {
		sum += (num * num)
		return sum
	}

	return square
}

// 함수를 변수에 할당하는 순간 클로저와 똑같이 동작한다.
var squareFunc = calculateFunc()

squareFunc(10) // 100
squareFunc(20) // 500
squareFunc(30) // 1400

// 변수 sum이 캡쳐현상으로 누적됨
```

<br>

- 값 타입 캡처와 캡처 리스트

```swift
var num = 1

let valueCaptureClosure = {
	print("벨류값 출력: \(num)")
}

num = 7
valueCaptureclosure() // 벨류값 출력: 7

num = 1

let valueCaptureListClosure = { [num] in
	print("벨류값 출력(캡처리스트): \(num)")
}
num = 7
valueCaptureListClosure() // 벨류값 출력(캡처리스트): 1

```

클로저는 자신이 사용할 외부의 변수를 캡쳐한다. 따라서 벨류타입의 메모리 주소를 캡처하여 7이 나오는 것을 볼 수 있다. 하지만 캡처 리스트를 사용하면 값을 복사해서 담기 때문에 

<br>

- 참조 타입 캡처와 캡처 리스트

```swift
class SomeClass {
	var num = 0
}

var x = SomeClass()
var y = SomeClass()

// x.num = 0, y.num = 0

let refTypeCapture = { [x] in
	print(x.num, y.num)
}

x.num = 1
y.num = 1

refTypeCapture() // x.num = 1, y.num = 1
```

위 코드를 보면 캡처리스트에서 `x`는 직접 참조, `y`는 변수를 캡쳐해서 `y` 변수를 가르키는 것을 볼 수 있다. 결국 거쳐서 참조하냐 아니면 직접 참조하냐의 차이이기 때문에 둘다 1로 바뀌는 것을 볼 수 있다.

<br>

## 객체 내에서 클로저의 사용

- 일반적인 클로저의 사용

```swift
class Dog {
	var name = "초코"

	func doSomething() {
		// 비동기 실행 클로저 ==> 변수를 오랫동안 저장할 필요가 있음
		DispatchQueue.global().async { [self] in
			print("나의 이름은 \(name)입니다.") // 또는 self.name
		}
	}
	func doSomething1() {
		// 약한 참조로 RC가 올라가지 않음
		DispatchQueue.global().async { [weak self] in
			print("나의 이름은 \(self?.name)입니다.")
		}
	}
	func doSomething2() {
		// 
		DispatchQueue.global().async { [weak self] in
			guard let weakSelf = self else { return }
			print("나의 이름은 \(weakSelf.name)입니다.")
		}
	}
}

var choco = Dog()
choco.doSomething()
```