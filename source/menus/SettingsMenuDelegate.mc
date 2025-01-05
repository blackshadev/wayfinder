import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class SettingsMenuDelegate extends WatchUi.Menu2InputDelegate {
    public static const ACTIVITY_UPDATE = "activity_update";
    public static const UNITS_SPEED_UPDATE = "units_speed_update";

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
        }
    }

    function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}