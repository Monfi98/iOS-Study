# Result 타입

> 💡 **Result Type이란?**
> 에러가 발생하는 경우, Result Type을 사용하면 에러를 따로 외부에 던지는 것이 아니라 리턴 타입 자체를 Result Type으로 구현해서 함수 실행의 성공과 실패의 정보를 함께 담아서 리턴할 수 있다.

<br>

- Result Type 사용해보기

```swift
enum HeightError: Error {
	case maxHeight
	case minHeight
}

func resultTypeCheckingHeight(height: Int) -> Result<Bool, HeightError> {
	if height > 190 {
		return Result.failure(HeightError.maxHeight)
	} else if height < 130 {
		return Result.failure(HeightError.minHeight)
	} else {
		if height >= 160 {
			return Result.success(true)
		} else {
			return Result.success(false)
		}
	}
}

let result = resultTypeCheckingHeight(height: 200)

switch result {
case .success(let data):
	print("결과값은 \(data)입니다.")
case .failure(let error):
	print(error)
}
```

Result Type은 열거형이므로 `switch` 문을 사용해서 처리를 할 수 있기 때문에 `do-try-catch`문을 사용했을때 보다 코드 가독성이 좋다.

<br>

- 네트워크에서 Result Type 활용

```swift
enum NetworkError: Error {
    case someError
}

func performRequest2(with urlString: String, completion: @escaping 
																		(Result<Data,NetworkError>) -> Void) {
    
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print(error!)                     // 에러가 발생했음을 출력
            completion(.failure(.someError))  // 실패 케이스 전달
            return
        }
        
        guard let safeData = data else {
            completion(.failure(.someError))   // 실패 케이스 전달
            return
        }
    
        completion(.success(safeData))      // 성공 케이스 전달
       
        
    }.resume()
}

performRequest2(with: "주소") { result in
    switch result {
    case .failure(let error):
        print(error)
    case .success(let data):
        // 데이터 처리 관련 코드
        break
    }
}
```