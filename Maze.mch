/* Maze
 * Author: girijah
 * Creation date: 12/21/2017
 */
MACHINE
    Maze
    
CONSTANTS    
    width, height, exitSquare, squareX, squareY, wallSquares
    
PROPERTIES    
    width:NATURAL1 & width = 7 &
    height:NATURAL1 & height = 5 &    
    exitSquare = (1 |-> 5) &
    squareX = {1, 2, 3, 4, 5, 6, 7} &
    squareY = {1, 2, 3, 4, 5} &
    wallSquares = {(2|->1),(6|->1),(4|->2),(6|->2),(1|->3),(2|->3),(3|->3),(4|->3),(4|->4),(6|->4),(7|->4),(2|->5)}

END
