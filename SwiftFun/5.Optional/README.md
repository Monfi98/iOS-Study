# 옵셔널(Optional)


> 💡 모든 프로그램에서 변수를 선언하고 초기화를 하지 않은 상태에서 출력을 하려고 하면 에러가 난다. Swift에서는 앱이 그대로 꺼져버리는데, 옵셔널을 사용하면 앱이 꺼지는 것을 방지할 수 있다.


- `nil` → 값이 없음을 표현하는 키워드

<br>

Ex) 일반정수형 vs 옵셔널 정수형

`Int` : 일반 정수형 = `… -5, -4, -3, -1, 0, 1, 2, 3 …`

`Int?` : 옵셔널 정수형 = `… -5, -4, -3, -1, 0, 1, 2, 3 …` + `nil`

<br>

- 옵셔널 타입 사용법

```swift
var optionalNum: Int? = nil
optionalNum = 10

print(optionalNum) // Optional(10)
```

옵셔널 타입인 경우 `let`이 아닌 `var`로 선언해야하며(`let`으로 선언하면 옵셔널의 의미가 없음) 당연히 옵셔널 타입끼리의 계산은 당연히 불가능하다.

<br>

### 옵셔널 타입추출


옵셔널 타입을 추출하는 방법은 4가지가 있다. 

<br>

1. **강제로 값을 추출하는 방법(Forced Unwrapping): 값이 있다는 것이 확실할 때 사용**

```swift
var str1: String? = "안녕하세요"
var str2: String? = "안녕하세요"

print(str1!)  // 안녕하세요
print(str2!)  // 오류! 앱이 강제로 꺼지게 됨
```

일반적으로는 사용하지 않는 방법이다. 웬만한 경우에 절대 사용하면 안된다.

<br>

2. **`if`문으로 `nil`이 아니라는 것을 확인한 후, 강제로 벗기기**

```swift
if str != nil {
	print(str!)
}
```

<br>

3. **옵셔널 바인딩(`if let` 바인딩): 바인딩이 된다면, 특정 작업을 하겠다는 의미**

```swift
var optionalName: String? = "홍길동"

if let name = optionalName { // s라는 상수에 담긴다면
	print(name)
}

// 실제 앱을 만들때 guard let 바인딩을 많이 사용한다.
func doSomething(name: String?) {
	guard let n = name else { return }  // name = Optional("hello")
	print(n)
}

doSomething(name: "hello")
```

우아하게 벗기는 방법, 실제로 이 방법을 많이 쓴다. `if var`는 논리적으로 잘 사용하지 않는다.

<br>

4. **닐 코얼레싱(Nil-Coalescing) 연산자를 사용하는 방법** coalesce: 더 큰 덩어리로 합치다
    
    → **옵셔널 타입에 대하여, 디폴트값을 제시할 수 있을 때 사용함**
    

```swift
// userName이 nil일 경우 userName에 "미인증 사용자"가 들어감
var userName: String ?? "미인증 사용자" 
```

구조를 보면 값이 없을 수가 없는 구조를 띈다. 실제로 갑을 벗겨서 사용하는 것은 아니고, 디폴트 값 제시를 통해 옵셔널의 가능성을 없애는 방법이다.

<br>

### 옵셔널 타입의 활용과 이해

- 함수와 옵셔널 타입

```swift
func doSomePrint(with label: String, name: String? = nil) {
	print("\(label): \(name)")
}

doSomePrint(with:"레이블") // nill 설정을 해두면 매개변수 name은 생략이 가능하다.
```

<br>

- 옵셔널 타입의 이해
    
    → 옵셔널 타입은 내부적으로 열거형으로 이루어져 있음
    

```swift
var n0: Int? = 7

// 위 문장은 아래와 같음
enum Optional {
	case some(Int)
	case none
}

var n1: Optional = .some(7)
var n2 = Optional.none
```

`.none`과 `nil`은 완전히 동일하다.

<br>

- 옵셔널 패턴(Optional Pattern)

```swift
switch a {
case let z?:
	print(z)
case nil:
	print("nil")	
}
```

옵셔널 패턴을 사용하면 `.some`을 좀 더 간소화 할 수 있다.

<br>

## 옵셔널 타입의 응용


- 옵셔널 체이닝 예시

```swift
class Dog {
	var name: String?
	var weight: Int

	init(name: String, weight: Int) {
		self.name = name
		self.weight = weight
	}

	func sit() {
		print("\(name)가 앉았습니다.")
	}

	func laydown() {
		print("누웠습니다.")
	}
}

class Human {
	var dog: Dog?
}

var choco1 = Dog(name: "초코1", weigth: 15)
choco1.name // Optional("초코")
choco1.sit() // Optinal("초코")가 앉았습니다.

var choco2: Dog? = Dog(name: "초코2", weigth: 15)
choco2?.name // Optional("초코2")
choco2?.sit() // Optinal("초코2")가 앉았습니다.

var human = Human()
human.dog = choco1
human.dog?.name // human.dog가 옵셔널 타입으로 선언되었기 때문에 반드시 ?를 붙여줘야한다.
print(human.dog?.name)
```

옵셔널 타입에 대해, 접근연산자를 사용할때 `?`를 붙여서 앞 타입의 값이 `nil`을 가질 수도 있음을 표시한다.

따라서, 언래핑을 해서 사용해야한다. 다음은 언래핑 방법 세 가지 이다.

<br>

1. 앞의 옵셔널 타입에 값이 있다는것이 확실한 경우 → `!` 강제 언래핑

```swift
human.dog!.name
```

<br>

2. `if let` 바인딩

```swift
if let name = human?.dog?.name {
	print(name)
}
```

<br>

3. Nil-Coalescing 연산자 → `?? 디폴트 값`

```swift
var defaultName = human.dog?.name ?? "멍탱구리"
print(defaultName)
```

<br>

- 옵셔널 체이닝에서 함수의 실행

```swift
var bori: Dog? = Dog(name: "보리", weight: 20)

bori?.laydown()
bori?.sit()
```

옵셔널 타입에 접근해서 사용하는 함수는 언래핑을 하지 않아도 사용이 가능하다. 타입에 값이 있으면 함수를 실행하고 없으면 `nil`을 리턴한다. 이때, 함수가 `return`이 있는 경우 타입에 값이 있으면 `Optional return`타입으로 반환하고 타입에 값이 없으면 `nil`로 반환한다.