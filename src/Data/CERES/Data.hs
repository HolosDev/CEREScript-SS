module Data.CERES.Data where


import           Data.IntMap                    ( IntMap )
import qualified Data.IntMap                   as IM
import qualified Data.Text                     as T
import           Data.Text.Lazy                 ( Text )
import qualified Data.Text.Lazy                as TL
import           Data.Trie.Text                 ( Trie )
import           Data.Trie.Text                as Trie

import           TextShow                      as TS

import           Data.CERES.Type
import           Data.CERES.Util
import           Data.CERES.Operator


-------------------------------- VariablePosition --------------------------------

type VPosition = VariablePosition

-- TODO: Would be Pseudo-Tree form
type CEREScript = [CERES]

data CERES
  -- | Initialize Variable VPosition A with Value at VPosition B
  = CRSInitVariable     VPosition VPosition
  -- | Initialize Variable at position which stored in VPosition A with Value at VPosition B
  | CRSInitVariableAt   VPosition VPosition
  -- | Set Value at VPosition A as VPosition B
  | CRSSetValue         VPosition VPosition
  -- | Delete Variable at VPosition A
  | CRSDeleteVariable   VPosition
  -- | Modify Value at VPosition A by CERESOperator with Value at VPosition B
  | CRSModifyValue      VPosition VPosition CERESOperator
  -- | Copy Value at VPosition B to Variable at VPosition A
  | CRSCopyValue        VPosition VPosition
  -- | Convert type of Value at VPosition A as like as Value at VPosition B
  | CRSConvertValue     VPosition ValueType
  -- | Convert type of Value at VPosition A as like as Value at VPosition B
  | CRSConvertValueBy   VPosition VPosition
  -- | Convert value at VPosition A with a given rule VPosition B
  | CRSConvertValueWith VPosition VPosition
  -- | Replace StrValue at VPosition A with indicated Value in the StrValue
  | CRSReplaceText      VPosition
  -- | Replace StrValue at VPosition A with indicated Value in the StrValue to VPosition B
  | CRSReplaceTextTo    VPosition VPosition
  -- | Generate Random Value at VPosition A as a ValueType
  | CRSRandom           VPosition ValueType
  -- | Generate Random Value at VPosition A as a type VPosition B
  | CRSRandomBy         VPosition VPosition
  -- | Generate Random Value at VPosition A as a ValueType, And parameters vpC, vpD, and vpE
  | CRSRandomWith       VPosition ValueType VPosition VPosition VPosition
  -- | Generate Random Value at VPosition A as a type VPosition B, And parameters vpC, vpD, and vpE
  | CRSRandomWithBy     VPosition VPosition VPosition VPosition VPosition
  -- | ElapseTime <{Absolute,Scale}> <ScaleSize>
  | CRSElapseTime       VPosition VPosition
  -- | SPControl <{Stop,Pause}>
  | CRSSPControl        VPosition
  -- | SIControl <{Retain,Forget,Init,Abolish}> <JumpOffset>
  | CRSSIControl        VPosition VPosition
  -- | SIInit <SpoolID> <Given SIName> <where initiated SI ID store>
  | CRSSIInit           VPosition VPosition VPosition
  -- | No-Op
  | CRSNoop
  -- | Log a content of VPosition A to VPosition B
  | CRSLog VPosition VPosition
  -- | Parse a script text of VPosition A and store the script to VPosition B
  | CRSParseScript VPosition VPosition
  -- | ToInterpreter0
  | CRSToInterpreter0 IHeader IContent
  -- | ToInterpreter1 passes one Value at VPosition A
  | CRSToInterpreter1 IHeader IContent VPosition
  -- | ToInterpreter2 passes one Value at VPosition A and VPosition B
  | CRSToInterpreter2 IHeader IContent VPosition VPosition
  -- | ToInterpreter3 passes one Value at VPosition A, VPosition B and VPosition C
  | CRSToInterpreter3 IHeader IContent VPosition VPosition VPosition
  -- | ToInterpreter4 passes one Value at VPosition A, VPosition B, VPosition C and VPosition D
  | CRSToInterpreter4 IHeader IContent VPosition VPosition VPosition VPosition
  -- | ToInterpreter5 passes one Value at VPosition A, VPosition B, VPosition C, VPosition D and VPosition E
  | CRSToInterpreter5 IHeader IContent VPosition VPosition VPosition VPosition VPosition
  -- | ToInterpreter6 passes one Value at VPosition A, VPosition B, VPosition C and VPosition D, VPosition E and VPosition F
  | CRSToInterpreter6 IHeader IContent VPosition VPosition VPosition VPosition VPosition VPosition
  -- | ToInterpreter7 passes one Value at VPosition A, VPosition B, VPosition C and VPosition D, VPosition E, VPosition F and VPosition G
  | CRSToInterpreter7 IHeader IContent VPosition VPosition VPosition VPosition VPosition VPosition VPosition
  -- | ToInterpreter8 passes one Value at VPosition A, VPosition B, VPosition C and VPosition D, VPosition E, VPosition F, VPosition G and VPosition H
  | CRSToInterpreter8 IHeader IContent VPosition VPosition VPosition VPosition VPosition VPosition VPosition VPosition
  -- | Extend0
  | CRSExtend0 IHeader IContent
  -- | Extend1 passes one Value at VPosition A
  | CRSExtend1 IHeader IContent VPosition
  -- | Extend2 passes one Value at VPosition A and VPosition B
  | CRSExtend2 IHeader IContent VPosition VPosition
  -- | Extend3 passes one Value at VPosition A, VPosition B and VPosition C
  | CRSExtend3 IHeader IContent VPosition VPosition VPosition
  -- | Extend4 passes one Value at VPosition A, VPosition B, VPosition C and VPosition D
  | CRSExtend4 IHeader IContent VPosition VPosition VPosition VPosition
  -- | Extend5 passes one Value at VPosition A, VPosition B, VPosition C, VPosition D and VPosition E
  | CRSExtend5 IHeader IContent VPosition VPosition VPosition VPosition VPosition
  -- | Extend6 passes one Value at VPosition A, VPosition B, VPosition C and VPosition D, VPosition E and VPosition F
  | CRSExtend6 IHeader IContent VPosition VPosition VPosition VPosition VPosition VPosition
  -- | Extend7 passes one Value at VPosition A, VPosition B, VPosition C and VPosition D, VPosition E, VPosition F and VPosition G
  | CRSExtend7 IHeader IContent VPosition VPosition VPosition VPosition VPosition VPosition VPosition
  -- | Extend8 passes one Value at VPosition A, VPosition B, VPosition C and VPosition D, VPosition E, VPosition F, VPosition G and VPosition H
  | CRSExtend8 IHeader IContent VPosition VPosition VPosition VPosition VPosition VPosition VPosition VPosition
  deriving (Eq, Ord)

