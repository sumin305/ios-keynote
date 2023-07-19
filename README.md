## 미션 ❗️
### **W3-1 아이패드 앱 프로젝트💻**
### 완성 날짜/시간 ⏰
2023/07/18 17:00   
* * *    
### 학습 키워드 ✏️   
- Factory 패턴
   - 객체를 사용하는 곳과 생성하는 곳을 분리하여 객체간의 결합도를 낮춘다.
   - 구체적인 클래스들에 대한 의존성을 줄일 수 있음.
   - Factory Method Pattern: 어떤 클래스의 인스턴스를 만들지 서브 클래스에서 결정하게 만든다.
   - Abstract Factory Pattern: 팩토리를 만드는 상위 팩토리 클래스가 존재함
 ```swift
final class SquareSlideFactory: SlideFactory {
    
    private var differentIdArray: Set<String> = []
    
    func getFourSquareSlide() {
        for i in 1...4 {
            let randomSquareSlide = getSlide()
            let string: StaticString = "Rect%d %s"
            
            os_log(string, i, (randomSquareSlide as! SquareSlide).description)
        }
    }

...
protocol SlideFactory {
    func getSlide() -> Slidable
    func getId() -> String
}

```
- 시스템 로그 함수
   - 로깅 작업이 적절한 로깅 수준에 따라 자동으로 분류되어 성능을 최적화하고 콘솔 로그의 무거운 출력을 줄일 수 있음
  ```swift
   os_log(_ message: StaticString, dso: UnsafeRawPointer? = #dsohandle, log: OSLog = .default, type: OSLogType = .default, _ args: CVarArg...)
   ```   

- 프로토콜 지향적 설계
   - 정사각형 모델이 채택할 수 있는 Square, 슬라이드가 채택할 수 있는 Slidable 또, SquareSlidable 등 다양한 프로토콜을 선언하여 이를 채택하게끔 하였습니다. 
* * *   

### 구현 화면 📱  
|테스트 코드|
|---|
|<img width="500" alt="image" src="https://github.com/softeerbootcamp-2nd/ios-keynote/assets/110437548/bb940942-1608-413f-8454-90120d524a00">|

* * *   


### 의문점 💭
- 지금까지 생성된 ID를 확인해서 없을 때까지 ID를 랜덤으로 생성하는 구조로 getID() 함수를 작성하였는데,  while문 사용과 생성된 모든 ID를 저장해야된다는 점이 문제입니다. 혹시 개선할 점이 있을까요?

```swift
   func getId() -> String {
        let stringArray = "abcdefghijklmnopqrstuvwxyz0123456789"
        
        var id: String = ""
        
        for _ in 0..<9 {
            id += String(stringArray.randomElement()!)
        }
        
        while differentIdArray.contains(id) {
            id = getId()
        }
        
        differentIdArray.insert(id)
        return id
    }
```
