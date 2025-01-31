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

    public static const UNITS_DISTANCE_UNSET = 9;
    public static const UNITS_DISTANCE_METERS = 0;
    public static const UNITS_DISTANCE_MILES = 1;
    public static const UNITS_DISTANCE_DONOTUSE_UPPER_LIMIT = 2;

    public static const BACKGROUND_UNSET = 9;
    public static const BACKGROUND_BLACK = 0;
    public static const BACKGROUND_WHITE = 1;
    public static const BACKGROUND_DONOTUSE_UPPER_LIMIT = 2;

    function initialize() {
        self.applyFromStorage();
    }

    public function applyFromStorage() as Void {
        self.setDefaultUnitsSpeed();
        self.setDefaultUnitsDistance();
        self.setDefaultBackground();

        self.applyBackground();
    }

    private function setDefaultUnitsSpeed() as Void {
        var current = Application.Properties.getValue("unitsSpeed");
        if (current != UNITS_SPEED_UNSET && current != null) {
            return;
        }
        
        var value = UNITS_SPEED_KMH;
        if (System.getDeviceSettings().distanceUnits == System.UNIT_STATUTE) {
            value = UNITS_SPEED_MPH;
        }

        Application.Properties.setValue("unitsSpeed", value);
    }

    private function setDefaultUnitsDistance() as Void {
        var current = Application.Properties.getValue("unitsDistance");
        if (current != UNITS_DISTANCE_UNSET && current != null) {
            return;
        }
        
        var value = UNITS_DISTANCE_METERS;
        if (System.getDeviceSettings().distanceUnits == System.UNIT_STATUTE) {
            value = UNITS_DISTANCE_MILES;
        }

        Application.Properties.setValue("unitsDistance", value);
    }

    private function setDefaultBackground() as Void {
        var current = Application.Properties.getValue("background");
        if (current != BACKGROUND_UNSET && current != null) {
            return;
        }
        
        var value = BACKGROUND_WHITE;
        if (System has :getDisplayMode) {
            value = BACKGROUND_BLACK;
        }

        Application.Properties.setValue("background", value);
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

    public function toggleActivityType() as Void {
        var curValue = Application.Properties.getValue("activityType");
        var nextValue = (curValue + 1) % SettingsController.ACTIVITY_DONOTUSE_UPPER_LIMIT;
        Application.Properties.setValue("activityType", nextValue);
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

    public function toggleUnitsSpeed() as Void {
        var curValue = Application.Properties.getValue("unitsSpeed");
        var nextValue = (curValue + 1) % SettingsController.UNITS_SPEED_DONOTUSE_UPPER_LIMIT;
        Application.Properties.setValue("unitsSpeed", nextValue);
    }

    public function distance() as Number {
        var value = Application.Properties.getValue("unitsDistance");

        switch (value) {
            case 0: return UNITS_DISTANCE_METERS;
            case 1: return UNITS_DISTANCE_MILES;
            default: return UNITS_DISTANCE_METERS;
        }
    }

    public function toggleUnitsDistance() as Void {
        var curValue = Application.Properties.getValue("unitsDistance");
        var nextValue = (curValue + 1) % SettingsController.UNITS_DISTANCE_DONOTUSE_UPPER_LIMIT;
        Application.Properties.setValue("unitsDistance", nextValue);
    }

    public function unitsDistanceRes() as ResourceId {

        switch (self.distance()) {
            case SettingsController.UNITS_DISTANCE_METERS: 
                return Rez.Strings.settingsUnitsDistanceMeters;
            case SettingsController.UNITS_DISTANCE_MILES: 
                return Rez.Strings.settingsUnitsDistanceMiles;
            default: 
                return Rez.Strings.settingsUnitsDistanceMeters;
        }
    }

    public function background() as Number {
        var value = Application.Properties.getValue("background");

        switch (value) {
            case 0: return BACKGROUND_BLACK;
            case 1: return BACKGROUND_WHITE;
            default: return BACKGROUND_BLACK;
        }
    }

    public function toggleBackground() as Void {
        var curValue = Application.Properties.getValue("background");
        var nextValue = (curValue + 1) % SettingsController.BACKGROUND_DONOTUSE_UPPER_LIMIT;
        Application.Properties.setValue("background", nextValue);

        self.applyBackground();
    }

    public function backgroundRes() as ResourceId {

        switch (self.background()) {
            case SettingsController.BACKGROUND_BLACK: 
                return Rez.Strings.settingsBackgroundBlack;
            case SettingsController.BACKGROUND_WHITE: 
                return Rez.Strings.settingsBackgroundWhite;
            default: 
                return Rez.Strings.settingsBackgroundBlack;
        }
    }

    private function applyBackground() as Void {
        switch (self.background()) {
            case SettingsController.BACKGROUND_WHITE:
                Utils.Colors.switchToWhiteBackground();
                break;
            default: 
            case SettingsController.BACKGROUND_BLACK: 
                Utils.Colors.switchToBlackBackground();
                break;
        }
    }
}