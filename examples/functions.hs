-- Some types are actually not @Data@. It is still possible to use
-- @boltzmann-samplers@ by adding dummy @Data@ instances where necessary, and by
-- working around them with an @Alias@.
--
-- We generate a list of @Arbitrary@ functions.

import Data.Data
import Test.QuickCheck
import Boltzmann.Data

-- | A wrapper for a dummy @Data@ instance.
newtype F = F (Bool -> Bool)

instance Data F where
  gunfold _ _ = undefined
  toConstr = undefined
  dataTypeOf = undefined

instance Show F where
  show (F f) = "<" ++ show (f True) ++ "," ++ show (f False) ++ ">"

gen :: Gen [F]
gen = sized $ generatorPWith aliases
  where
    aliases = [alias $ \() -> fmap F arbitrary :: Gen F]

main :: IO ()
main = sample gen
