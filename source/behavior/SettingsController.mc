import Toybox.Lang;

class SettingsController {
    public static const ACTIVITY_WINDSURFING = 1;
    public static const ACTIVITY_KITESURFING = 2;
    public static const ACTIVITY_SURFING = 3;
    public static const ACTIVITY_OPENWATER_SWIMMING = 4;
    public static const ACTIVITY_OTHER = 0;

    public function activityType() as Number {
        var value = Application.Properties.getValue("activityType");

        switch (value) {
            case 1: return ACTIVITY_WINDSURFING;
            case 2: return ACTIVITY_KITESURFING;
            case 3: return ACTIVITY_SURFING;
            case 4: return ACTIVITY_OPENWATER_SWIMMING;
            default: return ACTIVITY_OTHER;
        }
    }

    public function activityTypeRes() as ResourceId {

        switch (self.activityType()) {
            case SettingsController.ACTIVITY_WINDSURFING: 
                return Rez.Strings.settingsActivityTypeWindsurfing;
            case SettingsController.ACTIVITY_KITESURFING: 
                return Rez.Strings.settingsActivityTypeKitesurfing;
            case SettingsController.ACTIVITY_SURFING: 
                return Rez.Strings.settingsActivityTypeSurfing;
            case SettingsController.ACTIVITY_OPENWATER_SWIMMING: 
                return Rez.Strings.settingsActivityTypeOpenwaterSwimming;
            default: 
                return Rez.Strings.settingsActivityTypeOther;
        }
    }

    public function toggleActivityType() as Void {
        var curValue = Application.Properties.getValue("activityType");
        var nextValue = (curValue + 1) % 5;
        Application.Properties.setValue("activityType", nextValue);
    }
}