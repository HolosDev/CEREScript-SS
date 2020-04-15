module Data.CERES.Data.Method where

import           Data.Text.Lazy                 ( Text )
import qualified Data.Text.Lazy                as TL

import           Data.CERES.Type
import           Data.CERES.Data


getInt :: Value -> Int
getInt (IntValue i) = i
getInt v            = error $ "[ERROR]<getInt> Given wrong type: " ++ show v
getDbl :: Value -> Double
getDbl (DblValue d) = d
getDbl v            = error $ "[ERROR]<getDbl> Given wrong type: " ++ show v
getStr :: Value -> Text
getStr (StrValue s) = s
getStr v            = error $ "[ERROR]<getStr> Given wrong type: " ++ show v
getBool :: Value -> Bool
getBool (BoolValue b) = b
getBool v             = error $ "[ERROR]<getBool> Given wrong type: " ++ show v
getAtom :: Value -> Atom
getAtom AtomValue = Atom
getAtom v         = error $ "[ERROR]<getAtom> Given wrong type: " ++ show v
getPtr :: Value -> VariablePosition
getPtr (PtrValue vp) = vp
getPtr v             = error $ "[ERROR]<getPtr> Given wrong type: " ++ show v
getArr :: Value -> Array Value
getArr (ArrValue a) = a
getArr v            = error $ "[ERROR]<getArr> Given wrong type: " ++ show v
getErr :: Value -> Message
getErr (ErrValue e) = e
getErr v            = error $ "[ERROR]<getErr> Given wrong type: " ++ show v


getValueType :: Value -> ValueType
getValueType v = case v of
  (IntValue  _) -> VTInt
  (DblValue  _) -> VTDbl
  (StrValue  _) -> VTStr
  (BoolValue _) -> VTBool
  AtomValue     -> VTAtom
  (PtrValue _)  -> VTPtr
  (ArrValue _)  -> VTArr
  (ErrValue _)  -> VTErr