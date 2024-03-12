# 연산자(Operator)

## 삼항연산자
- 아래처럼 선택지가 두 가지일때 삼항 연산자를 사용한다!

```swift
var a = 10

a > 0 ? print("1") : print("2") // 1

var name = a > 0 ? "스티브" : "팀쿡" // name = "스티브"
```
<br>
## 범위 연산자(feat. 패턴매칭 연산자)


```swift
let numbers = 1...10 // numbers는 1~10까지의 범위를 가지고 있음

let range1 = 1...
let range2 = ...10

let rangeH = 1..<10
let rangeH1 = ..<10

(1...10).reversed() // 범위 내림차순으로
```
<br>

- 패턴 매칭 연산자 `~=`

```swift
var age = 20

1...9 ~= age // false
10...19 ~= age // false
20...29 ~= age // true
```

패턴 매칭 연산자는 오른쪽에 있는 표현식이 왼쪽의 범위에 포함되는지에 따라 참과 거짓을 `return` 해준다