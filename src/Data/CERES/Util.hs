module Data.CERES.Util where


import           Data.Text.Lazy                 ( Text )
import           TextShow


import           Data.CERES.Type


showb1 :: TextShow a => Text -> a -> Builder
showb1 n a = fromLazyText n <> singleton '=' <> showb a
showb2 :: (TextShow a, TextShow b) => Text -> a -> b -> Builder
showb2 n a b =
  fromLazyText n <> singleton '=' <> showb a <> singleton ':' <> showb b
showb3 :: (TextShow a, TextShow b, TextShow c) => Text -> a -> b -> c -> Builder
showb3 n a b c =
  fromLazyText n
    <> singleton '='
    <> showb a
    <> singleton ':'
    <> showb b
    <> singleton ':'
    <> showb c
showb4
  :: (TextShow a, TextShow b, TextShow c, TextShow d)
  => Text
  -> a
  -> b
  -> c
  -> d
  -> Builder
showb4 n a b c d =
  fromLazyText n
    <> singleton '='
    <> showb a
    <> singleton ':'
    <> showb b
    <> singleton ':'
    <> showb c
    <> singleton ':'
    <> showb d
showb5
  :: (TextShow a, TextShow b, TextShow c, TextShow d, TextShow e)
  => Text
  -> a
  -> b
  -> c
  -> d
  -> e
  -> Builder
showb5 n a b c d e =
  fromLazyText n
    <> singleton '='
    <> showb a
    <> singleton ':'
    <> showb b
    <> singleton ':'
    <> showb c
    <> singleton ':'
    <> showb d
    <> singleton ':'
    <> showb e
showb6
  :: (TextShow a, TextShow b, TextShow c, TextShow d, TextShow e, TextShow f)
  => Text
  -> a
  -> b
  -> c
  -> d
  -> e
  -> f
  -> Builder
showb6 n a b c d e f =
  fromLazyText n
    <> singleton '='
    <> showb a
    <> singleton ':'
    <> showb b
    <> singleton ':'
    <> showb c
    <> singleton ':'
    <> showb d
    <> singleton ':'
    <> showb e
    <> singleton ':'
    <> showb f
showb7
  :: ( TextShow a
     , TextShow b
     , TextShow c
     , TextShow d
     , TextShow e
     , TextShow f
     , TextShow g
     )
  => Text
  -> a
  -> b
  -> c
  -> d
  -> e
  -> f
  -> g
  -> Builder
showb7 n a b c d e f g =
  fromLazyText n
    <> singleton '='
    <> showb a
    <> singleton ':'
    <> showb b
    <> singleton ':'
    <> showb c
    <> singleton ':'
    <> showb d
    <> singleton ':'
    <> showb e
    <> singleton ':'
    <> showb f
    <> singleton ':'
    <> showb g
showb8
  :: ( TextShow a
     , TextShow b
     , TextShow c
     , TextShow d
     , TextShow e
     , TextShow f
     , TextShow g
     , TextShow h
     )
  => Text
  -> a
  -> b
  -> c
  -> d
  -> e
  -> f
  -> g
  -> h
  -> Builder
showb8 n a b c d e f g h =
  fromLazyText n
    <> singleton '='
    <> showb a
    <> singleton ':'
    <> showb b
    <> singleton ':'
    <> showb c
    <> singleton ':'
    <> showb d
    <> singleton ':'
    <> showb e
    <> singleton ':'
    <> showb f
    <> singleton ':'
    <> showb g
    <> singleton ':'
    <> showb h

showbCS1 :: TextShow a => Text -> a -> Builder
showbCS1 n a = fromLazyText n <> singleton ' ' <> showb a
showbCS2 :: (TextShow a, TextShow b) => Text -> a -> b -> Builder
showbCS2 n a b =
  fromLazyText n <> singleton ' ' <> showb a <> singleton ' ' <> showb b
showbCS3
  :: (TextShow a, TextShow b, TextShow c) => Text -> a -> b -> c -> Builder
showbCS3 n a b c =
  fromLazyText n
    <> singleton ' '
    <> showb a
    <> singleton ' '
    <> showb b
    <> singleton ' '
    <> showb c
showbCS4
  :: (TextShow a, TextShow b, TextShow c, TextShow d)
  => Text
  -> a
  -> b
  -> c
  -> d
  -> Builder
showbCS4 n a b c d =
  fromLazyText n
    <> singleton ' '
    <> showb a
    <> singleton ' '
    <> showb b
    <> singleton ' '
    <> showb c
    <> singleton ' '
    <> showb d
showbCS5
  :: (TextShow a, TextShow b, TextShow c, TextShow d, TextShow e)
  => Text
  -> a
  -> b
  -> c
  -> d
  -> e
  -> Builder
showbCS5 n a b c d e =
  fromLazyText n
    <> singleton ' '
    <> showb a
    <> singleton ' '
    <> showb b
    <> singleton ' '
    <> showb c
    <> singleton ' '
    <> showb d
    <> singleton ' '
    <> showb e
showbCS6
  :: (TextShow a, TextShow b, TextShow c, TextShow d, TextShow e, TextShow f)
  => Text
  -> a
  -> b
  -> c
  -> d
  -> e
  -> f
  -> Builder
showbCS6 n a b c d e f =
  fromLazyText n
    <> singleton ' '
    <> showb a
    <> singleton ' '
    <> showb b
    <> singleton ' '
    <> showb c
    <> singleton ' '
    <> showb d
    <> singleton ' '
    <> showb e
    <> singleton ' '
    <> showb f
