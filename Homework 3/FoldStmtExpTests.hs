-- $Id: FoldStmtExpTests.hs,v 1.1 2013/09/24 18:53:10 leavens Exp leavens $
module FoldStmtExpTests where
import StatementsExpressions
import FoldStmtExp
import Testing

main = dotests "FoldStmtExpTests $Revision: 1.1 $" tests

-- uses of foldWindowLayout for testing purposes, not for you to implement
integers :: Statement -> [Integer]
integers = foldStatement id (\_ re -> re) (++) (\v -> []) (\i -> [i]) 
                         (++) (\rss re -> (concat rss) ++ re) 
stmtAdd1 :: Statement -> Statement
stmtAdd1 = foldStatement ExpStmt AssignStmt IfStmt 
                         VarExp (\i -> NumExp (i+1)) EqualsExp BeginExp
substIdentifier :: Statement -> String -> String -> Statement
substIdentifier stmt new old = 
    foldStatement ExpStmt (\v re -> AssignStmt (substString v) re) IfStmt 
                  (\v -> VarExp (substString v)) NumExp EqualsExp BeginExp 
                  stmt
        where substString s = if s == old then new else s
-- variables :: Statement -> [String]
-- variables = 

-- a Statement for testing
myStmt = 
    (IfStmt
     (BeginExp [AssignStmt "v" (NumExp 3), ExpStmt (EqualsExp (NumExp 7) (NumExp 6))]
               (EqualsExp (VarExp "v") (VarExp "y")))
     (ExpStmt (BeginExp [(AssignStmt "y" (NumExp 7)),
                         (IfStmt (VarExp "true") (AssignStmt "y" (NumExp 3)))]
               (EqualsExp (VarExp "v") (VarExp "y")))))

tests :: [TestCase Bool]
tests =
    [assertTrue ((integers myStmt) == [3,7,6,7,3])
    ,assertTrue ((stmtAdd1 (AssignStmt "v" (NumExp 4))) == (AssignStmt "v" (NumExp 5)))
    ,assertTrue ((stmtAdd1 (ExpStmt (BeginExp [AssignStmt "v" (NumExp 4), ExpStmt (EqualsExp (NumExp 8) (NumExp 7))]
               (EqualsExp (VarExp "v") (VarExp "y"))))) 
                 == (ExpStmt (BeginExp [AssignStmt "v" (NumExp 5), ExpStmt (EqualsExp (NumExp 9) (NumExp 8))]
                               (EqualsExp (VarExp "v") (VarExp "y")))))
    ,assertTrue ((stmtAdd1 myStmt)
                 == (IfStmt
                     (BeginExp [AssignStmt "v" (NumExp 4), ExpStmt (EqualsExp (NumExp 8) (NumExp 7))]
               (EqualsExp (VarExp "v") (VarExp "y")))
     (ExpStmt (BeginExp [(AssignStmt "y" (NumExp 8)),
                         (IfStmt (VarExp "true") (AssignStmt "y" (NumExp 4)))]
               (EqualsExp (VarExp "v") (VarExp "y"))))))
    ,assertTrue ((substIdentifier (AssignStmt "v" (NumExp 4)) "x" "v")
                 == (AssignStmt "x" (NumExp 4)))
    ,assertTrue ((substIdentifier myStmt "z" "v")
                 == (IfStmt
                     (BeginExp [AssignStmt "z" (NumExp 3), ExpStmt (EqualsExp (NumExp 7) (NumExp 6))]
                                   (EqualsExp (VarExp "z") (VarExp "y")))
                     (ExpStmt (BeginExp [(AssignStmt "y" (NumExp 7)),
                                         (IfStmt (VarExp "true") (AssignStmt "y" (NumExp 3)))]
                               (EqualsExp (VarExp "z") (VarExp "y"))))))
    ]
