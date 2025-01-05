import Toybox.WatchUi;
import Toybox.Lang;

class SettingsMenuBuilder {
    private var settings as SettingsController;

    function initialize(settings as SettingsController) {
        self.settings = settings;
    }

    public function build() as WatchUi.Menu2 {
        var menu = new WatchUi.Menu2({ :title => Rez.Strings.settingsTitle });

        menu.addItem(
            new MenuItem(
                Rez.Strings.settingsActivityType,
                self.settings.activityTypeRes(),
                SettingsMenuDelegate.ACTIVITY_UPDATE,
                {}
            )
        );

        menu.addItem(
            new MenuItem(
                Rez.Strings.settingsUnitsSpeed,
                self.settings.unitsSpeedRes(),
                SettingsMenuDelegate.UNITS_SPEED_UPDATE,
                {}
            )
        );

        return menu;
    }

    
}