instance Show CERES where
  show = toString . showb

instance TextShow CERES where
  showb (CRSInitVariable   vpA vpB    ) = showbCS2 "InitVariable" vpA vpB
  showb (CRSInitVariableAt vpA vpB    ) = showbCS2 "InitVariableAt" vpA vpB
  showb (CRSSetValue       vpA vpB    ) = showbCS2 "SetValue" vpA vpB
  showb (CRSDeleteVariable vp         ) = showbCS1 "DeleteVariable" vp
  showb (CRSModifyValue vpA vpB cOper ) = showbCS3 "ModifyValue" vpA vpB cOper
  showb (CRSCopyValue        vpA vpB  ) = showbCS2 "CopyValue" vpA vpB
  showb (CRSConvertValue     vp  vType) = showbCS2 "ConvertValue" vp vType
  showb (CRSConvertValueBy   vpA vpB  ) = showbCS2 "ConvertValueBy" vpA vpB
  showb (CRSConvertValueWith vpA vpB  ) = showbCS2 "ConvertValueWith" vpA vpB
  showb (CRSReplaceText vp            ) = showbCS1 "ReplaceText" vp
  showb (CRSReplaceTextTo vpA vpB     ) = showbCS2 "ReplaceTextTo" vpA vpB
  showb (CRSRandom        vp  vType   ) = showbCS2 "Random" vp vType
  showb (CRSRandomBy      vpA vpB     ) = showbCS2 "RandomBy" vpA vpB
  showb (CRSRandomWith vpA vtB vpC vpD vpE) =
    showbCS5 "RandomWith" vpA vtB vpC vpD vpE
  showb (CRSRandomWithBy vpA vpB vpC vpD vpE) =
    showbCS5 "RandomWithBy" vpA vpB vpC vpD vpE
  showb (CRSElapseTime vpA vpB)               = showbCS2 "ElapseTime" vpA vpB
  showb (CRSSPControl vp      )               = showbCS1 "SPControl" vp
  showb (CRSSIControl vpA vpB )               = showbCS2 "SIControl" vpA vpB
  showb (CRSSIInit vpA vpB vpC)               = showbCS3 "SIInit" vpA vpB vpC
  showb CRSNoop                               = fromLazyText "Noop"
  showb (CRSLog            vpA vpB          ) = showbCS2 "Log" vpA vpB
  showb (CRSParseScript    vpA vpB          ) = showbCS2 "ParseScript" vpA vpB
  showb (CRSToInterpreter0 iH  iC           ) = showbCSC0 iH iC
  showb (CRSToInterpreter1 iH iC vpA        ) = showbCSC1 iH iC vpA
  showb (CRSToInterpreter2 iH iC vpA vpB    ) = showbCSC2 iH iC vpA vpB
  showb (CRSToInterpreter3 iH iC vpA vpB vpC) = showbCSC3 iH iC vpA vpB vpC
  showb (CRSToInterpreter4 iH iC vpA vpB vpC vpD) =
    showbCSC4 iH iC vpA vpB vpC vpD
  showb (CRSToInterpreter5 iH iC vpA vpB vpC vpD vpE) =
    showbCSC5 iH iC vpA vpB vpC vpD vpE
  showb (CRSToInterpreter6 iH iC vpA vpB vpC vpD vpE vpF) =
    showbCSC6 iH iC vpA vpB vpC vpD vpE vpF
  showb (CRSToInterpreter7 iH iC vpA vpB vpC vpD vpE vpF vpG) =
    showbCSC7 iH iC vpA vpB vpC vpD vpE vpF vpG
  showb (CRSToInterpreter8 iH iC vpA vpB vpC vpD vpE vpF vpG vpH) =
    showbCSC8 iH iC vpA vpB vpC vpD vpE vpF vpG vpH
  showb (CRSExtend0 iH iC                ) = showbCSC0 iH iC
  showb (CRSExtend1 iH iC vpA            ) = showbCSC1 iH iC vpA
  showb (CRSExtend2 iH iC vpA vpB        ) = showbCSC2 iH iC vpA vpB
  showb (CRSExtend3 iH iC vpA vpB vpC    ) = showbCSC3 iH iC vpA vpB vpC
  showb (CRSExtend4 iH iC vpA vpB vpC vpD) = showbCSC4 iH iC vpA vpB vpC vpD
  showb (CRSExtend5 iH iC vpA vpB vpC vpD vpE) =
    showbCSC5 iH iC vpA vpB vpC vpD vpE
  showb (CRSExtend6 iH iC vpA vpB vpC vpD vpE vpF) =
    showbCSC6 iH iC vpA vpB vpC vpD vpE vpF
  showb (CRSExtend7 iH iC vpA vpB vpC vpD vpE vpF vpG) =
    showbCSC7 iH iC vpA vpB vpC vpD vpE vpF vpG
  showb (CRSExtend8 iH iC vpA vpB vpC vpD vpE vpF vpG vpH) =
    showbCSC8 iH iC vpA vpB vpC vpD vpE vpF vpG vpH


