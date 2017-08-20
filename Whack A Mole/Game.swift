import Foundation

class Game{
    
    private var board: Board = Board()
    private var score: Int = 0
    
    public func playSlot(positionI: Int, positionJ: Int){
        
        // If healthy:
        if board.getSlot(positionI: positionI, positionJ: positionJ).getOccupyingCreature() == Slot.Creature.HEALTHY_MOLE {
            board.getSlot(positionI: positionI, positionJ: positionJ).setOccupyingCreature(creature: Slot.Creature.EMPTY)
            score += 100
        }
            
        // If ill:
        else if board.getSlot(positionI: positionI, positionJ: positionJ).getOccupyingCreature() == Slot.Creature.ILL_MOLE {
            board.getSlot(positionI: positionI, positionJ: positionJ).setOccupyingCreature(creature: Slot.Creature.EMPTY)
            if score >= 100 {
                score -= 100
            }
        }
        
    }
    
    public func hideAndPopRandomSlots(){
        
        // Going through all slots of the board:
        let lastIndex = Board.getNumberOfCols()-1
        for i in 0...lastIndex{
            for j in 0...lastIndex{
                
                // Determine a new state for the slot randomly:
                let rand = Int(arc4random_uniform(3))
                if (rand == 0) {
                    board.getSlot(positionI: i, positionJ: j).setOccupyingCreature(creature: Slot.Creature.EMPTY)
                }
                else if (rand == 1){
                    board.getSlot(positionI: i, positionJ: j).setOccupyingCreature(creature: Slot.Creature.HEALTHY_MOLE)
                }
                else {
                    board.getSlot(positionI: i, positionJ: j).setOccupyingCreature(creature: Slot.Creature.ILL_MOLE)
                }
                
            }
        }
        
    }
    
    public func getBoard() -> Board{
        return board
    }
    
    public func getScore() -> Int{
        return score
    }
    
}
