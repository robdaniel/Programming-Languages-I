-------------------
-- Robert Daniel --
--   COP  4020   --
--    HW3  #2    --
-------------------

-- $Id: ANN.hs,v 1.1 2013/09/24 14:54:21 leavens Exp leavens $
module ANN where

type NeuralNetwork = [NeuralLayer]
type NeuralLayer = [Neuron]
type Neuron = [Weight] -- without bias in this representation
type Weight = Double

type Vector = [Double] -- inputs and outputs

-- applyNetwork calculates the output for a given input vector
-- The vector iv is also used as an accumulator
applyNetwork' :: [Int] -> Int -> NeuralNetwork -> Vector -> Vector
applyNetwork' [] b nn iv = []
applyNetwork' lst b nn iv = [ applyNeuron (nn!!b!!x) iv | x <- lst ]

applyNetwork'' :: Int -> NeuralNetwork -> Vector -> Vector
applyNetwork'' a nn iv = 
	if ((length (nn!!a)) == 1)
		then (applyNetwork' [0] 0 nn iv)
		else (applyNetwork' [0..((length (nn!!a)) - 1)] 0 nn iv)

applyNetwork :: NeuralNetwork -> Vector -> Vector
applyNetwork nn iv = 
	if ((length nn) == 1)	
		then (applyNetwork' [0..((length (nn!!0)) - 1)] 0 nn iv)
		else 
			if (((applyNetwork' [0..((length (nn!!1)) - 1)] 1 nn (applyNetwork'' 0 nn iv))!!0) == ((applyNetwork' [0..((length (nn!!1)) - 1)] 1 nn (applyNetwork'' 0 nn iv))!!1))
				then [((applyNetwork' [0..((length (nn!!1)) - 1)] 1 nn (applyNetwork'' 0 nn iv))!!0)]
				else (applyNetwork' [0..((length (nn!!1)) - 1)] 1 nn (applyNetwork'' 0 nn iv))

applyNeuron' :: Neuron -> Vector -> Double
applyNeuron' n v = sum (zipWith (*) n v)

-- applyNeuron calculates the output of a neuron for a given input vector
applyNeuron :: Neuron -> Vector -> Double
applyNeuron n v = tanh (applyNeuron' n v)