-------------------------------- VariablePosition --------------------------------
-- Variable Position for abstract variable's real place
data VariablePosition
  = VP VariablePlace VariableIndex
  deriving (Eq, Ord)

instance Show VariablePosition where
  show = toString . showb

instance TextShow VariablePosition where
  showb (VP vPlace vIndex) =
    showb vPlace <> TS.singleton '[' <> showb vIndex <> TS.singleton ']'

-- TODO: Need to implement Eq/Ord instances for AtWorld and AtTime based on worldTime
-- instance Eq VariablePosition
-- instance Ord VariablePosition


-------------------------------- VariablePlace --------------------------------

data VariablePlace
  = AtTricky | AtPtr
  | AtWorld | AtTime | AtNWorld | AtNTime
  | AtDict | AtNDict | AtVars | AtNVars
  | AtLVars | AtLNVars | AtLTemp | AtLNTemp
  | AtReg | AtHere | AtNull
  deriving (Eq, Ord, Enum, Bounded, Read)

instance Show VariablePlace where
  show = toString . showb

instance TextShow VariablePlace where
  showb AtTricky = fromLazyText "AtTricky"
  showb AtPtr    = fromLazyText "AtPtr"
  showb AtWorld  = fromLazyText "AtWorld"
  showb AtTime   = fromLazyText "AtTime"
  showb AtNWorld = fromLazyText "AtNWorld"
  showb AtNTime  = fromLazyText "AtNTime"
  showb AtDict   = fromLazyText "AtDict"
  showb AtNDict  = fromLazyText "AtNDict"
  showb AtVars   = fromLazyText "AtVars"
  showb AtNVars  = fromLazyText "AtNVars"
  showb AtLVars  = fromLazyText "AtLVars"
  showb AtLNVars = fromLazyText "AtLNVars"
  showb AtLTemp  = fromLazyText "AtLTemp"
  showb AtLNTemp = fromLazyText "AtLNTemp"
  showb AtReg    = fromLazyText "AtReg"
  showb AtHere   = fromLazyText "AtHere"
  showb AtNull   = fromLazyText "AtNull"


