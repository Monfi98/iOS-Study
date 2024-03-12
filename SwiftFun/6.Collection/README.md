# 컬렉션(Collection)

> 💡 스위프트에서 제공하는 데이터를 효율적으로 관리하기 위한 자료형(타입)이다.

스위프트에서 컬렉션 자료형은 총 세가지가 있다.

- **Array(배열)**: 데이터를 순서대로 저장하는 컬렉션
- **Dictionary(사전)**: 데이터를 키와 값으로 이루어진 하나의 쌍으로 만들어 관리하며 순서가 없는 컬렉션
- **Set(집합)**: 수학에서 집합과 비슷한 연산을 제공하는 순서가 없는 컬렉션

<br>

### 1. 배열(Array)

- 하나의 배열에는 동일한 타입의 데이터만 담을 수 있다.
- 순서가 있기 때문에 값은 중복이 가능하다.

```swift
var numsArray = [1, 2, 3, 4, 5]

// 정식
let strArray1: Array<String> = []
// 단축
let strArray2: [String] = []
```

빈 배열일 경우 타입추론이 불가능하기 때문에 꼭 해당 변수나 상수가 배열임을 명시하자!

<br>

- 배열의 기본 메서드

```swift
numsArray.count // 5
numsArray.isEmpty // false
numsArray.contains(1) // true
numsArray.randomelement()
numsArray.swapAt(0, 1) // 0과 1 인덱스에 해당하는 요소를 서로 바꿈

numsArray.last  // Optional(5)
numsArray.first // Optional(1)
numsArray.endIndex // 4

numsArray.index(1, offsetBy: 2) // 4, index 1로부터 2만큼 떨어진 요소 출력
numsArray.firstIndex(of: 3) // 3, 앞에서 부터 했을때 해당 요소가 몇번째인지

numsArray.insert(1, at: 1) // [1, 1, 2, 3, 4, 5]
numsArray.insert(contentsOf: [1, 2, 3], at: 0) // [1, 2, 3, 1, 2, 3, 4, 5]
```

<br>

### 2. Dictionary(사전)

- 데이터를 키와 값으로 하나의 쌍으로 만들어 관리하는 컬렉션이다.
- `key`은 유일해야하며 `value`는 중복이 가능하다.
- `key`값은 Hashable 해야한다.
- 순서가 없다.

> 💡 **Hashable**   어떤 타입이 Hashable이라는 뜻은 해당 타입을 해시함수의 input값으로 사용가능하다는 뜻이다. Hashable이 되면 값의 유일성을 보장하며 검색 속도가 빠르다.

```swift
var dict = ["A": "Appple", "B": "Banana", "C": "Candy"]

// 단축 문법
var words: [String: String] = [:]

// 정식 문법
let words: Dictionary<Int, String>
```

<br>

- 반복문과의 결합

```swift
let dict = ["A": "Appple", "B": "Banana", "C": "Candy"]

for (key, value) in dict {
	print("\(key): \(value)")
}

for (_, value) in dict {
	print("\(key): \(value)")
}

for (key, _) in dict {
	print("\(key): \(value)")
}
```

`key`나 `value` 중 하나만 사용시에는 사용하지 않는 것을 와일드카드 패턴으로 대체하여 사용할 수 있다.

<br>

- 참고) **KeyValuePairs**
    
    키가 있고 순서가 있는 컬렉션이다.
    
    ```swift
    let pairs: KeyValuePairs = ["A": "Appple", "B": "Banana", "C": "Candy"]
    ```
    
<br>

### 3. Set(집합)


- 수학에서의 집합과 비슷한 연산을 제공하는 순서가 없는 컬렉션이다.
- 각 요소는 Hashable 해야한다.
- 순서가 없다.

```swift
var set: Set = [1, 2, 3, 4, 5]

var set: Set<Int> = [1, 2, 3, 4, 5]
```

<br>

### 5. Foundation 컬렉션

- `NSArray`, `NSDictionary`, `NSSet` 등 Objective-C 컬렉션이다.
- 굳이 공부할필요 없고 필요할때마다 검색해서 쓰면된다.