showbCS7
  :: ( TextShow a
     , TextShow b
     , TextShow c
     , TextShow d
     , TextShow e
     , TextShow f
     , TextShow g
     )
  => Text
  -> a
  -> b
  -> c
  -> d
  -> e
  -> f
  -> g
  -> Builder
showbCS7 n a b c d e f g =
  fromLazyText n
    <> singleton ' '
    <> showb a
    <> singleton ' '
    <> showb b
    <> singleton ' '
    <> showb c
    <> singleton ' '
    <> showb d
    <> singleton ' '
    <> showb e
    <> singleton ' '
    <> showb f
    <> singleton ' '
    <> showb g
showbCS8
  :: ( TextShow a
     , TextShow b
     , TextShow c
     , TextShow d
     , TextShow e
     , TextShow f
     , TextShow g
     , TextShow h
     )
  => Text
  -> a
  -> b
  -> c
  -> d
  -> e
  -> f
  -> g
  -> h
  -> Builder
showbCS8 n a b c d e f g h =
  fromLazyText n
    <> singleton ' '
    <> showb a
    <> singleton ' '
    <> showb b
    <> singleton ' '
    <> showb c
    <> singleton ' '
    <> showb d
    <> singleton ' '
    <> showb e
    <> singleton ' '
    <> showb f
    <> singleton ' '
    <> showb g
    <> singleton ' '
    <> showb h



showbCSC0 :: IHeader -> IContent -> Builder
showbCSC0 ih ic = fromText ih <> singleton ' ' <> fromText ic
showbCSC1 :: TextShow a => IHeader -> IContent -> a -> Builder
showbCSC1 ih ic a =
  fromText ih <> singleton ' ' <> fromText ic <> singleton ' ' <> showb a
showbCSC2
  :: (TextShow a, TextShow b) => IHeader -> IContent -> a -> b -> Builder
showbCSC2 ih ic a b =
  fromText ih
    <> singleton ' '
    <> fromText ic
    <> singleton ' '
    <> showb a
    <> singleton ' '
    <> showb b
showbCSC3
  :: (TextShow a, TextShow b, TextShow c)
  => IHeader
  -> IContent
  -> a
  -> b
  -> c
  -> Builder
showbCSC3 ih ic a b c =
  fromText ih
    <> singleton ' '
    <> fromText ic
    <> singleton ' '
    <> showb a
    <> singleton ' '
    <> showb b
    <> singleton ' '
    <> showb c
showbCSC4
  :: (TextShow a, TextShow b, TextShow c, TextShow d)
  => IHeader
  -> IContent
  -> a
  -> b
  -> c
  -> d
  -> Builder
showbCSC4 ih ic a b c d =
  fromText ih
    <> singleton ' '
    <> fromText ic
    <> singleton ' '
    <> showb a
    <> singleton ' '
    <> showb b
    <> singleton ' '
    <> showb c
    <> singleton ' '
    <> showb d
showbCSC5
  :: (TextShow a, TextShow b, TextShow c, TextShow d, TextShow e)
  => IHeader
  -> IContent
  -> a
  -> b
  -> c
  -> d
  -> e
  -> Builder
showbCSC5 ih ic a b c d e =
  fromText ih
    <> singleton ' '
    <> fromText ic
    <> singleton ' '
    <> showb a
    <> singleton ' '
    <> showb b
    <> singleton ' '
    <> showb c
    <> singleton ' '
    <> showb d
    <> singleton ' '
    <> showb e
showbCSC6
  :: (TextShow a, TextShow b, TextShow c, TextShow d, TextShow e, TextShow f)
  => IHeader
  -> IContent
  -> a
  -> b
  -> c
  -> d
  -> e
  -> f
  -> Builder
showbCSC6 ih ic a b c d e f =
  fromText ih
    <> singleton ' '
    <> fromText ic
    <> singleton ' '
    <> showb a
    <> singleton ' '
    <> showb b
    <> singleton ' '
    <> showb c
    <> singleton ' '
    <> showb d
    <> singleton ' '
    <> showb e
    <> singleton ' '
    <> showb f
showbCSC7
  :: ( TextShow a
     , TextShow b
     , TextShow c
     , TextShow d
     , TextShow e
     , TextShow f
     , TextShow g
     )
  => IHeader
  -> IContent
  -> a
  -> b
  -> c
  -> d
  -> e
  -> f
  -> g
  -> Builder
showbCSC7 ih ic a b c d e f g =
  fromText ih
    <> singleton ' '
    <> fromText ic
    <> singleton ' '
    <> showb a
    <> singleton ' '
    <> showb b
    <> singleton ' '
    <> showb c
    <> singleton ' '
    <> showb d
    <> singleton ' '
    <> showb e
    <> singleton ' '
    <> showb f
    <> singleton ' '
    <> showb g
showbCSC8
  :: ( TextShow a
     , TextShow b
     , TextShow c
     , TextShow d
     , TextShow e
     , TextShow f
     , TextShow g
     , TextShow h
     )
  => IHeader
  -> IContent
  -> a
  -> b
  -> c
  -> d
  -> e
  -> f
  -> g
  -> h
  -> Builder
showbCSC8 ih ic a b c d e f g h =
  fromText ih
    <> singleton ' '
    <> fromText ic
    <> singleton ' '
    <> showb a
    <> singleton ' '
    <> showb b
    <> singleton ' '
    <> showb c
    <> singleton ' '
    <> showb d
    <> singleton ' '
    <> showb e
    <> singleton ' '
    <> showb f
    <> singleton ' '
    <> showb g
    <> singleton ' '
    <> showb h

