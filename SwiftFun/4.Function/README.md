# 함수(Function)

### 함수를 왜 사용할까?

1. 반복되는 동작을 단순화해서 재사용이 가능하다
2. 코드를 논리적 단위로 구분이 가능하다
3. 코드 길이가 긴 것을 단순화해서 사용가능하다
4. 미리 함수를 잘 만들어 놓으면, 개발자는 사용만 하면된다

```swift
// name: 파라미터
func saySomething(name: String) {
	print("hello \(name)")
}

saySomething(name: "신승재")

// 아웃 풋이 있는 경우~
func sayHello(name: "신승재") -> String {
	return "hello \(name)"
}
```

<br>

- Argument Label

```swift
func printName1(firstName name: String) {
	print("나의 이름은 \(name)입니다.")
}

printName1(first: "뉴턴")
```

레이블을 사용하면 함수를 사용할때 더 명확하게 무엇을 요구하는지 알려줄 수 있다.

<br>

- 와일드 카드 패턴

```swift
func addPrintFunction(_ firstNum: Int, _ secondNum: Int) {
	print(firstNum + secondNum)
}

addPrintFunction(1, 2)
```

함수에서의 와일드 카드 패턴은 함수명만보고도 명확하게 뭘넣어야 할지 알때 쓰면 유용하다.

<br>

- 가변 파라미터

```swift
func arithmeticAverage(_ numbers: Double...) -> Double {
	var total = 0.0
	for number in numbers {
		total += number
	}
	return total / Double(numbers.count)
}
```

가변 파라미터를 사용하면 하나의 파라미터로 2개 이상의 `argument`를 전달할 수 있다.
배열 형태로 전달되며 기본값은 가질 수 없다.

<br>

- 중첩 함수 사용하기

```swift
func chooseStepFunction(backward: Bool, value: Int) -> Int {
	func stepForward(input: Int) -> Int {
		return input + 1
	}
	func stepBackward(input: Int) -> Int {
		return input - 1
	}
	if backward {
		return stepBackward(input: value)
	} else {
		return stepForward(input: value)
	}
}
```

중첩 함수는 함수를 제한적으로 사용하게 하고싶을때 쓴다

<br>

- 함수 가리키기

```swift
func doSomething() {
	print("hello world!")
}

var some = doSomething

some() // hello world!

// 파라미터가 있을 경우 콤마없이 사용하기!
func printName1(firstName name: String) {
	print("나의 이름은 \(name)입니다.")
}

var some1: (String) -> () = printName1(first:)
```

<br>

- 함수의 오버로드(overload): 영어로 과적하다라는 뜻

```swift
func doSomething(value: Int){
	print(value)
}
func doSomething(value: Double){
	print(value)
}
func doSomething(value: String){
	print(value)
}
```

함수의 오버로딩을 사용하는 이유는 같은 성격의 함수를 다루기가 쉽게 만들어주기 때문이다.

<br>

- `inout` 키워드: 함수에 참조를 전달한다는 개념

> 💡 함수를 통해, 변수를 직접 수정하고 싶은 경우는 어떻게 해야할까?


```swift
var num1 = 123 // 전역변수
var num2 = 456 // 전역변수

// a와 b를 바꿔보려고 하는 함수
func swap(a: Int, b: Int) {
	a = b // a, b는 상수이기 때문에 할당불가!
	b = c
}

swap(a: num1, b: num2)

// inout키워드를 통해 a와 b를 바꾸는 함수
func swapNumbers(a: inout Int, b: inout Int) {
	var temp = a
	a = b
	b = temp
}

swapNumbers(a: &num1, b: &num2)
```

함수내의 파라미터는 기본적으로 값타입이고 임시상수이기때문에 변경 불가 원칙을 가지고 있다.
`inout` 키워드를 사용하여 참조(원본의 주소)를 직접 함수에 전달하면 위 상황을 해결할 수 있음

(주의 할점! 함수를 사용시 변수를 전달할때 반드시 엠퍼센트 `&` 붙여야 한다)

<br>

- `@attribute` 키워드: 선언이나 타입에 추가정보 제공

```swift
@discardableResult
func sayHelloString() -> String {
	print("하이")
	return "안녕하세요"
}

_ = sayHelloString() // @discardableResult 사용하지 않으려면
sayHelloString()
```

`@discardableResult` 는 이 함수의 리턴값은 사용안할 수도 있어~ 라는 뜻임