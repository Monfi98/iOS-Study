# 에러 처리(Error Handling)

> 💡 **에러처리가 왜 필요할까?**
> 만약 에러 처리를 안한다고 가정해보자. 앱에서 서버로 데이터를 요청하는 상황에서 데이터를 제대로 받아오지 못한다면 앱은 그냥 꺼져버릴 것이다. 이 때문에 에러를 처리해 앱이 무작정 꺼지는 현상을 방지할 수 있다.


<br>

## 에러의 종류


- 컴파일 타임 에러 → 스위프트 문법과 관련된 에러
- 런타임 에러 → 프로그램이 실행되는 동안 발생하는 에러

<br>

## 에러 처리의 과정


1. 에러 정의 → 어떤 에러가 발생할지 경우를 미리 정의한다.
2. 에러가 발생할 수 있는 throwing함수에 대한 정의
3. 에러가 발생할 수 있는 함수를 `try-catch`문으로 처리

```swift
// 1. 에러 프로토콜 정의한다.
enum HeightError: Error {
	case maxHeight
	case minHeight
}

// 2. 에러가 발생할 수 잇는 throws 함수를 정의한다.
func checkingHeight(height: Int) throws -> Bool {
	if height > 190 {
		throw HeightError.maxHeight
	} else if height < 130 {
		throw HeightError.maxHeight
	} else {
		if height >= 160 {
			return true
		} else {
			return false
		}
	}
}

// 3. 에러가 발생할 수 있는 함수의 실행 및 처리

do { // 정상적인 경우
	var result = try checkingHeight(height: 160)

	// 에러가 발생하지 않은 경우의 code

} catch {

	// 에러가 발생한 경우의 code

}

```

위 코드는 키가 190을 넘거나, 130보다 작을때 에러를 처리하는 예시이다. 에러를 처리할 수 있는 `throws` 함수를 사용할 때는 반드시 앞에 `try`를 붙여줘야 한다.

<br>

## `do` 블럭


- 에러 정식 처리 방법

```swift
do {
	let isChecked = try checkingHeight(height: 200)

	if isChecked {
		print("청룡열차 탑승 가능")
	} else {
		print("후름라이드 탑승 가능")
	}
} catch {
	print("놀이기구 탑승 불가능")
}
```

<br>

- Optional `try` → 에러가 발생하면 `nil`을 리턴해준다.

```swift
let isChecked = try? checkingHeight(height: 200)
```

<br>

- Forced `try` → 에러가 발생하면 런타임에러가 발생한다.

```swift
let isChecked: Bool = try! checkingHeight(height: 200)
```

에러가 발생하면 런타임 에러가 발생하기때문에 확신이 있는 경우에만 사용하도록 한다.

<br>

## `catch` 블럭


- 에러 별로 처리하기

```swift
do {
	let isChecked = try checkingHeight(height: 200)
	print("놀이기구 타는 것 가능: \(isChecked)")
	
} catch HeightError.maxHeight {
	print("너무 커서 불가능")
} catch HeightError.minHeight {
	print("너무 작아서 불가능")
}
```

<br>

- `error` 상수로 처리하기

```swift
do {
	let isChecked = try checkingHeight(height: 200)
	print("놀이기구 타는 것 가능: \(isChecked)")
	
} catch {
	print(error.localizedDescription) // 보통 localizedDescription으로 에러를 찍는다.

	if let error = error as? HeightError {
		switch error {
			case .maxHeight:
				print("너무 커서 불가능")
			case .minHeight:
				print("너무 작아서 불가능")
		}
	}
}
```

<br>

## throwing 함수의 처리


- `throws` 함수로 에러 다시 던지기

```swift
func handleError1() throws {
	try throwingFunc()
}
```

다른 함수에서 에러 처리 함수를 쓸때는 반드시 `throws` 를 붙여, 에러를 다시 던져야한다.

<br>

- `rethrows` 키워드 → throwing 함수를 파라미터로 받을때 사용한다.

```swift
func someFunction1(callback: () throws -> Void) rethrows {
	do {
		try callback()
	}
}
```