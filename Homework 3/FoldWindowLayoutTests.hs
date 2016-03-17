-- $Id: FoldWindowLayoutTests.hs,v 1.2 2013/09/24 18:55:42 leavens Exp leavens $
module FoldWindowLayoutTests where
import WindowLayout
import FoldWindowLayout
import Testing

main = dotests "FoldWindowLayoutTests $Revision: 1.2 $" tests

-- uses of foldWindowLayout for testing purposes, not for you to implement
watching' = foldWindowLayout (\(wn,_,_) -> [wn]) concat concat
changeChannel new old = 
    let changeName new old nm = if nm == old then new else nm
    in foldWindowLayout 
           (\(nm,w,h) -> Window {wname = changeName new old nm, 
                                         width = w, height = h})
           Horizontal
           Vertical
doubleSize = foldWindowLayout 
              (\(wn,w,h) -> Window {wname = wn, width = 2*w, height = 2*h})
              Horizontal
              Vertical
addToSize n = foldWindowLayout
               (\(wn,w,h) -> Window {wname = wn, width = n+w, height = n+h})
               Horizontal
               Vertical
multSize n = foldWindowLayout
               (\(wn,w,h) -> Window {wname = wn, width = n*w, height = n*h})
               Horizontal
               Vertical
totalWidth = foldWindowLayout
               (\(_,w,_) -> w)
               sum
               sum

-- a WindowLayout for testing
hlayout = 
    (Horizontal 
     [(Vertical [(Window {wname = "Tempest", width = 200, height = 100})
                ,(Window {wname = "Othello", width = 200, height = 77})
                ,(Window {wname = "Hamlet", width = 1000, height = 600})])
     ,(Horizontal [(Window {wname = "baseball", width = 50, height = 40})
                  ,(Window {wname = "track", width = 100, height = 60})
                  ,(Window {wname = "golf", width = 70, height = 30})])
     ,(Vertical [(Window {wname = "Star Trek", width = 40, height = 100})
                ,(Window {wname = "olympics", width = 80, height = 33})
                ,(Window {wname = "news", width = 20, height = 10})])])

tests :: [TestCase Bool]
tests =
    [assertTrue ((totalWidth hlayout) == 1760)
    ,assertTrue ((doubleSize hlayout) == (multSize 2 hlayout))
    ,assertTrue ((watching' hlayout) 
                 == ["Tempest","Othello","Hamlet","baseball","track","golf",
                     "Star Trek","olympics","news"])
    ,assertTrue 
     ((changeChannel 
       "pbs" "news" 
       (Vertical [(Window {wname = "news", width = 10, height = 5})
                 ,(Window {wname = "golf", width = 50, height = 25})
                 ,(Window {wname = "news", width = 30, height = 70})]))
      ==
      (Vertical [(Window {wname = "pbs", width = 10, height = 5})
                ,(Window {wname = "golf", width = 50, height = 25})
                ,(Window {wname = "pbs", width = 30, height = 70})]))
    ,assertTrue 
     ((addToSize 100 hlayout)
      ==
      (Horizontal 
       [(Vertical [(Window {wname = "Tempest", width = 300, height = 200})
                  ,(Window {wname = "Othello", width = 300, height = 177})
                  ,(Window {wname = "Hamlet", width = 1100, height = 700})])
       ,(Horizontal [(Window {wname = "baseball", width = 150, height = 140})
                    ,(Window {wname = "track", width = 200, height = 160})
                    ,(Window {wname = "golf", width = 170, height = 130})])
       ,(Vertical [(Window {wname = "Star Trek", width = 140, height = 200})
                  ,(Window {wname = "olympics", width = 180, height = 133})
                  ,(Window {wname = "news", width = 120, height = 110})])]) )
    ,assertTrue
     ((doubleSize hlayout) 
      ==
      (Horizontal 
       [(Vertical [(Window {wname = "Tempest", width = 400, height = 200})
                  ,(Window {wname = "Othello", width = 400, height = 154})
                  ,(Window {wname = "Hamlet", width = 2000, height = 1200})])
       ,(Horizontal [(Window {wname = "baseball", width = 100, height = 80})
                    ,(Window {wname = "track", width = 200, height = 120})
                    ,(Window {wname = "golf", width = 140, height = 60})])
       ,(Vertical [(Window {wname = "Star Trek", width = 80, height = 200})
                  ,(Window {wname = "olympics", width = 160, height = 66})
                  ,(Window {wname = "news", width = 40, height = 20})])]) )
    ]