-------------------------------- VariableIndex --------------------------------

data VariableIndex
  = VII Idx | VIN NKey | VIpN NKey | VIIT Idx Time | VINT NKey Time | VIpNT NKey Time
  | VIIRI Idx [Idx] | VINRI NKey [Idx] | VIpNRI NKey [Idx]
  | VIIRIT Idx [Idx] Time | VINRIT NKey [Idx] Time | VIpNRIT NKey [Idx] Time
  | VIV Value | VIAtom | VINull | VIPtr VariablePosition
  | PVII Idx | PVIN NKey | PVIpN NKey | PVIT Time
  | PVIIRI Idx [Idx] | PVINRI NKey [Idx] | PVIpNRI NKey [Idx]
  | PVIIRIT Idx [Idx] Time | PVINRIT NKey [Idx] Time | PVIpNRIT NKey [Idx] Time
  deriving (Eq, Ord)

instance Show VariableIndex where
  show = toString . showb

instance TextShow VariableIndex where
  showb (VII  idx                 )  = showb1 "VII" idx
  showb (VIN  nKey                )  = showb1 "VIN" nKey
  showb (VIpN nKey                )  = showb1 "VIpN" nKey
  showb (VIIT   idx  time         )  = showb2 "VIIT" idx time
  showb (VINT   nKey time         )  = showb2 "VINT" nKey time
  showb (VIpNT  nKey time         )  = showb2 "VIpNT" nKey time
  showb (VIIRI  idx  indices      )  = showb2 "VIIRI" idx indices
  showb (VINRI  nKey indices      )  = showb2 "VINRI" nKey indices
  showb (VIpNRI nKey indices      )  = showb2 "VIpNRI" nKey indices
  showb (VIIRIT  idx  indices time)  = showb3 "VIIRIT" idx indices time
  showb (VINRIT  nKey indices time)  = showb3 "VINRIT" nKey indices time
  showb (VIpNRIT nKey indices time)  = showb3 "VIpNRIT" nKey indices time
  showb (VIV value                )  = showb1 "VIV" value
  showb VIAtom                       = fromLazyText "VIAtom"
  showb VINull                       = fromLazyText "VINull"
  showb (VIPtr vp                  ) = showb1 "VIPtr" vp
  showb (PVII  idx                 ) = showb1 "PVII" idx
  showb (PVIN  nKey                ) = showb1 "PVIN" nKey
  showb (PVIpN nKey                ) = showb1 "PVIpN" nKey
  showb (PVIT  time                ) = showb1 "PVIT" time
  showb (PVIIRI  idx  indices      ) = showb2 "PVIIRI" idx indices
  showb (PVINRI  nKey indices      ) = showb2 "PVINRI" nKey indices
  showb (PVIpNRI nKey indices      ) = showb2 "PVIpNRI" nKey indices
  showb (PVIIRIT  idx  indices time) = showb3 "PVIIRIT" idx indices time
  showb (PVINRIT  nKey indices time) = showb3 "PVINRIT" nKey indices time
  showb (PVIpNRIT nKey indices time) = showb3 "PVIpNRIT" nKey indices time


