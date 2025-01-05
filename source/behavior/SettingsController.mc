import Toybox.Lang;
import Toybox.System;
import Toybox.Application;

class SettingsController {
    public static const ACTIVITY_WINDSURFING = 1;
    public static const ACTIVITY_KITESURFING = 2;
    public static const ACTIVITY_SURFING = 3;
    public static const ACTIVITY_OPENWATER_SWIMMING = 4;
    public static const ACTIVITY_DONOTUSE_UPPER_LIMIT = 5;
    public static const ACTIVITY_OTHER = 0;

    public static const UNITS_SPEED_UNSET = 9;
    public static const UNITS_SPEED_KMH = 0;
    public static const UNITS_SPEED_MS = 1;
    public static const UNITS_SPEED_MPH = 2;
    public static const UNITS_SPEED_DONOTUSE_UPPER_LIMIT = 4;

    function initialize() {
        self.setDefaultUnitsSpeed();
    }

    private function setDefaultUnitsSpeed() as Void {
        
        if (Application.Properties.getValue("unitsSpeed") != UNITS_SPEED_UNSET) {
            return;
        }
        
        var value = UNITS_SPEED_KMH;
        if (System.getDeviceSettings().distanceUnits == System.UNIT_STATUTE) {
            value = UNITS_SPEED_MPH;
        }

        Application.Properties.setValue("unitsSpeed", value);
    }

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


    public function unitsSpeed() as Number {
        var value = Application.Properties.getValue("unitsSpeed");

        switch (value) {
            case 0: return UNITS_SPEED_KMH;
            case 1: return UNITS_SPEED_MS;
            case 2: return UNITS_SPEED_MPH;
            default: return UNITS_SPEED_KMH;
        }
    }

    public function unitsSpeedRes() as ResourceId {

        switch (self.unitsSpeed()) {
            case SettingsController.UNITS_SPEED_KMH: 
                return Rez.Strings.settingsUnitsSpeedkms;
            case SettingsController.UNITS_SPEED_MS: 
                return Rez.Strings.settingsUnitsSpeedms;
            case SettingsController.UNITS_SPEED_MPH: 
                return Rez.Strings.settingsUnitsSpeedmph;
            default: 
                return Rez.Strings.settingsUnitsSpeedkms;
        }
    }

    public function toggleActivityType() as Void {
        var curValue = Application.Properties.getValue("activityType");
        var nextValue = (curValue + 1) % SettingsController.ACTIVITY_DONOTUSE_UPPER_LIMIT;
        Application.Properties.setValue("activityType", nextValue);
    }

    public function toggleUnitsSpeed() as Void {
        var curValue = Application.Properties.getValue("unitsSpeed");
        var nextValue = (curValue + 1) % SettingsController.UNITS_SPEED_DONOTUSE_UPPER_LIMIT;
        Application.Properties.setValue("unitsSpeed", nextValue);
    }
}