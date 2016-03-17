-- $Id: ANNTests.hs,v 1.6 2013/09/25 11:00:01 leavens Exp leavens $
module ANNTests where
import ANN
import Testing
import FloatTesting
main = dotests2 "ANNTests $Revision: 1.6 $" ntests nntests
test_applyNeuron = dotests "Testing applyNeuron $Revision: 1.6 $" ntests
test_applyNetwork = dotests "Testing applyNetwork $Revision: 1.6 $" nntests
-- construction of Neural Networks, for testing, not for you to implement
af = tanh -- hyperbolic tangent is the activation function
initWeight = 1.0 -- initial weight
type Pattern = [Integer] -- used for construction
constructNN :: Pattern -> Integer -> NeuralNetwork
constructNN pattern m = createNN m pattern []
  where createNN :: Integer -> Pattern -> NeuralNetwork -> NeuralNetwork
        createNN _ [] acc = reverse acc
        createNN m (len:densities) acc =
            createNN len densities 
                          ([[initWeight | _<-[1..m]] | _<- [1..len]]:acc)
-- data for testing below
nn321 = constructNN [3,2,1] 3
demo = [[[1.0,1.0,1.0,1.0],[2.0,2.0,2.0,2.0],[3.0,3.0,3.0,3.0]]]
demo1 = [[[1.0,1.0,1.0],[2.0,2.0,2.0],[3.0,3.0,3.0]]]
demo2 = [[[1.0,1.0,1.0],[2.0,2.0,2.0],[3.0,3.0,3.0]],
         [[4.0,4.0,4.0],[5.0,5.0,5.0]]]
iv5678 = [5.0,6.0,7.0,8.0]
iv567 = [5.0,6.0,7.0]
ntests :: [TestCase Double]
ntests = [withinTest (applyNeuron [1.0,1.0] [0.0,0.0]) 
          "~=~" (af (1.0*0.0 + 1.0*0.0))
         ,withinTest (applyNeuron [1.05,1.0,0.95] [3.0,4.0,5.0]) 
          "~=~" (af (1.05*3.0 + 1.0*4.0 + 0.95*5.0))
         ,withinTest (applyNeuron [1.05,2.0,0.95] [3.0,4.0,5.0])
          "~=~" (af (1.05*3.0 + 2.0*4.0 + 0.95*5.0))
         ,withinTest (applyNeuron [1.0,1.0,1.0,1.0] [1.0,1.0,1.0,1.0]) 
          "~=~" (af 4.0) ]
nntests :: [TestCase [Double]]
nntests = 
    [vecWithin (applyNetwork demo iv5678)
     "~=~" [applyNeuron (demo!!0!!0) iv5678
           ,applyNeuron (demo!!0!!1) iv5678
           ,applyNeuron (demo!!0!!2) iv5678]
    ,vecWithin (applyNetwork demo1 iv567)
     "~=~" [applyNeuron (demo1!!0!!0) iv567
           ,applyNeuron (demo1!!0!!1) iv567
           ,applyNeuron (demo1!!0!!2) iv567]
    ,vecWithin (applyNetwork demo2 iv567)
     "~=~" (let layer1res = [applyNeuron (demo2!!0!!0) iv567
                            ,applyNeuron (demo2!!0!!1) iv567
                            ,applyNeuron (demo2!!0!!2) iv567]
            in [applyNeuron (demo2!!1!!0) layer1res
               ,applyNeuron (demo2!!1!!1) layer1res])
    ,vecWithin (applyNetwork nn321 [4.3,2.1,0.5]) "~=~" [0.9633220964607272]
    ,vecWithin (applyNetwork nn321 [0.0,0.0,0.0]) "~=~" [0.0]
    ,vecWithin (applyNetwork nn321 [1.0,1.0,1.0]) "~=~" [0.9633007043762163]
    ,vecWithin (applyNetwork nn321 [10.0,10.0,10.0]) "~=~" [0.9633221051195399]
    ,vecWithin (applyNetwork nn321 [-1.0,-1.0,-1.0]) "~=~" [-0.9633007043762163] ]
