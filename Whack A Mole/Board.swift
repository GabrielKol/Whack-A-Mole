
class Board{
    
    private static var NUMBER_OF_COLS: Int = 3
    private var slots: [[Slot]] = Array(repeating: Array(repeating: Slot(), count: NUMBER_OF_COLS), count: NUMBER_OF_COLS)
    
    init() {
        let lastIndex = Board.NUMBER_OF_COLS - 1
        for i in 0...lastIndex{
            for j in 0...lastIndex{
                slots[i][j] = Slot()
            }
        }
    }
    public static func getNumberOfCols() -> Int{
        return NUMBER_OF_COLS
    }
    
    public func getSlot(positionI: Int, positionJ: Int) -> Slot{
        return slots[positionI][positionJ]
    }
    
}
