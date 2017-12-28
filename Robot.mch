/* Robot
 * Author: girijah
 * Creation date: 12/21/2017
 */
MACHINE
    Robot
    
SEES
    Maze
    
 SETS    
    REPORT = {ERROR_Robot_hits_top_boundary, ERROR_Robot_hits_east_boundary, ERROR_Robot_hits_south_boundary, ERROR_Robot_hits_west_boundary, ERROR_It_is_a_wall_square, Possible_Move, Teleport_allowed_only_in_intermediate_state, ERROR_Cannot_teleport_to_a_wall, ERROR_Cannot_teleport_to_current_square_itself, Teleport_success}    
       
    
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
   END; 
   
    
    
    result <-- Teleport(teleportToX, teleportToY) =
    PRE
        teleportToX :  1..width & teleportToY : 1..height
    THEN
       IF ((teleportToX |-> teleportToY):wallSquares)   
       THEN
           result := ERROR_Cannot_teleport_to_a_wall           
       ELSIF (size(visitedSquareSeq) = 0)           
       THEN
           result := Teleport_allowed_only_in_intermediate_state
       ELSIF (teleportToX = robotAtX  & teleportToY = robotAtY)
       THEN
           result := ERROR_Cannot_teleport_to_current_square_itself
       ELSE           
           robotAtX := teleportToX ||
           robotAtY := teleportToY ||
           visitedSquareSeq := (visitedSquareSeq <- (teleportToX |->  teleportToY)) ||
           visitedPath := visitedPath \/ {teleportToX |->  teleportToY} ||
           result := Teleport_success           
        END
    END
END



