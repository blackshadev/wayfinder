import Toybox.Lang;

class SettingsControllerInterface {
    private enum ActivityType {
        Windsurfing = 1,
        Kitesurfing = 2,
        Surfing = 3,
        OpenwaterSwimming = 4,
        OtherActivity = 0,
    }

    public static const ACTIVITY_WINDSURFING = Windsurfing;
    public static const ACTIVITY_KITESURFING = Kitesurfing;
    public static const ACTIVITY_SURFING = Surfing;
    public static const ACTIVITY_OPENWATER_SWIMMING = OpenwaterSwimming;
    public static const ACTIVITY_OTHER = OtherActivity;
    public static const ACTIVITY_DONOTUSE_UPPER_LIMIT = 5;

    private enum DistanceUnit {
        Meters = 0,
        Miles = 1,
    }

    public static const DISTANCE_METERS = Meters;
    public static const DISTANCE_MILES = Miles;
    public static const DISTANCE_UNSET = 9;
    public static const DISTANCE_DONOTUSE_UPPER_LIMIT = 2;

    private enum SpeedUnit {
        KMH = 0,
        MS = 1,
        MPH = 2,
        Knots = 3,
    }

    public static const SPEED_UNSET = 9;
    public static const SPEED_KMH = KMH;
    public static const SPEED_MS = MS;
    public static const SPEED_MPH = MPH;
    public static const SPEED_KNOTS = Knots;
    public static const SPEED_DONOTUSE_UPPER_LIMIT = 4;

    private enum Background {
        Black = 0,
        White = 1,
    }

    public static const BACKGROUND_UNSET = 9;
    public static const BACKGROUND_BLACK = Black;
    public static const BACKGROUND_WHITE = White;
    public static const BACKGROUND_DONOTUSE_UPPER_LIMIT = 2;

    private enum ArrowSize {
        None = 0,
        Small = 1,
        Normal = 2,
        Large = 3,
        ExtraLarge = 4,
    }

    public static const ARROW_SIZE_NONE = None;
    public static const ARROW_SIZE_SMALL = Small;
    public static const ARROW_SIZE_NORMAL = Normal;
    public static const ARROW_SIZE_LARGE = Large;
    public static const ARROW_SIZE_EXTRA_LARGE = ExtraLarge;
    public static const ARROW_SIZE_DONOTUSE_UPPER_LIMIT = 5;

    public function distance() as DistanceUnit {
        throw new NotImplemented();
    }

    public function unitsSpeed() as SpeedUnit {
        throw new NotImplemented();
    }

    public function arrowSize() as ArrowSize {
        throw new NotImplemented();
    }
}