import Foundation

final class SquareSlide: SquareSlidable {
    
    // protocol에 property를 get, set으로 설정하면 컴파일러가 get, set을 메서드로 만들어줌요
    // 그래서 color라는 property를 사용할 때 style guide 이유 붙임
    private(set) var id: String
    private(set) var rgb: RGBColor
    private(set) var alpha: AlphaType
    private(set) var side: Int

    init(id: String, rgb: RGBColor, alpha: AlphaType, side: Int) {
        self.id = id
        self.rgb = rgb
        self.alpha = alpha
        self.side = side
    }
    //고민
    func changeRGB(rgb: RGBColor) {
        self.rgb = rgb
    }
    func changeAlpha(alpha: AlphaType) {
        self.alpha = alpha
    }
}
