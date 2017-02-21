{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE RecordWildCards #-}

module SuperUserSpark.Check.Types where

import Import

import Data.Hashable

import SuperUserSpark.Bake.Types
import SuperUserSpark.Compiler.Types
import SuperUserSpark.CoreTypes
import SuperUserSpark.Diagnose.Types

data CheckAssignment = CheckAssignment
    { checkCardReference :: BakeCardReference
    , checkSettings :: CheckSettings
    } deriving (Show, Eq, Generic)

instance Validity CheckAssignment

data CheckSettings = CheckSettings
    { checkDiagnoseSettings :: DiagnoseSettings
    } deriving (Show, Eq, Generic)

instance Validity CheckSettings

defaultCheckSettings :: CheckSettings
defaultCheckSettings =
    CheckSettings {checkDiagnoseSettings = defaultDiagnoseSettings}

type SparkChecker = ExceptT CheckError (ReaderT CheckSettings IO)

data CheckError
    = CheckDiagnoseError DiagnoseError
    | CheckError String
    deriving (Show, Eq, Generic)

instance Validity CheckError

data Instruction =
    Instruction AbsP
                AbsP
                DeploymentKind
    deriving (Show, Eq, Generic)

instance Validity Instruction

data CleanupInstruction
    = CleanFile (Path Abs File)
    | CleanDirectory (Path Abs Dir)
    | CleanLink (Path Abs File)
    deriving (Show, Eq, Generic)

instance Validity CleanupInstruction

data DeploymentCheckResult
    = DeploymentDone -- ^ Done already
    | ReadyToDeploy Instruction -- ^ Immediately possible
    | DirtySituation String
                     Instruction
                     CleanupInstruction -- ^ Possible after cleanup of destination
    | ImpossibleDeployment [String] -- ^ Entirely impossible
    deriving (Show, Eq, Generic)

instance Validity DeploymentCheckResult

data CheckResult
    = AlreadyDone -- ^ Done already
    | Ready Instruction -- ^ Immediately possible
    | Dirty String
            Instruction
            CleanupInstruction -- ^ Possible after cleanup
    | Impossible String -- ^ Entirely impossible
    deriving (Show, Eq, Generic)

instance Validity CheckResult
