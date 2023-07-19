extension String {
    func subString(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else { return "" }
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to + 1)
        
        return String(self[startIndex..<endIndex])
    }
}
