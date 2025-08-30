import Toybox.Lang;
import Toybox.System;
import Toybox.Application;

class SettingsController extends SettingsControllerInterface {

    function initialize() {
        SettingsControllerInterface.initialize();

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
        if (current != SettingsControllerInterface.SPEED_UNSET && current != null) {
            return;
        }
        
        var value = SettingsControllerInterface.SPEED_KMH;
        if (System.getDeviceSettings().distanceUnits == System.UNIT_STATUTE) {
            value = SettingsControllerInterface.SPEED_MPH;
        }

        Application.Properties.setValue("unitsSpeed", value);
    }

    private function setDefaultUnitsDistance() as Void {
        var current = Application.Properties.getValue("unitsDistance");
        if (current != SettingsControllerInterface.DISTANCE_UNSET && current != null) {
            return;
        }
        
        var value = SettingsControllerInterface.DISTANCE_METERS;
        if (System.getDeviceSettings().distanceUnits == System.UNIT_STATUTE) {
            value = SettingsControllerInterface.DISTANCE_MILES;
        }

        Application.Properties.setValue("unitsDistance", value);
    }

    private function setDefaultBackground() as Void {
        var current = Application.Properties.getValue("background");
        if (current != SettingsControllerInterface.BACKGROUND_UNSET && current != null) {
            return;
        }
        
        var value = SettingsControllerInterface.BACKGROUND_WHITE;
        if (System has :getDisplayMode) {
            value = SettingsControllerInterface.BACKGROUND_BLACK;
        }

        Application.Properties.setValue("background", value);
    }

    public function activityType() as SettingsControllerInterface.ActivityType {
        var value = Application.Properties.getValue("activityType");

        switch (value) {
            case 1: return SettingsControllerInterface.ACTIVITY_WINDSURFING;
            case 2: return SettingsControllerInterface.ACTIVITY_KITESURFING;
            case 3: return SettingsControllerInterface.ACTIVITY_SURFING;
            case 4: return SettingsControllerInterface.ACTIVITY_OPENWATER_SWIMMING;
            default: return SettingsControllerInterface.ACTIVITY_OTHER;
        }
    }

