# 중첩 타입(Nested Types)

- 중첩 타입이란? → 타입 내부에 타입을 선언하는 것

```swift
class Aclass {
	struct Bstruct {
		enum Cenum {
			case aCase
			case bCase

			struct Dstruct {
			
			}
		}
		var name: Cenum
	}
}

let bStruct: Aclass.Bstruct = Aclass.Bstruct(name: .bCase)
let cEnum: Aclass.Bstruct.Cenum = Aclass.Bstruct.Cenum.aCase
let dStruct: Aclass.Bstruct.Cenum.Dstruct = Aclass.Bstruct.Cenum.Dstruct()
```

중첩 타입은 특정 타입 내에서만 사용하기 위해 사용한다. 결과적으로, 타입 간의 연관성을 명확히 구분할 수 있고 내부 구조를 디테일하게 설계가 가능하다.

<br>

- 메시지를 중첩타입 모델로 설계 한다면?

```swift
class Message {
	private enum Status {
		case sent
		case received
		case read
	}
	
	// 보낸사람, 받는 사람
	let sender: String, recipient: String, content: String

	// 보낸 시간
	let timeStamp: Date
	
	// 메시지의 상태 정보
	private var status = Message.Status.sent

	init(sender: String, recipient: String, content: String) {
		self.sender = sender
		self.recipient = recipient
		self.content = content

		self.timeStamp = Date()
	}

	func getBasicInfo() -> String {
		return "보낸사람:\(sender), 받는사람:\(recipient),
					  메세지 내용:\(content), 보낸 시간:\(timeStamp.description)"
	}

	func statusColor() -> UIColor {
		switch status {
		case .sent:
			return UIColor(red: 1, green: 0, blue: 0, alpha: 1)
		case .sent:
			return UIColor(red: 0, green: 0, blue: 1, alpha: 1)
		case .sent:
			return UIColor(red: 0, green: 1, blue: 1, alpha: 1)
		}
	}
}
```