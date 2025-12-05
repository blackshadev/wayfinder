import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class WindDirectionMenuDelegate extends WatchUi.Menu2InputDelegate {
    public static const WIND_UNSET = "wind_unset";
    public static const WIND_FORECAST = "wind_forecast";
    public static const WIND_FLIP = "wind_flip";
    public static const WIND_SET_CURRENT = "wind_set_current";
    public static const WIND_SET_AWAY = "wind_set_away";

    private var windController as WindDirectionControllerInterface;

    function initialize(windController as WindDirectionControllerInterface) {
        Menu2InputDelegate.initialize();
        self.windController = windController;
    }

    function onSelect(item as MenuItem) as Void {
        var id = item.getId() as String;
        switch (id) {
            case WIND_UNSET:
                self.windController.unsetWindDirection();
                self.backToMainView();
                return;
            case WIND_FORECAST:
                self.windController.setForecastWindDirection();
                self.backToMainView();
                return;
            case WIND_FLIP:
                self.windController.flipWindDirection();
                self.backToMainView();
                return;
            case WIND_SET_CURRENT:
                self.windController.setWindToCurrentDirection();
                self.backToMainView();
                return;
            case WIND_SET_AWAY:
                self.windController.setWindAwayFromCurrentDirection();
                self.backToMainView();
                return;
            default:
                System.println("No action for id " + id);
        }
    }

    private function backToMainView() as Void {
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }
}
