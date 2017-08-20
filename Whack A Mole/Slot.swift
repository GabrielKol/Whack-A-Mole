
class Slot{
    
    enum Creature: Int {
        
        case EMPTY = 0
        case HEALTHY_MOLE = 1
        case ILL_MOLE = 2
        
    }
    
    private var occupyingCreature: Creature = Creature.EMPTY
    
    public func getOccupyingCreature() -> Creature{
        return occupyingCreature
    }
    
    public func setOccupyingCreature(creature: Creature){
        occupyingCreature = creature
    }
    
}