-------------------------------- Value --------------------------------

-- TODO: Can't determine whether `(ErrValue _) /= (ErrValue _)` or not
data Value
  = IntValue { iV :: Int }
  | DblValue { dV :: Double }
  | StrValue { sV :: Str }
  | BoolValue { bV :: Bool }
  | AtomValue
  | ArrValue { aV :: Array Value}
  | PtrValue { pV :: VariablePosition }
  | ErrValue { errMessage :: Message }
  deriving (Eq, Ord)

instance Show Value where
  show = toString . showb

instance TextShow Value where
  showb (IntValue i) = fromLazyText "IV<| " <> showb i <> fromLazyText " |>"
  showb (DblValue d) = fromLazyText "DV<| " <> showb d <> fromLazyText " |>"
  showb (StrValue s) =
    fromLazyText "SV<| " <> fromLazyText s <> fromLazyText " |>"
  showb (BoolValue b) = fromLazyText "BV<| " <> showb b <> fromLazyText " |>"
  showb AtomValue     = fromLazyText "AV<| - |>"
  showb (PtrValue vp) = fromLazyText "PV<| " <> showb vp <> " |>"
  showb (ArrValue a)  = fromLazyText "A[" <> showbArray a <> "]"
   where
    showbArray :: Array Value -> Builder
    showbArray a = if IM.null a
      then fromLazyText "||  ||"
      else IM.foldrWithKey
        (\i v -> (<> TS.singleton ' ' <> showbElem i v <> fromLazyText " ||"))
        (fromLazyText "||")
        a
    showbElem :: Idx -> Value -> Builder
    showbElem i v = showb i <> TS.singleton ':' <> showb v
  showb (ErrValue e) =
    fromLazyText "EV<| " <> fromLazyText e <> fromLazyText " |>"

showRaw :: Value -> String
showRaw = TL.unpack . showRawTL

showRawTL :: Value -> Text
showRawTL (IntValue  i) = showtl i
showRawTL (DblValue  d) = showtl d
showRawTL (StrValue  s) = s
showRawTL (BoolValue b) = showtl b
showRawTL AtomValue     = "Atom"
showRawTL (PtrValue vp) = showtl vp
showRawTL (ArrValue a)  = showtl . IM.toList $ a
showRawTL (ErrValue e)  = e


-------------------------------- ValueType --------------------------------

data ValueType
  = VTInt
  | VTDbl
  | VTStr
  | VTBool
  | VTAtom
  | VTArr
  | VTPtr
  | VTErr
  deriving (Eq, Ord, Enum, Read)

instance Show ValueType where
  show = toString . showb

instance TextShow ValueType where
  showb VTInt  = fromLazyText "C-Int"
  showb VTDbl  = fromLazyText "C-Dbl"
  showb VTStr  = fromLazyText "C-Str"
  showb VTBool = fromLazyText "CBool"
  showb VTAtom = fromLazyText "CAtom"
  showb VTArr  = fromLazyText "C-Arr"
  showb VTPtr  = fromLazyText "C-Ptr"
  showb VTErr  = fromLazyText "C-Err"


-------------------------------- Helper for Value --------------------------------

type ValueMap = IntMap Value
type ValueNMap = Trie Value

blankVM = IM.empty
blankVNM = Trie.empty

-------------------------------- ValueContainer --------------------------------

data ValueContainer = VC
  { value     :: Value
  , valueInfo :: ValueInfo
  } deriving (Show, Eq)

-- TODO: Not yet Implemented
data ValueInfo = ValueInfo
  { valueEdited       :: Bool
  , valueInheritance  :: ValueInheritanceFlag
  , valueDependencies :: [Branch]
  } deriving (Show, Eq)

data ValueInheritanceFlag = VIFInherit | VIFOnce deriving (Eq,Ord,Enum,Bounded)

instance Show ValueInheritanceFlag where
  show = toString . showb

instance TextShow ValueInheritanceFlag where
  showb VIFInherit = fromLazyText "Inherit"
  showb VIFOnce    = fromLazyText "Once"


-------------------------------- Helper for Value --------------------------------

data ValueTyper = ValueTyper
  { valueTyperName :: Name
  , valueType      :: ValueType
  } deriving (Show, Eq)