    public function activityTypeRes() as ResourceId {

        switch (self.activityType()) {
            case SettingsControllerInterface.ACTIVITY_WINDSURFING: 
                return Rez.Strings.settingsActivityTypeWindsurfing;
            case SettingsControllerInterface.ACTIVITY_KITESURFING: 
                return Rez.Strings.settingsActivityTypeKitesurfing;
            case SettingsControllerInterface.ACTIVITY_SURFING: 
                return Rez.Strings.settingsActivityTypeSurfing;
            case SettingsControllerInterface.ACTIVITY_OPENWATER_SWIMMING: 
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

    public function unitsSpeed() as SettingsControllerInterface.SpeedUnit {
        var value = Application.Properties.getValue("unitsSpeed");

        switch (value) {
            case 0: return SettingsControllerInterface.SPEED_KMH;
            case 1: return SettingsControllerInterface.SPEED_MS;
            case 2: return SettingsControllerInterface.SPEED_MPH;
            case 3: return SettingsControllerInterface.SPEED_KNOTS;
            default: return SettingsControllerInterface.SPEED_KMH;
        }
    }

    public function unitsSpeedRes() as ResourceId {

        switch (self.unitsSpeed()) {
            case SettingsControllerInterface.SPEED_KMH: 
                return Rez.Strings.settingsUnitsSpeedkms;
            case SettingsControllerInterface.SPEED_MS: 
                return Rez.Strings.settingsUnitsSpeedms;
            case SettingsControllerInterface.SPEED_MPH: 
                return Rez.Strings.settingsUnitsSpeedmph;
            case SettingsControllerInterface.SPEED_KNOTS: 
                return Rez.Strings.settingsUnitsSpeedknots;
            default: 
                return Rez.Strings.settingsUnitsSpeedkms;
        }
    }

    public function toggleUnitsSpeed() as Void {
        var curValue = Application.Properties.getValue("unitsSpeed");
        var nextValue = (curValue + 1) % SettingsControllerInterface.SPEED_DONOTUSE_UPPER_LIMIT;
        Application.Properties.setValue("unitsSpeed", nextValue);
    }

    public function distance() as SettingsControllerInterface.DistanceUnit {
        var value = Application.Properties.getValue("unitsDistance");

        switch (value) {
            case 0: return SettingsControllerInterface.DISTANCE_METERS;
            case 1: return SettingsControllerInterface.DISTANCE_MILES;
            default: return SettingsControllerInterface.DISTANCE_METERS;
        }
    }

    public function toggleUnitsDistance() as Void {
        var curValue = Application.Properties.getValue("unitsDistance");
        var nextValue = (curValue + 1) % SettingsControllerInterface.DISTANCE_DONOTUSE_UPPER_LIMIT;
        Application.Properties.setValue("unitsDistance", nextValue);
    }

    public function unitsDistanceRes() as ResourceId {

        switch (self.distance()) {
            case SettingsControllerInterface.DISTANCE_METERS: 
                return Rez.Strings.settingsUnitsDistanceMeters;
            case SettingsControllerInterface.DISTANCE_MILES: 
                return Rez.Strings.settingsUnitsDistanceMiles;
            default: 
                return Rez.Strings.settingsUnitsDistanceMeters;
        }
    }

    public function background() as SettingsControllerInterface.Background {
        var value = Application.Properties.getValue("background");

        switch (value) {
            case 0: return SettingsControllerInterface.BACKGROUND_BLACK;
            case 1: return SettingsControllerInterface.BACKGROUND_WHITE;
            default: return SettingsControllerInterface.BACKGROUND_BLACK;
        }
    }

    public function toggleBackground() as Void {
        var curValue = Application.Properties.getValue("background");
        var nextValue = (curValue + 1) % SettingsControllerInterface.BACKGROUND_DONOTUSE_UPPER_LIMIT;
        Application.Properties.setValue("background", nextValue);

        self.applyBackground();
    }

    public function backgroundRes() as ResourceId {

        switch (self.background()) {
            case SettingsControllerInterface.BACKGROUND_BLACK: 
                return Rez.Strings.settingsBackgroundBlack;
            case SettingsControllerInterface.BACKGROUND_WHITE: 
                return Rez.Strings.settingsBackgroundWhite;
            default: 
                return Rez.Strings.settingsBackgroundBlack;
        }
    }

    private function applyBackground() as Void {
        switch (self.background()) {
            case SettingsControllerInterface.BACKGROUND_WHITE:
                Utils.Colors.switchToWhiteBackground();
                break;
            default: 
            case SettingsControllerInterface.BACKGROUND_BLACK: 
                Utils.Colors.switchToBlackBackground();
                break;
        }
    }

    public function mapZoomDistance() as Number {
        var curValue = Application.Properties.getValue("mapZoomDistance");

        switch (curValue) {
            case 1000:
                return 1000;
            case 1500:
                return 1500;
            case 2000:
                return 2000;
            case 5000:
                return 5000;

            default:
                return 1000;
        }
    }

    public function mapZoomDistanceRes() as ResourceId {

        switch (self.mapZoomDistance()) {
            case 1000: 
                return Rez.Strings.settings1000m;
            case 1500:
                return Rez.Strings.settings1500m;
            case 2000:
                return Rez.Strings.settings2km;
            case 5000:
                return Rez.Strings.settings5km;
            
            default: 
                return Rez.Strings.settings1000m;
        }
    }

    public function toggleMapZoomDistance() as Void {
        var values = [1000, 1500, 2000, 5000];

        var curValue = self.mapZoomDistance();
        var nextIndex = (values.indexOf(curValue) + 1) % values.size();
        Application.Properties.setValue("mapZoomDistance", values[nextIndex]);
    }

    public function arrowSize() as SettingsControllerInterface.ArrowSize {
        var value = Application.Properties.getValue("arrowSize");

        switch (value) {
            case 0: return SettingsControllerInterface.ARROW_SIZE_NONE;
            case 1: return SettingsControllerInterface.ARROW_SIZE_SMALL;
            case 2: return SettingsControllerInterface.ARROW_SIZE_NORMAL;
            case 3: return SettingsControllerInterface.ARROW_SIZE_LARGE;
            case 4: return SettingsControllerInterface.ARROW_SIZE_EXTRA_LARGE;
            default: return SettingsControllerInterface.ARROW_SIZE_NORMAL;
        }
    }

    public function toggleArrowSize() as Void {
        var curValue = Application.Properties.getValue("arrowSize");
        var nextValue = (curValue + 1) % SettingsControllerInterface.ACTIVITY_DONOTUSE_UPPER_LIMIT;
        Application.Properties.setValue("arrowSize", nextValue);
    }

    public function arrowSizeRes() as ResourceId {
        switch (self.arrowSize()) {
            case SettingsControllerInterface.ARROW_SIZE_NONE: 
                return Rez.Strings.settingsArrowSizeNone;
            case SettingsControllerInterface.ARROW_SIZE_SMALL: 
                return Rez.Strings.settingsArrowSizeSmall;
            case SettingsControllerInterface.ARROW_SIZE_NORMAL: 
                return Rez.Strings.settingsArrowSizeNormal;
            case SettingsControllerInterface.ARROW_SIZE_LARGE: 
                return Rez.Strings.settingsArrowSizeLarge;
            case SettingsControllerInterface.ARROW_SIZE_EXTRA_LARGE: 
                return Rez.Strings.settingsArrowSizeExtraLarge;
                
            default: 
                return Rez.Strings.settingsArrowSizeNormal;
        }
    }

    public function arrowSizeValue() as Number {

        switch (self.arrowSize()) {
            case SettingsControllerInterface.ARROW_SIZE_NONE: 
                return 0;
            case SettingsControllerInterface.ARROW_SIZE_SMALL: 
                return 20;
            case SettingsControllerInterface.ARROW_SIZE_NORMAL: 
                return 30;
            case SettingsControllerInterface.ARROW_SIZE_LARGE: 
                return 45;
            case SettingsControllerInterface.ARROW_SIZE_EXTRA_LARGE: 
                return 60;

            default: 
                return 30;
        }
    }
}