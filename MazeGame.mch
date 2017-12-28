/* MazeGame
 * Author: girijah
 * Creation date: 11/27/2017
 */
MACHINE
    MazeGame
    
SEES
    Maze, Robot
    
SETS
    ANSWER = { yes, no }
    
   
OPERATIONS
    
    pos <-- getPosition = 
    BEGIN
        pos := (robotAtX |-> robotAtY)
    END;
    
    
    
    ans <-- foundExit = 
    PRE
        ans: ANSWER
    THEN
        IF ((robotAtX |-> robotAtY) = exitSquare)
        THEN
            ans := yes
        ELSE
            ans := no
        END
    END;
        
    
    
    outputRoute <-- robotsRoute =
    BEGIN
        outputRoute := visitedSquareSeq
    END;                
    
     
        
    output <-- visitedSquare (pathSquareX, pathSquareY)  =
    PRE
        pathSquareX : 1..width & pathSquareY : 1..height & pathSquareX |-> pathSquareY /: wallSquares
    THEN
        IF ((pathSquareX |-> pathSquareY) : visitedPath) 
        THEN
            output := yes
        ELSE
            output := no
        END                
    END   
    
END
