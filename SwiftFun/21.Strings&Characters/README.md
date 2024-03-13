# 문자열과 문자

## 아스키코드(ASCII)와 유니코드(UNICODE)

- 영문자 부분은 아스키코드를 유지한다. → 유니코드에서 포함
- 유니코드는 전세계 모든 문자를 포함하고 있다.
    - UTF-8: 1~4bytes 가변길이 인코딩
    - UTF-16: 2~4bytes 가변길이 인코딩
    - UTF-32: 4bytes 인코딩

<br>

## 문자열의 기본

- Raw String → #으로 문자열 앞뒤를 감싸면 내부의 문자열을 그대로 인식한다.

```swift
var name = #""Steve""# // "Steve"
```

<br>

## 서브스트링


- 스위프트에서는 내부적으로 메모리 최적화가 되어있기 때문에 수정 등이 일어나기 전까지는 메모리 공유가 일어난다.

```swift
var greeting = "Hello World"

// 콤마의 인덱스
let index: String.Index = greeting .firstIndex(of: ",") ?? greeting.endIndex

// 처음부터 인덱스까지 
let beginning: String.SubSequence = greeting[..<index]
```

따라서, 오랜기간 저장하기 위해서는 새롭게 문자열로 저장할 필요가 있다.

<br>

## 문자열 다루기

- 문자열을 배열로 변환

```swift
var someString = "Swift"

// 1. 고차함수 map 사용
var array1 = someString.map { String($0) }
print(array)

// 2. 문자열을 문자로 배열화하기
var array2 = Array(someString)

// 3. 문자열을 문자열배열화 하기
var array3 = Array(arrayLiteral: someString)
```

<br>

- 배열을 문자열로 변환

```swift
var newString1 = array1.joined()

var newString2 = String(array2)
```

<br>

- 문자열의 대소문자 변형

```swift
var string = "Swift"

string.lowercased() // 소문자
string.uppercased() // 대문자

string.capitalized() // 앞에만 대문자
```

<br>

- `count`, `isEmpty`

```swift
var emptyString = " "

emptyString.count   // 1
emptyString.isEmpty // true

var emptyString = ""

emptyString.count   // 0
emptyString.isEmpty // false
```

<br>

- 문자열은 서브스크립트를 사용할 수 없는게 아니라, 정수형태의 서브스크립트를 사용할 수 없는것이다!

```swift
let greeting = "Guten Tag!"

var index1 = greeting.startIndex
print(greeting.startIndex)
```

<br>

## 문자열 비교하기


- 문자열은 크기 비교도 할 수 있다!

```swift
"swift" < "Swift"  // false 첫 글 자의 유니코드 순서를 비교

var a = "swift"
var b = "Swift"

// 대소문자 무시하고 비교하는 메서드
a.caseInsensitiveCompare(b) == CompareisonResult.orderedSame
```