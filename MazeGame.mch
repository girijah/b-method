/* MazeGame
 * Author: girijah
 * Creation date: 11/27/2017
 */
MACHINE
    MazeGame
    
SETS
    ANSWER = {yes, no};
    REPORT = {ERROR_Robot_hits_top_boundary, ERROR_Robot_hits_east_boundary, ERROR_Robot_hits_south_boundary, ERROR_Robot_hits_west_boundary, ERROR_It_is_a_wall_square, Possible_Move, Teleport_only_in_intermediate_state, ERROR_Robot_is_in_exit_square, Teleport_success}    
    
             
CONSTANTS
    width, height, entrySquare, exitSquare, squareX, squareY, wallSquares
    
PROPERTIES
    width:NATURAL1 & width = 7 &
    height:NATURAL1 & height = 5 &
    entrySquare = (1 |-> 1) &
    exitSquare = (1 |-> 5) &
    squareX = {1, 2, 3, 4, 5, 6, 7} &
    squareY = {1, 2, 3, 4, 5} &
    wallSquares = {(2|->1),(6|->1),(4|->2),(6|->2),(1|->3),(2|->3),(3|->3),(4|->3),(4|->4),(6|->4),(7|->4),(2|->5)}
    
    
VARIABLES
    robotAtX, robotAtY, visitedSquareSeq, visitedPath
    
       
INVARIANT
    robotAtX : NATURAL1 &
    robotAtY : NATURAL1 &   
    visitedSquareSeq : seq(squareX * squareY) &
    visitedPath : {squareX * squareY}
    
    
INITIALISATION    
    robotAtX, robotAtY, visitedSquareSeq, visitedPath := 1, 1, [], {}
    
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
    
    
    
    output <-- visitedSquare  =
    BEGIN
        IF ((robotAtX |-> robotAtY) : visitedPath)
        THEN
            output := yes
        ELSE
            output := no
        END
    END;
    
    
    
    outputRoute <-- robotsRoute =
    BEGIN
        outputRoute := visitedSquareSeq
    END;
    
    
    
    result <-- Teleport =
    PRE
        robotAtX : 1..width & robotAtY : 1..height 
    THEN
        IF ((robotAtX |-> robotAtY) = entrySquare)   
        THEN
           result := Teleport_only_in_intermediate_state 
       ELSIF ((robotAtX |-> robotAtY) = exitSquare)           
       THEN
           result := ERROR_Robot_is_in_exit_square
       ELSE           
           robotAtX := 1 ||
           robotAtY := 5 ||
           visitedSquareSeq := (visitedSquareSeq <- (robotAtX |->  robotAtY)) ||
           visitedPath := visitedPath \/ {robotAtX |->  robotAtY} ||
           result := Teleport_success
        END
    END;
        
                  
    report <--  MoveNorth = 
    PRE 
        robotAtX : 1..width & robotAtY : 1..height 
    THEN        
        IF(robotAtY = height)
        THEN
            report := ERROR_Robot_hits_top_boundary
        ELSIF ((robotAtX |-> robotAtY+1) : wallSquares)
        THEN
            report := ERROR_It_is_a_wall_square
            ELSE            
            visitedSquareSeq := (visitedSquareSeq <- (robotAtX |->  robotAtY)) ||
            visitedPath := visitedPath \/ {(robotAtX |->  robotAtY)} ||
            robotAtY := robotAtY+1 ||           
            report := Possible_Move
        END
    END;
    
            
    
    report <--  MoveEast = 
    PRE
        robotAtX : 1..width & robotAtY : 1..height
    THEN
        IF (robotAtX = width)
        THEN
            report := ERROR_Robot_hits_east_boundary
        ELSIF ((robotAtX+1 |-> robotAtY) : wallSquares)
        THEN
            report := ERROR_It_is_a_wall_square                
        ELSE
            visitedSquareSeq := visitedSquareSeq <- (robotAtX |-> robotAtY) ||
            visitedPath := visitedPath \/ {(robotAtX |->  robotAtY)} ||
            robotAtX := robotAtX+1 ||           
            report := Possible_Move             
        END
    END;
    
    
    
    report <--  MoveSouth =
    PRE
        robotAtX: 1..width & robotAtY: 1..height
    THEN 
        IF (robotAtY = 1)
        THEN
            report := ERROR_Robot_hits_south_boundary
        ELSIF ((robotAtX |-> robotAtY-1) : wallSquares)
        THEN
            report := ERROR_It_is_a_wall_square
        ELSE
            visitedSquareSeq := visitedSquareSeq <- (robotAtX |-> robotAtY) ||
            visitedPath := visitedPath \/ {(robotAtX |->  robotAtY)} ||
            robotAtY := robotAtY-1 ||            
            report := Possible_Move           
        END
    END;
    
    
    
    report <--  MoveWest = 
    PRE
       robotAtX : 1..width & robotAtY : 1..height
   THEN
       IF (robotAtX = 1)
       THEN
           report := ERROR_Robot_hits_west_boundary
       ELSIF ((robotAtX-1 |-> robotAtY) : wallSquares)
       THEN
           report := ERROR_It_is_a_wall_square
       ELSE
           visitedSquareSeq := visitedSquareSeq <- (robotAtX |-> robotAtY) ||
           visitedPath := visitedPath \/ {(robotAtX |->  robotAtY)} ||
           robotAtX := robotAtX-1 ||           
           report := Possible_Move             
       END
   END   
   
  
  
END
