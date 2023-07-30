final class IDManager {
    static let shared = IDManager()
    
    private init() { }
    private var uniqueIDSet: Set<String> = []
    
    func makeRandomID() -> String {
        let stringArray = "abcdefghijklmnopqrstuvwxyz0123456789"
        var id: String = ""
        for _ in 0..<9 {
            if let randomString = stringArray.randomElement() {
                id += String(randomString)
            }
        }
        while uniqueIDSet.contains(id) {
            id = makeRandomID()
        }
        uniqueIDSet.insert(id)
        return id
    }
}

