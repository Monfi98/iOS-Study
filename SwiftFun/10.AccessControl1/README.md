# 접근제어(Access Control)

> 💡 접근 제어를 사용하는 이유는 은닉화를 하기 위해 코드 내부의 세부 구현 내용을 숨기기 위해서 사용한다. 또한 코드 영역을 분리시켜서 효율적으로 관리가 가능하고 컴파일 시간이 줄어든다.

```swift
class SomeCalss {
	private var name = "이름"

	func nameChange(name: String) {
		self.name = name
	}
}

var s = SomeCalss
s.name = "홍길동" // 불가
s.namechange(name: "홍길동") // 가능
```

`private` 키워드를 사용하면 은닉화로 인해 `name`에 바로 접근할 수 없다.
대신, 메서드를 이용해서 접근할 수 있다.

<br>

- 싱글톤(Singleton) 패턴 → 유일하게 한개만 존재하는 객체가 필요한 경우에 쓴다.

```swift
class Singleton {
	static let sharded = Singleton() // 나 자신의 객체를 생성해서 전역변수에 할당함
	var userInfoId = 12345
	private init() {} // 객체를 더이상 찍어낼 수 없게 한다.
}

let object = Singleton.shared
object.userInfoId = 777
Singleton.shared.userInfoId // 777
```

변수로 접근하는 순간 `lazy`하게 동작한다.