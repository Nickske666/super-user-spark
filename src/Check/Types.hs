module Check.Types where

import           CoreTypes
import           Data.Digest.Pure.MD5 (MD5Digest (..))

type HashDigest = MD5Digest

data Diagnostics
    = Nonexistent
    | IsFile
    | IsDirectory
    | IsLinkTo FilePath
    | IsWeird
    deriving (Show, Eq)

data DiagnosedFp = D FilePath Diagnostics HashDigest
    deriving (Show, Eq)


data CheckResult = AlreadyDone
                 | Ready
                 | Dirty String
    deriving (Show, Eq)

data DiagnosedDeployment = Diagnosed
    { diagnosedSrcs :: [DiagnosedFp]
    , diagnosedDst  :: DiagnosedFp
    , diagnosedKind :: DeploymentKind
    } deriving (Show, Eq)

