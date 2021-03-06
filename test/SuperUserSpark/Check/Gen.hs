{-# OPTIONS_GHC -Wno-orphans #-}

module SuperUserSpark.Check.Gen where

import TestImport

import SuperUserSpark.Bake.Gen ()
import SuperUserSpark.Check.Types
import SuperUserSpark.Compiler.Gen ()
import SuperUserSpark.Diagnose.Gen ()
import SuperUserSpark.Language.Gen ()

instance GenUnchecked CheckAssignment

instance GenValid CheckAssignment where
    genValid = CheckAssignment <$> genValid <*> genValid

instance GenUnchecked CheckSettings

instance GenValid CheckSettings where
    genValid = CheckSettings <$> genValid

instance GenUnchecked CheckError

instance GenValid CheckError

instance GenUnchecked CheckResult where
    genUnchecked =
        oneof
            [ pure AlreadyDone
            , Ready <$> genUnchecked
            , Dirty <$> genUnchecked <*> genUnchecked <*> genUnchecked
            , Impossible <$> genUnchecked
            ]

instance GenValid CheckResult where
    genValid =
        oneof
            [ pure AlreadyDone
            , Ready <$> genValid
            , Dirty <$> genValid <*> genValid <*> genValid
            , Impossible <$> genValid
            ]

instance GenUnchecked Instruction

instance GenValid Instruction where
    genValid =
        oneof
            [ CopyFile <$> genValid <*> genValid
            , CopyDir <$> genValid <*> genValid
            , LinkFile <$> genValid <*> genValid
            , LinkDir <$> genValid <*> genValid
            ]

instance GenUnchecked CleanupInstruction

instance GenValid CleanupInstruction

instance GenUnchecked DeploymentCheckResult where
    genUnchecked =
        oneof
            [ pure DeploymentDone
            , ReadyToDeploy <$> genUnchecked
            , DirtySituation <$> genUnchecked <*> genUnchecked <*> genUnchecked
            , ImpossibleDeployment <$> genUnchecked
            ]

instance GenValid DeploymentCheckResult
