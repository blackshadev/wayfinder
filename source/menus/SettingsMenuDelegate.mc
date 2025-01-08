import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class SettingsMenuDelegate extends WatchUi.Menu2InputDelegate {
    public static const ACTIVITY_UPDATE = "activity_update";
    public static const UNITS_SPEED_UPDATE = "units_speed_update";
    public static const UNITS_DISTANCE_UPDATE = "units_distance_update";
    public static const BACKGROUND_UPDATE = "background_update";

    private var settings as SettingsController;

    function initialize(settings as SettingsController) {
        Menu2InputDelegate.initialize();
        
        self.settings = settings;
    }

    function onSelect(item as MenuItem) as Void {
        var id = item.getId() as String; 

        switch (id) {
            case ACTIVITY_UPDATE:
                self.settings.toggleActivityType();
                item.setSubLabel(self.settings.activityTypeRes());
                return;
            case UNITS_SPEED_UPDATE:
                self.settings.toggleUnitsSpeed();
                item.setSubLabel(self.settings.unitsSpeedRes());
                return;
            case UNITS_DISTANCE_UPDATE:
                self.settings.toggleUnitsDistance();
                item.setSubLabel(self.settings.unitsDistanceRes());
                return;
            case BACKGROUND_UPDATE:
                self.settings.toggleBackground();
                item.setSubLabel(self.settings.backgroundRes());
                return;
        }
    }

    function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}